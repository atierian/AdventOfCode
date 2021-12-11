import Foundation

public struct Stack<T: Equatable>: Equatable {
    public var storage: [T] = []
    public var isEmpty: Bool { peek == nil }
    public var peek: T? { storage.last }

    public init() { }
    public init(_ elements: [T]) {
        storage = elements
    }
    
    public mutating func push(_ element: T) {
        storage.append(element)
    }
    
    @discardableResult
    public mutating func pop() -> T? {
        storage.popLast()
    }
}

extension Stack: ExpressibleByArrayLiteral {
    public init(arrayLiteral elements: T...) {
        storage = elements
    }
}
