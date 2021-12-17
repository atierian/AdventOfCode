import Foundation

// MARK: Common
let targetAreaSplit: (Character) -> Bool = { !Set("-123456789").contains($0) }

let numbers = DaySeventeen.input
    .split(whereSeparator: targetAreaSplit)
    .compactMap { Int($0) }
assert(numbers.count == 4, "Invalid Input")

let xTarget = numbers[0]...numbers[1]
let yTarget = numbers[2]...numbers[3]
let triangle: (Int) -> Int = { $0 * ($0 + 1) / 2 }

// MARK: Part One
let partOne = triangle(abs(yTarget.lowerBound) - 1)

// MARK: Part Two
extension SignedNumeric where Self: Comparable {
    var absoluteRange: ClosedRange<Self> {
        self...abs(self)
    }
}

let xDistance: (Int, Int) -> Int = {
    triangle($0) - triangle(max(0, $0 - $1))
}

var minX = xTarget.lowerBound - 1
var maxX = xTarget.upperBound
var distinctVelocities = 0

for targetY in yTarget.lowerBound.absoluteRange {
    var velocityY = targetY < 0 ? targetY : -targetY - 1
    var y = 0
    var velocities = Int.max

    for i in (targetY < 0 ? 1 : 2 * targetY + 2)... {
        y += velocityY
        velocityY -= 1
        if y < yTarget.lowerBound { break }
        if y <= yTarget.upperBound {
            while xDistance(minX, i) >= xTarget.lowerBound {
                minX -= 1
            }

            while xDistance(maxX, i) > xTarget.upperBound {
                maxX -= 1
            }

            distinctVelocities += min(maxX, velocities) - minX
            velocities = minX

        }
    }
}

let partTwo = distinctVelocities
