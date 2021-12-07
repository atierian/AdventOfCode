import Foundation

// MARK: Input
let positions = DaySeven
    .input
    .components(separatedBy: ",")
    .compactMap(Int.init)
    .sorted()

// MARK: Part One
let medianIndex = Int(ceil(Double(positions.count/2)))
let median = positions[medianIndex]

func fuelConsumption(_ median: Int) -> Reducing<UInt, Int> {
    Reducing { $0 + $1.distance(to: median).magnitude }
}

let partOne = positions
    .reduce(0, fuelConsumption(median))

// MARK: Part Two
let mean = positions
    .reduce(0, +) / positions.count

func incrementalFuelConsumption(mean: Int) -> Reducing<Int, Int> {
    Reducing {
        let d = $1.distance(to: mean)
        return $0 + d * (d + 1) / 2
    }
}

let partTwo = positions
    .reduce(0, incrementalFuelConsumption(mean: mean))
