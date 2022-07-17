/*
 *
 *    Copyright (c) 2021 Project CHIP Authors
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

#pragma once

#include <platform/DiagnosticDataProvider.h>
#include <platform/internal/CHIPDeviceLayerInternal.h>

#ifdef __linux__
#include <linux/types.h> /* for "caddr_t" et al      */
#include <linux/wireless.h>
#endif

namespace chip {
namespace DeviceLayer {
namespace Internal {

class ConnectivityUtils
{
public:
    static CHIP_ERROR GetEthInterfaceName(char * ifname, size_t bufSize);
    static app::Clusters::GeneralDiagnostics::InterfaceType GetInterfaceConnectionType(const char * ifname);
};

} // namespace Internal
} // namespace DeviceLayer
} // namespace chip
