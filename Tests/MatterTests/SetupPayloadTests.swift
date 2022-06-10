//
//  File.swift
//  
//
//  Created by Alsey Coleman Miller on 6/9/22.
//

import Foundation
import XCTest
@testable import Matter

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
    }
    
    func testQRCodeParserError() {
        let invalidString = "MT:R5L90MP500K64J0000."
        do {
            let _ = try SetupPayload.qrCode(base38Encoded: invalidString)
            XCTFail("Invalid code")
        } catch MatterErrorCode(rawValue: 0x0000002F) {
            return
        } catch {
            XCTFail("Invalid error \(error)")
        }
    }
}
