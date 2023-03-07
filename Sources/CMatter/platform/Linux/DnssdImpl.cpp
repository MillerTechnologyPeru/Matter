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

#include <lib/core/CHIPCore.h>
#include "DnssdImpl.h"
#include "lib/dnssd/platform/Dnssd.h"
#include "app/AppDNSSD.h"

namespace chip {
namespace Dnssd {

CHIP_ERROR ChipDnssdInit(DnssdAsyncReturnCallback initCallback, DnssdAsyncReturnCallback errorCallback, void * context)
{
    return ChipError(CHIPDNSSDInit(initCallback, errorCallback, context));
}

void ChipDnssdShutdown() { }

CHIP_ERROR ChipDnssdPublishService(const DnssdService * service, DnssdPublishCallback callback, void * context)
{
    return CHIP_ERROR(CHIPDNSSDPublishService(service, callback, context));
}

CHIP_ERROR ChipDnssdRemoveServices()
{
    return CHIP_NO_ERROR;
}

CHIP_ERROR ChipDnssdFinalizeServiceUpdate()
{
    return CHIP_NO_ERROR;
}

CHIP_ERROR ChipDnssdBrowse(const char * type, DnssdServiceProtocol protocol,
                           chip::Inet::IPAddressType addressType,
                           chip::Inet::InterfaceId interface,
                           DnssdBrowseCallback callback, void * context,
                           intptr_t * browseIdentifier)
{
    
    return CHIP_ERROR_NOT_IMPLEMENTED;
}

CHIP_ERROR ChipDnssdStopBrowse(intptr_t browseIdentifier)
{
    return CHIP_ERROR_NOT_IMPLEMENTED;
}

CHIP_ERROR ChipDnssdResolve(DnssdService * browseResult, chip::Inet::InterfaceId interface, DnssdResolveCallback callback,
                            void * context)

{
    return CHIP_ERROR_NOT_IMPLEMENTED;
}

void ChipDnssdResolveNoLongerNeeded(const char * instanceName)
{
    
}

CHIP_ERROR ChipDnssdReconfirmRecord(const char * hostname, chip::Inet::IPAddress address, chip::Inet::InterfaceId interface)
{
    return CHIP_ERROR_NOT_IMPLEMENTED;
}

void GetMdnsTimeout(timeval & timeout) { }

void HandleMdnsTimeout() { }

} // namespace Dnssd
} // namespace chip
