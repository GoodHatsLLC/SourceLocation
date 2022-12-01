import SourceLocation
import XCTest

final class SourcePathTests: XCTestCase {

    struct TestStruct {
        let codeLoc = SourcePath.root(.here())
    }

    func test_inequality() throws {
        let y = SourcePath.root(.here())
        let z = SourcePath.root(.here())
        XCTAssertNotEqual(z, y)
    }

    func test_sameLine_inequality() throws {
        let (y, z) = (SourcePath.root(.here()), SourcePath.root(.here()))
        XCTAssertNotEqual(z, y)
    }

    func test_funcParam_inequality() throws {
        func test(x: SourcePath = SourcePath.root(.here()), y: SourcePath = SourcePath.root(.here())) {
            XCTAssertNotEqual(x, y)
        }
        test()
    }

    func test_across_instance_equality() throws {
        let x = TestStruct()
        let y = TestStruct()

        XCTAssertEqual(x.codeLoc, y.codeLoc)
    }

}
