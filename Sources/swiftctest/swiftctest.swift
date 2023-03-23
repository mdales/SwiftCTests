import somec

enum SomeError: Error {
    case ReturnIndicatedError
    case MissingData
}

func wrapSomeInt(val: Int64) -> Int64 {
    return someInt(val)
}

func wrapSomeIntModify(val: inout Int64) throws {
    guard someIntModify(&val) == 0 else {
        throw SomeError.ReturnIndicatedError
    }
}

func wrapSomeSumIntArrayBad(values: inout [Int64]) -> Int64 {
    // The first guess here was to use `withUnsafeBufferPointer`
    // but (I assume) because we can't guarantee the C world won't
    // stomp all over memory, the type for the array on the C function
    // is UnsafeMutablePointer<Int64>? - so we're forced to declare the
    // argument as mutable, which is clearly horrible, but done here
    // for completeness.
    let count = values.count
    return values.withUnsafeMutableBufferPointer {
       someSumIntArray(UInt32(count), $0.baseAddress)
    }
}

func wrapSomeSumIntArray(values: [Int64]) -> Int64 {
    // For safety, we're actually going to duplicate
    // the values into something mutable for the C world
    let copyValues = UnsafeMutablePointer<Int64>.allocate(capacity: values.count)
    defer { copyValues.deallocate() }
    copyValues.initialize(from: values, count: values.count)
    return someSumIntArray(UInt32(values.count), copyValues)
}

func wrapSomeSumIntArrayNoCopy(values: [Int64]) -> Int64 {
    // This feels a little dirty, but the compiler doesn't complain...
    // Here we are passing the OG memory as a mutable pointer despite
    // the original array being immutable.
    let count = values.count
    return values.withUnsafeBufferPointer {
        let buffer = UnsafeMutableBufferPointer<Int64>(mutating: $0)
        return someSumIntArray(UInt32(count), buffer.baseAddress)
    }
}

func wrapSomeSumIntPointer(values: [Int64]) -> Int64 {
    // For safety, we're actually going to duplicate
    // the values into something mutable for the C world
    let copyValues = UnsafeMutablePointer<Int64>.allocate(capacity: values.count)
    defer { copyValues.deallocate() }
    copyValues.initialize(from: values, count: values.count)
    return someSumIntPointer(UInt32(values.count), copyValues)
}

func wrapSomeIntModifyArrayImmutable(values: [Int64]) throws -> [Int64] {
    var mutable = values
    try mutable.withUnsafeMutableBufferPointer {
        guard someIntModifyArray(UInt32(values.count), $0.baseAddress) == 0 else {
            throw SomeError.ReturnIndicatedError
        }
    }
    return mutable
}

func wrapSomeIntModifyArrayMutable(values: inout [Int64]) throws {
    let count = values.count
    try values.withUnsafeMutableBufferPointer {
        guard someIntModifyArray(UInt32(count), $0.baseAddress) == 0 else {
            throw SomeError.ReturnIndicatedError
        }
    }
}

func wrapSomeIntArrayCalleeOwned() throws -> [Int64] {
    var data: UnsafePointer<Int64>?
    var count = UInt32(0)
    try withUnsafeMutablePointer(to: &data) {
        guard someIntArrayCalleeOwned(&count, $0) == 0 else {
            throw SomeError.ReturnIndicatedError
        }
    }
    guard let data = data else {
        throw SomeError.MissingData
    }
    let buffer = UnsafeBufferPointer<Int64>(start: data, count: Int(count))
    return Array(buffer)
}
