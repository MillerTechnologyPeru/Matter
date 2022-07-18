//
//  DeviceInstanceInfoProvider.hpp
//  
//
//  Created by Alsey Coleman Miller on 7/17/22.
//

#ifndef DeviceInstanceInfoProvider_h
#define DeviceInstanceInfoProvider_h

#include <platform/DeviceInstanceInfoProvider.h>

namespace chip {
namespace DeviceLayer {

class DeviceInstanceInfoProviderImpl : public DeviceInstanceInfoProvider
{
    CHIP_ERROR GetSerialNumber(char * buf, size_t bufSize) override;
    
    CHIP_ERROR GetManufacturingDate(uint16_t & year, uint8_t & month, uint8_t & day) override;
    
    CHIP_ERROR GetHardwareVersion(uint16_t & hardwareVersion) override;
};

}
}
#endif /* DeviceInstanceInfoProvider_hpp */
