import Foundation
import Darwin

let input = DayThree.input

func partOne(_ input: String) -> UInt {
    let g = gamma(input)
    let gamma = strtoul(g, nil, 2)
    let e = String(~gamma, radix: 2).suffix(g.count)
    let epsilon = strtoul(String(e), nil, 2)
    return gamma * epsilon
}

func gamma(_ input: String) -> String {
    assert(input.contains("\n"), "Invalid String format, entries should be broken up by new lines.")
    let firstLineBreak = input.firstIndex(of: "\n")!
    let entryLength = input.distance(from: input.startIndex, to: firstLineBreak)
    let entryCount = Int(ceil(Double(input.distance(from: input.startIndex, to: input.endIndex)) / Double(entryLength + 1)))
    let majority = entryCount / 2

    var gamma = ""
    for xIndex in 0..<entryLength {
        var (zero, one) = (0, 0), i = input.startIndex
        input.formIndex(&i, offsetBy: xIndex)
        for _ in 1..<entryCount {
            switch input[i] {
            case "0": zero += 1
            case "1": one += 1
            default:
                assertionFailure("Input was not one or zero. Invalid input string.")
            }
            if zero >= majority || one >= majority {
                gamma += String(input[i])
                break
            }
            input.formIndex(&i, offsetBy: entryLength + 1)
        }
    }
    return gamma
}

print(partOne(input))
