import SourceLocation
import XCTest

final class SourceLocationTests: XCTestCase {

    func test_inequality() throws {
        let y = SourceLocation.here()
        let z = SourceLocation.here()
        XCTAssertNotEqual(z, y)
    }

    func test_sameLine_inequality() throws {
        let (y, z) = (SourceLocation.here(), SourceLocation.here())
        XCTAssertNotEqual(z, y)
    }

    func test_funcParam_inequality() throws {
        func test(x: SourcePath = SourcePath.root(.here()), y: SourcePath = SourcePath.root(.here())) {
            XCTAssertNotEqual(x, y)
        }
        test()
    }

}
