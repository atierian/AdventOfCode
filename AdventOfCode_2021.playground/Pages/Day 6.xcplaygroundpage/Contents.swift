import Foundation

let fish = DaySix.input
    .components(separatedBy: ",")
    .compactMap(Int.init)

func growth(parentAge: Int, days: Int, cache: inout [Int: Int]) -> Int {
    guard days > parentAge else { return 1 }
    if parentAge != 0 {
        return growth(parentAge: 0, days: days - parentAge, cache: &cache)
    }

    guard let newBorn = cache[days] else {
        cache[days] = growth(parentAge: 7, days: days, cache: &cache)
        + growth(parentAge: 9, days: days, cache: &cache)
        return cache[days]!
    }
    return newBorn
}

var newBorn: [Int: Int] = [:]

let partOne = fish
    .lazy
    .map { growth(parentAge: $0, days: 80, cache: &newBorn) }
    .reduce(0, +)

print(partOne)

let partTwo = fish
    .lazy
    .map { growth(parentAge: $0, days: 256, cache: &newBorn) }
    .reduce(0, +)

print(partTwo)
