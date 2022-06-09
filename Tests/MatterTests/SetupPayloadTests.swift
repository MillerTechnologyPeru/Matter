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
    
    func testCopyOnWrite() {
        let setupPayloadA = Matter.SetupPayload()
        var setupPayloadB = setupPayloadA
        XCTAssertEqual(setupPayloadA, setupPayloadB)
        XCTAssertEqual(setupPayloadA.version, setupPayloadB.version)
        XCTAssert(setupPayloadA.handle === setupPayloadB.handle)
        XCTAssert(setupPayloadA.handle.uncopiedReference() === setupPayloadB.handle.uncopiedReference())
        setupPayloadB.version = .max
        XCTAssertNotEqual(setupPayloadA, setupPayloadB)
        XCTAssertNotEqual(setupPayloadA.version, setupPayloadB.version)
        XCTAssertFalse(setupPayloadA.handle === setupPayloadB.handle)
        XCTAssertFalse(setupPayloadA.handle.uncopiedReference() === setupPayloadB.handle.uncopiedReference())
        XCTAssert(setupPayloadA.handle.uncopiedReference().allOptionalVendorData.isEmpty)
    }
    
    func testQRCodeParser() throws {
        let base38String = "MT:R5L90MP500K64J00000"
        let payload = try SetupPayload.qrCode(base38Encoded: base38String)
        XCTAssertEqual(payload.version, 5)
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
