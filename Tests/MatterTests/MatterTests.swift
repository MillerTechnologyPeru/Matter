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
        
        do {
            throw error
        } catch MatterError.sendingBlocked {
            // caught error
        } catch {
            XCTFail("Did not catch error")
        }
    }
}
