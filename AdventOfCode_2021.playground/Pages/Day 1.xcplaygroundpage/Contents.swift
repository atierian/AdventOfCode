// Day 1: Sonar Sweep
import Foundation

let input = DayOne.input

// MARK: Part 1
let depthIncrease = Reducing<Store<Int, Int>, Int>.init { store, element in
    element > store.previousElement
    ? .init(value: store.value + 1, previousElement: element)
    : .init(value: store.value, previousElement: element)
}

let partOnesolution = input
    .reduce(Store(value: 0, previousElement: Int.max), depthIncrease)
    .value

// MARK: Part 1 Simple Alternative
let solutionAlt = zip(input, input.dropFirst())
    .filter(<)
    .count

// MARK: Part 2
extension Array {
    func windowChunked(by n: Int) -> [[Element]] {
        (0...count - n).map {
            Array(self[$0 ..< $0 + n])
        }
    }
}

let windowedDepthIncrease = depthIncrease.pullback { (array: [Int]) in
    array.reduce(0, +)
}

let partTwoSolution = input.windowChunked(by: 3)
    .reduce(Store(value: 0, previousElement: Int.max), windowedDepthIncrease)
    .value

// MARK: Part 2 Simple Alternative
let partTwoSolutionAlt = zip(input, input.dropFirst(3))
    .filter(<)
    .count
