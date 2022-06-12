//
//  TransportCapabilitiesResponseMessage.swift
//  
//
//  Created by Alsey Coleman Miller on 6/11/22.
//

import Foundation

public struct BluetoothTransportCapabilitiesResponseMessage {
    
    /**
     *  The lower 4 bits specify the BLE transport protocol version that the BLE
     *  peripheral has selected for this connection.
     *
     *  A value of kBleTransportProtocolVersion_None means that no supported
     *  protocol version was found in the central's capabilities request. The
     *  central should unsubscribe after such a response has been sent to free
     *  up the peripheral for connections from devices with supported protocol
     *  versions.
     */
    public var selectedProtocolVersion: BluetoothTransportProtocolVersion
    
    /**
     *  BLE transport fragment size selected by peripheral in response to MTU
     *  value in BleTransportCapabilitiesRequestMessage and its local
     *  observation of the BLE connection MTU.
     */
    public var fragmentSize: UInt16
    
    /**
     *  The initial and maximum receive window size offered by the peripheral,
     *  defined in terms of GATT write payloads.
     */
    public var windowSize: UInt8
}
