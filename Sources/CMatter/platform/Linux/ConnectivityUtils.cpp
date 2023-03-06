/*
 *
 *    Copyright (c) 2021-2022 Project CHIP Authors
 *
 *    Licensed under the Apache License, Version 2.0 (the "License");
 *    you may not use this file except in compliance with the License.
 *    You may obtain a copy of the License at
 *
 *        http://www.apache.org/licenses/LICENSE-2.0
 *
 *    Unless required by applicable law or agreed to in writing, software
 *    distributed under the License is distributed on an "AS IS" BASIS,
 *    WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 *    See the License for the specific language governing permissions and
 *    limitations under the License.
 */

/**
 *    @file
 *          Utilities for accessing parameters of the network interface and the wireless
 *          statistics(extracted from /proc/net/wireless) on Linux platforms.
 */

#include <app-common/zap-generated/enums.h>
#include <platform/Linux/ConnectivityUtils.h>
#include <platform/internal/CHIPDeviceLayerInternal.h>

#include <arpa/inet.h>
#include <ifaddrs.h>
#include <netdb.h>
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <sys/ioctl.h>
#include <sys/socket.h>
#include <sys/types.h>
#include <unistd.h>

#include <lib/core/CHIPEncoding.h>
#include <lib/support/CHIPMemString.h>
#include <lib/support/CodeUtils.h>

#ifdef __linux__
#include <linux/ethtool.h>
#include <linux/if_link.h>
#include <linux/sockios.h>
#include <linux/wireless.h>
#endif

using namespace ::chip::app::Clusters::GeneralDiagnostics;

namespace chip {
namespace DeviceLayer {
namespace Internal {

InterfaceTypeEnum ConnectivityUtils::GetInterfaceConnectionType(const char * ifname)
{
#ifdef __linux__
    InterfaceTypeEnum ret = InterfaceTypeEnum::EMBER_ZCL_INTERFACE_TYPE_ENUM_UNSPECIFIED;
    int sock              = -1;

    if ((sock = socket(AF_INET, SOCK_STREAM, 0)) == -1)
    {
        ChipLogError(DeviceLayer, "Failed to open socket");
        return InterfaceTypeEnum::EMBER_ZCL_INTERFACE_TYPE_ENUM_UNSPECIFIED;
    }

    // Test wireless extensions for CONNECTION_WIFI
    struct iwreq pwrq = {};
    Platform::CopyString(pwrq.ifr_name, ifname);

    if (ioctl(sock, SIOCGIWNAME, &pwrq) != -1)
    {
        ret = InterfaceTypeEnum::EMBER_ZCL_INTERFACE_TYPE_ENUM_WI_FI;
    }
    else if ((strncmp(ifname, "en", 2) == 0) || (strncmp(ifname, "eth", 3) == 0))
    {
        struct ethtool_cmd ecmd = {};
        ecmd.cmd                = ETHTOOL_GSET;
        struct ifreq ifr        = {};
        ifr.ifr_data            = reinterpret_cast<char *>(&ecmd);
        Platform::CopyString(ifr.ifr_name, ifname);

        if (ioctl(sock, SIOCETHTOOL, &ifr) != -1)
            ret = InterfaceTypeEnum::EMBER_ZCL_INTERFACE_TYPE_ENUM_ETHERNET;
    }

    close(sock);

    return ret;
#else
    return InterfaceTypeEnum::EMBER_ZCL_INTERFACE_TYPE_ENUM_ETHERNET;
#endif
}

CHIP_ERROR ConnectivityUtils::GetEthInterfaceName(char * ifname, size_t bufSize)
{
    CHIP_ERROR err          = CHIP_ERROR_READ_FAILED;
    struct ifaddrs * ifaddr = nullptr;

    if (getifaddrs(&ifaddr) == -1)
    {
        ChipLogError(DeviceLayer, "Failed to get network interfaces");
    }
    else
    {
        struct ifaddrs * ifa = nullptr;

        /* Walk through linked list, maintaining head pointer so we
          can free list later */
        for (ifa = ifaddr; ifa != nullptr; ifa = ifa->ifa_next)
        {
            if (GetInterfaceConnectionType(ifa->ifa_name) == InterfaceTypeEnum::EMBER_ZCL_INTERFACE_TYPE_ENUM_ETHERNET)
            {
                Platform::CopyString(ifname, bufSize, ifa->ifa_name);
                err = CHIP_NO_ERROR;
                break;
            }
        }

        freeifaddrs(ifaddr);
    }

    return err;
}

} // namespace Internal
} // namespace DeviceLayer
} // namespace chip
