//
//  AppConfigManager.h
//  
//
//  Created by Alsey Coleman Miller on 7/17/22.
//

#ifndef AppConfigManager_h
#define AppConfigManager_h

#import <stdint.h>

extern "C" uint32_t CHIPConfigurationManagerGetVendorId(uint16_t *vendorId);

extern "C" uint32_t CHIPConfigurationManagerGetProductId(uint16_t *productId);


#endif /* Header_h */
