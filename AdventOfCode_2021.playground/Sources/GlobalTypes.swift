
public struct Reducing<T, U> {
    public init(reduce: @escaping (T, U) -> T) {
        self.reduce = reduce
    }

    public let reduce: (T, U) -> T

    public func pullback<V>(_ f: (@escaping (V) -> U)) -> Reducing<T, V> {
        Reducing<T, V> { store, element in
            reduce(store, f(element))
        }
    }
}

public struct Store<T, U> {
    public init(value: T, previousElement: U) {
        self.value = value
        self.previousElement = previousElement
    }

    public let value: T
    public let previousElement: U
}

public extension Array {
    func reduce<T>(_ initial: T, _ reduction: Reducing<T, Element>) -> T {
        reduce(initial, reduction.reduce)
    }
}
