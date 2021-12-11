import Foundation

public struct Balancer<T: Hashable & Equatable> {
    private let validPairs: [T: T]
    private let open: Set<T>
    
    public init(_ validPairs: [T: T]) {
        self.validPairs = validPairs
        open = Set(validPairs.map(\.key))
    }
    
    public func unbalanced(_ input: [T]) -> [T] {
        var stack = Stack<T>()
        return input.compactMap { element -> T? in
            if open.contains(element) {
                stack.push(element)
            } else if let last = stack.pop(),
                      element != validPairs[last] {
                return element
            }
            return nil
        }
    }
    
    public func autocomplete(_ input: [T]) -> [T]? {
        var stack = Stack<T>()
        for element in input {
            if open.contains(element) {
                stack.push(element)
            } else if let last = stack.pop(),
                      element != validPairs[last] {
                return nil
            }
        }
        return stack.storage
    }
}
