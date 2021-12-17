import Foundation

// MARK: Common
let digitSet = Set("-123456789")
let targetAreaSplit: (Character) -> Bool = { !digitSet.contains($0) }

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

let xMin = (0...xTarget.lowerBound)
    .first(where: { triangle($0) >= xTarget.lowerBound })!
let xVelocityRange = xMin...xTarget.upperBound

var distinctInitialVelocities = 0
for xVelocity in xVelocityRange {
    let yVelocityRange = xVelocity < xTarget.upperBound
    ? yTarget.lowerBound.absoluteRange
    : yTarget.lowerBound...0
    for yVelocity in yVelocityRange {
        var xPostion = 0, yPosition = 0
        var xVelocity = xVelocity, yVelocity = yVelocity
        while xPostion <= xTarget.upperBound, yPosition >= yTarget.lowerBound {
            xPostion += xVelocity
            yPosition += yVelocity
            xVelocity -= xVelocity.signum()
            yVelocity -= 1
            if xTarget ~= xPostion && yTarget ~= yPosition {
                distinctInitialVelocities += 1
            }
        }
    }
}

let partTwo = distinctInitialVelocities
