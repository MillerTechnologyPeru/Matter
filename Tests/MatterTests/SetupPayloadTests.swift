//
//  SetupPayloadTests.swift
//  
//
//  Created by Alsey Coleman Miller on 6/9/22.
//

import Foundation
import XCTest
@testable import MatterPackage
#if canImport(Darwin)
import Matter
#endif

final class SetupPayloadTests: XCTestCase {
    
    func testQRCodeParser() throws {
        let base38String = "MT:R5L90MP500K64J00000"
        let payload = try SetupPayload(qrCode: base38String)
        XCTAssertEqual(payload.version, 5)
        XCTAssertEqual(payload.discriminator, 128)
        XCTAssertEqual(payload.setupPinCode, 2048)
        XCTAssertEqual(payload.vendorID, 12)
        XCTAssertEqual(payload.productID, 1)
        XCTAssertEqual(payload.commissioningFlow, .standard)
        XCTAssertEqual(payload.rendezvousInformation, [.softAP])
        XCTAssertEqual(try payload.generateQRCode(), base38String)
        
        #if canImport(Darwin)
        let chipPayload = try MTRQRCodeSetupPayloadParser(base38Representation: base38String).populatePayload()
        XCTAssertEqual(chipPayload.version.uint8Value, payload.version)
        XCTAssertEqual(chipPayload.discriminator.uint16Value, payload.discriminator)
        XCTAssertEqual(chipPayload.setUpPINCode.uint32Value, payload.setupPinCode)
        XCTAssertEqual(chipPayload.vendorID.uint16Value, payload.vendorID)
        XCTAssertEqual(chipPayload.productID.uint16Value, payload.productID)
        XCTAssertEqual(chipPayload.commissioningFlow.rawValue, numericCast(payload.commissioningFlow.rawValue))
        XCTAssertEqual(chipPayload.rendezvousInformation?.uint8Value, payload.rendezvousInformation?.rawValue)
        #endif
    }
    
    func testQRCodeParserWithOptionalData() throws {
        let base38String = "MT:R5L90MP500K64J0A33P0SET70.QT52B.E23-WZE0WISA0DK5N1K8SQ1RYCU1O0"
        let payload = try SetupPayload(qrCode: base38String)
        XCTAssertEqual(payload.version, 5)
        XCTAssertEqual(payload.discriminator, 128)
        XCTAssertEqual(payload.setupPinCode, 2048)
        XCTAssertEqual(payload.vendorID, 12)
        XCTAssertEqual(payload.productID, 1)
        XCTAssertEqual(payload.commissioningFlow, .standard)
        XCTAssertEqual(payload.rendezvousInformation, [.softAP])
        XCTAssertEqual(payload.serialNumber, "123456789")
        XCTAssertEqual(payload.vendorData, [
            QRCodeInfo(data: .string("myData"), tag: 130),
            QRCodeInfo(data: .int32(12), tag: 131),
        ])
        XCTAssertNoThrow(try payload.generateQRCode(), base38String)
    }
    
    func testQRCodeParserError() {
        let invalidString = "MT:R5L90MP500K64J0000."
        do {
            let _ = try SetupPayload(qrCode: invalidString)
            XCTFail("Invalid code")
        } catch MatterErrorCode(rawValue: 0x0000002F) {
            
        } catch {
            XCTFail("Invalid error \(error)")
        }
        
        #if canImport(Darwin)
        XCTAssertThrowsError(try MTRQRCodeSetupPayloadParser(base38Representation: invalidString).populatePayload())
        #endif
    }
    
    func testManualCodeParser() throws {
        let string = "636108753500001000015"
        let payload = try SetupPayload(manual: string)
        XCTAssertEqual(payload.version, 0)
        XCTAssertEqual(payload.discriminator, 2560)
        XCTAssertEqual(payload.setupPinCode, 123456780)
        XCTAssertEqual(payload.vendorID, 1)
        XCTAssertEqual(payload.productID, 1)
        XCTAssertEqual(payload.commissioningFlow, .custom)
        XCTAssertEqual(payload.rendezvousInformation, [])
        XCTAssertEqual(try payload.generateManualCode(), string)
        
        #if canImport(Darwin)
        let chipPayload = try MTRManualSetupPayloadParser(decimalStringRepresentation: string).populatePayload()
        XCTAssertEqual(chipPayload.version.uint8Value, payload.version)
        //XCTAssertEqual(chipPayload.discriminator.uint16Value, payload.discriminator)
        XCTAssertEqual(chipPayload.setUpPINCode.uint32Value, payload.setupPinCode)
        XCTAssertEqual(chipPayload.vendorID.uint16Value, payload.vendorID)
        XCTAssertEqual(chipPayload.productID.uint16Value, payload.productID)
        XCTAssertEqual(chipPayload.commissioningFlow.rawValue, numericCast(payload.commissioningFlow.rawValue))
        //XCTAssertEqual(chipPayload.rendezvousInformation?.uint8Value, payload.rendezvousInformation.rawValue)
        #endif
    }
    
    func testManualCodeParserError() {
        let invalidString = "abc"
        do {
            let _ = try SetupPayload(qrCode: invalidString)
            XCTFail("Invalid code")
        } catch MatterErrorCode(rawValue: 0x0000002F) {
            
        } catch {
            XCTFail("Invalid error \(error)")
        }
        
        #if canImport(Darwin)
        XCTAssertThrowsError(try MTRManualSetupPayloadParser(decimalStringRepresentation: invalidString).populatePayload())
        #endif
    }
}
