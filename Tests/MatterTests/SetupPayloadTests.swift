//
//  SetupPayloadTests.swift
//  
//
//  Created by Alsey Coleman Miller on 6/9/22.
//

import Foundation
import XCTest
@testable import Matter
#if canImport(CHIP)
import CHIP
#endif

final class SetupPayloadTests: XCTestCase {
    
    func testQRCodeParser() throws {
        let base38String = "MT:R5L90MP500K64J00000"
        let payload = try SetupPayload.qrCode(base38Encoded: base38String)
        XCTAssertEqual(payload.version, 5)
        XCTAssertEqual(payload.discriminator, 128)
        XCTAssertEqual(payload.setupPinCode, 2048)
        XCTAssertEqual(payload.vendorID, 12)
        XCTAssertEqual(payload.productID, 1)
        XCTAssertEqual(payload.commissioningFlow, .standard)
        XCTAssertEqual(payload.rendezvousInformation, [.softAP])
        XCTAssertEqual(try payload.generateQRCode(allowInvalid: true), base38String)
        
        #if canImport(CHIP)
        let chipPayload = try CHIPQRCodeSetupPayloadParser(base38Representation: base38String).populatePayload()
        XCTAssertEqual(chipPayload.version.uint8Value, payload.version)
        XCTAssertEqual(chipPayload.discriminator.uint16Value, payload.discriminator)
        XCTAssertEqual(chipPayload.setUpPINCode.uint32Value, payload.setupPinCode)
        XCTAssertEqual(chipPayload.vendorID.uint16Value, payload.vendorID)
        XCTAssertEqual(chipPayload.productID.uint16Value, payload.productID)
        XCTAssertEqual(chipPayload.commissioningFlow.rawValue, numericCast(payload.commissioningFlow.rawValue))
        XCTAssertEqual(chipPayload.rendezvousInformation.rawValue, numericCast(payload.rendezvousInformation.rawValue))
        #endif
    }
    
    func testQRCodeParserError() {
        let invalidString = "MT:R5L90MP500K64J0000."
        do {
            let _ = try SetupPayload.qrCode(base38Encoded: invalidString)
            XCTFail("Invalid code")
        } catch MatterErrorCode(rawValue: 0x0000002F) {
            
        } catch {
            XCTFail("Invalid error \(error)")
        }
        
        #if canImport(CHIP)
        XCTAssertThrowsError(try CHIPQRCodeSetupPayloadParser(base38Representation: invalidString).populatePayload())
        #endif
    }
}
