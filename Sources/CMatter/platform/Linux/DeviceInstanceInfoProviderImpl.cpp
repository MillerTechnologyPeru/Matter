//
//  DeviceInstanceInfoProvider.cpp
//  
//
//  Created by Alsey Coleman Miller on 7/17/22.
//

#include "platform/Linux/DeviceInstanceInfoProviderImpl.h"
#include "app/AppDeviceInstanceInfoProvider.h"

CHIP_ERROR chip::DeviceLayer::DeviceInstanceInfoProviderImpl::GetSerialNumber(char * buf, size_t bufSize)
{
    return CHIP_ERROR(CHIPDeviceInstanceInfoProviderGetSerialNumber(buf, bufSize));
}

CHIP_ERROR chip::DeviceLayer::DeviceInstanceInfoProviderImpl::GetManufacturingDate(uint16_t & year, uint8_t & month, uint8_t & day)
{
    return CHIP_ERROR(CHIPDeviceInstanceInfoProviderGetManufacturingDate(&year, &month, &day));
}

CHIP_ERROR chip::DeviceLayer::DeviceInstanceInfoProviderImpl::GetHardwareVersion(uint16_t & hardwareVersion)
{
    return CHIP_ERROR(CHIPDeviceInstanceInfoProviderGetHardwareVersion(&hardwareVersion));
}
