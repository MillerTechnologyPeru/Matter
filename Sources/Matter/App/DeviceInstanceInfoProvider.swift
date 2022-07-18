//
//  DeviceInstanceInfoProvider.swift
//  
//
//  Created by Alsey Coleman Miller on 7/17/22.
//

@_implementationOnly import CMatter

public protocol DeviceInstanceInfoProvider {
    
    var serialNumber: String { get throws }
    
    var manufacturingDate: (year: UInt16, month: UInt8, day: UInt8) { get throws }
    
    var hardwareVersion: UInt16 { get throws }
}

// MARK: - Callbacks

// extern "C" uint32_t CHIPDeviceInstanceInfoProviderGetSerialNumber(char * buf, size_t bufSize);
@_silgen_name("CHIPDeviceInstanceInfoProviderGetSerialNumber")
internal func CHIPDeviceInstanceInfoProviderGetSerialNumber(_ stringPointer: UnsafeMutablePointer<Int8>, _ size: Int) -> UInt32 {
    do {
        let serialNumber = try MatterAppCache.app.deviceInfo.serialNumber
        guard serialNumber.utf8CString.count < size else {
            return MatterError.bufferTooSmall.rawValue
        }
        serialNumber.withCString {
            stringPointer.assign(from: $0, count: serialNumber.utf8CString.count + 1)
        }
    }
    catch let error as MatterError {
        return error.code.rawValue
    }
    catch {
        return MatterErrorCode.sdk(.application, code: 0).rawValue
    }
    return 0
}

// extern "C" uint32_t CHIPDeviceInstanceInfoProviderGetManufacturingDate(uint16_t *year, uint8_t *month, uint8_t *day);
@_silgen_name("CHIPDeviceInstanceInfoProviderGetManufacturingDate")
internal func CHIPDeviceInstanceInfoProviderGetManufacturingDate(
    _ year: UnsafeMutablePointer<UInt16>,
    _ month: UnsafeMutablePointer<UInt8>,
    _ day: UnsafeMutablePointer<UInt8>
) -> UInt32 {
    do {
        let date = try MatterAppCache.app.deviceInfo.manufacturingDate
        year.pointee = date.year
        month.pointee = date.month
        day.pointee = date.day
    }
    catch let error as MatterError {
        return error.code.rawValue
    }
    catch {
        return MatterErrorCode.sdk(.application, code: 0).rawValue
    }
    return 0
}

// extern "C" uint32_t CHIPDeviceInstanceInfoProviderGetHardwareVersion(uint16_t *hardwareVersion);
@_silgen_name("CHIPDeviceInstanceInfoProviderGetHardwareVersion")
internal func CHIPDeviceInstanceInfoProviderGetHardwareVersion(_ hardwareVersion: UnsafeMutablePointer<UInt16>) -> UInt32 {
    do {
        let version = try MatterAppCache.app.deviceInfo.hardwareVersion
        hardwareVersion.pointee = version
    }
    catch let error as MatterError {
        return error.code.rawValue
    }
    catch {
        return MatterErrorCode.sdk(.application, code: 0).rawValue
    }
    return 0
}
