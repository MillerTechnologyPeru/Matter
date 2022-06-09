import XCTest
@testable import Matter
@testable import Example

final class MatterTests: XCTestCase {
    
    func testExample() throws {
        print("Matter version: \(MatterVersion)")
        
    }
    
    func testError() {
        
        let error = MatterError(MatterError.sendingBlocked)
        
        XCTAssertEqual(error.message, "Error 0xE5E08318")
        
        do {
            throw error
        } catch MatterError.sendingBlocked {
            // caught error
        } catch {
            XCTFail("Did not catch error")
        }
    }
}
