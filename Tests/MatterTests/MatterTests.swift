import XCTest
@testable import MatterPackage
#if canImport(Darwin)
import Matter
#endif

final class MatterTests: XCTestCase {
    
    func testVersion() throws {
        print("Matter version: \(MatterVersion.current.versionString)")
    }
    
    func testError() {
        
        let error = MatterError(code: MatterError.sendingBlocked)
        
        XCTAssertEqual(error.code, MatterError.sendingBlocked)
        XCTAssertNotEqual(MatterError(code: MatterError.sendingBlocked), MatterError(code: MatterError.connectionAborted))
        
        do {
            throw error
        } catch MatterError.sendingBlocked {
            XCTAssertEqual(error.description, "CHIP Error 0x00000001: Sending blocked")
        } catch {
            XCTFail("Did not catch error")
        }
    }
}
