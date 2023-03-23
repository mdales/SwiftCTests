import XCTest
@testable import swiftctest

final class swiftctestTests: XCTestCase {
    func testSomeInt() {
        XCTAssertEqual(wrapSomeInt(val: 42), 42 * 42)
    }

    func testSomeIntModify() {
        var val = Int64(42);
        let res = wrapSomeIntModify(val: &val)
        XCTAssertEqual(res, 0, "Unexpected error")
        XCTAssertEqual(val, 42 * 42, "Unexpected result")
    }

    func testSomeSumIntArrayBad() {
        var values = [Int64](repeating: 42, count: 4)
        let res = wrapSomeSumIntArrayBad(values: &values)
        XCTAssertEqual(res, 42 * 4, "Incorrect value returned")
    }

    func testSomeSumIntArray() {
        let values = [Int64](repeating: 42, count: 4)
        let res = wrapSomeSumIntArray(values: values)
        XCTAssertEqual(res, 42 * 4, "Incorrect value returned")
    }

    func testSomeSumIntArrayNoCopy() {
        let values = [Int64](repeating: 42, count: 4)
        let res = wrapSomeSumIntArrayNoCopy(values: values)
        XCTAssertEqual(res, 42 * 4, "Incorrect value returned")
    }
}
