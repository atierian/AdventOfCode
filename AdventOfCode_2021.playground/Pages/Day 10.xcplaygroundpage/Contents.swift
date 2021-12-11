import Foundation

// MARK: Common
let validPairs: [Character: Character] = [
    "(": ")",
    "[": "]",
    "{": "}",
    "<": ">"
]

let balancer = Balancer(validPairs)

// MARK: Part One
func errorReduce(
    _ lookup: [Character: Int]
) -> Reducing<Int, Character> {
    .init { $0 + (lookup[$1] ?? 0) }
}

let errorScoreLookup: [Character: Int] = [
    ")": 3,
    "]": 57,
    "}": 1197,
    ">": 25137
]

let partOne = DayTen.input
    .components(separatedBy: .newlines)
    .map(Array.init)
    .flatMap(balancer.unbalanced)
    .reduce(0, errorReduce(errorScoreLookup))

// MARK: Part Twp
let partTwoScoreLookup: [Character: Int] = [
    ")": 1,
    "]": 2,
    "}": 3,
    ">": 4
]

func autocompleteReduce(
    _ lookup: [Character: Int]
) -> Reducing<Int, Character> {
    .init { $0 * 5 + (lookup[$1] ?? 0) }
}

let partTwoValues = DayTen.input
    .components(separatedBy: .newlines)
    .map(Array.init)
    .compactMap(balancer.autocomplete)
    .map {
        $0.reversed()
            .compactMap { validPairs[$0] }
            .reduce(0, autocompleteReduce(partTwoScoreLookup))
    }
    .sorted()

let partTwo = partTwoValues[partTwoValues.count / 2]
