import XCTest
@testable import Matter
#if canImport(CHIP)
import CHIP
#endif

final class MatterTests: XCTestCase {
    
    func testVersion() throws {
        print("Matter version: \(MatterVersion.current.versionString)")
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
}
