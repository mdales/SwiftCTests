import somec

func wrapSomeInt(val: Int64) -> Int64 {
    return someInt(val)
}

func wrapSomeIntModify(val: inout Int64) -> Int {
    return Int(someIntModify(&val))
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
