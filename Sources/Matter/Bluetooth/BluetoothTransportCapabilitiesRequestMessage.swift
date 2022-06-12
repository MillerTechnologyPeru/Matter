//
//  BluetoothTransportCapabilitiesRequestMessage.swift
//  
//
//  Created by Alsey Coleman Miller on 6/11/22.
//

import Foundation
import Bluetooth

public struct BluetoothTransportCapabilitiesRequestMessage: Equatable, Hashable, Codable {
    
    /**
     * An array of size NUM_SUPPORTED_PROTOCOL_VERSIONS listing versions of the
     * BLE transport protocol that this node supports. Each protocol version is
     * specified as a 4-bit unsigned integer. A zero-value represents unused
     * array elements. Counting up from the zero-index, the first zero-value
     * specifies the end of the list of supported protocol versions.
     */
    public var supportedProtocolVersions: [BluetoothTransportProtocolVersion]
    
    /**
     *  The MTU that has been negotiated for this BLE connection. Specified in
     *  the BleTransportCapabilitiesRequestMessage because the remote node may
     *  be unable to glean this info from its own BLE hardware/software stack,
     *  such as on older Android platforms.
     *
     *  A value of 0 means that the central could not determine the negotiated
     *  BLE connection MTU.
     */
    public var maximumTransmissionUnit: UInt16
    
    /**
     *  The initial and maximum receive window size offered by the central,
     *  defined in terms of GATT indication payloads.
     */
    public var windowSize: UInt8
    
    
}
