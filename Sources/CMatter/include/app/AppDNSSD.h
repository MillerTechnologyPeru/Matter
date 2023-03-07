//
//  Header.h
//  
//
//  Created by Alsey Coleman Miller on 3/6/23.
//

#ifndef AppDNSSD_h
#define AppDNSSD_h

#import <stdint.h>
#include "lib/dnssd/platform/Dnssd.h"

extern "C" typedef chip::Dnssd::DnssdAsyncReturnCallback CHIPDNSSDAsyncReturnCallback;

extern "C" typedef chip::Dnssd::DnssdPublishCallback CHIPDNSSDPublishCallback;

extern "C" typedef chip::Dnssd::DnssdService CHIPDNSSDService;

extern "C" uint32_t CHIPDNSSDInit(CHIPDNSSDAsyncReturnCallback initCallback, CHIPDNSSDAsyncReturnCallback errorCallback, void * context);

extern "C" uint32_t CHIPDNSSDPublishService(const CHIPDNSSDService * service, CHIPDNSSDPublishCallback callback, void * context);

#endif /* AppDNSSD_h */
