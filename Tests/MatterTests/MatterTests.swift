import XCTest
@testable import Matter

final class MatterTests: XCTestCase {
    
    func testExample() throws {
        print("Matter version: \(MatterVersion)")
        
    }
    
    func testError() {
        
        let error = MatterError(MatterError.sendingBlocked)
        
        XCTAssertEqual(error.code, MatterError.sendingBlocked)
        XCTAssertEqual(error.message, "Error 0x00000001")
        XCTAssertNotEqual(MatterError(MatterError.sendingBlocked), MatterError(MatterError.connectionAborted))
        
        do {
            throw error
        } catch MatterError.sendingBlocked {
            // caught error
        } catch {
            XCTFail("Did not catch error")
        }
    }
    
    func testSetupPayload() {
        // verify CoW mutations
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
}
