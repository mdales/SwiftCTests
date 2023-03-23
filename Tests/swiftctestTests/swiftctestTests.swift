import XCTest
@testable import swiftctest

final class swiftctestTests: XCTestCase {
    func testSomeInt() {
        XCTAssertEqual(wrapSomeInt(val: 42), 42 * 42)
    }

    func testSomeIntModify() throws {
        var val = Int64(42);
        try wrapSomeIntModify(val: &val)
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

    func testSomeSumIntPointer() {
        let values = [Int64](repeating: 42, count: 4)
        let res = wrapSomeSumIntPointer(values: values)
        XCTAssertEqual(res, 42 * 4, "Incorrect value returned")
    }

    func testSomeIntModifyArrayImmutable() throws {
        let values = [Int64](repeating: 42, count: 4)
        let res = try wrapSomeIntModifyArrayImmutable(values: values)
        XCTAssertEqual(res, values.map { $0 * 42 }, "Unexpected values")
    }

    func testSomeIntModifyArrayMutable() throws {
        var values = [Int64](repeating: 42, count: 4)
        let expected = values.map { $0 * 42 }
        try wrapSomeIntModifyArrayMutable(values: &values)
        XCTAssertEqual(values, expected, "Unexpected values")
    }

    func testSomeIntArrayCalleeOwned() throws {
        let result = try wrapSomeIntArrayCalleeOwned()
        XCTAssertEqual(result, [Int64](repeating: 42, count: 4), "Incorrect result")
    }
}
