//
//  Header.h
//  
//
//  Created by Alsey Coleman Miller on 7/17/22.
//

#ifndef AppDeviceInstanceInfoProvider_h
#define AppDeviceInstanceInfoProvider_h

extern "C" uint32_t CHIPDeviceInstanceInfoProviderGetSerialNumber(char * buf, size_t bufSize);

extern "C" uint32_t CHIPDeviceInstanceInfoProviderGetManufacturingDate(uint16_t *year, uint8_t *month, uint8_t *day);

extern "C" uint32_t CHIPDeviceInstanceInfoProviderGetHardwareVersion(uint16_t *hardwareVersion);

#endif /* Header_h */
