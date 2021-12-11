import Foundation

/*
     0:      1:      2:      3:      4:
    aaaa    ....    aaaa    aaaa    ....
    b    c  .    c  .    c  .    c  b    c
    b    c  .    c  .    c  .    c  b    c
    ....    ....    dddd    dddd    dddd
    e    f  .    f  e    .  .    f  .    f
    e    f  .    f  e    .  .    f  .    f
    gggg    ....    gggg    gggg    ....

     5:      6:      7:      8:      9:
    aaaa    aaaa    aaaa    aaaa    aaaa
    b    .  b    .  .    c  b    c  b    c
    b    .  b    .  .    c  b    c  b    c
    dddd    dddd    ....    dddd    dddd
    .    f  e    f  .    f  e    f  .    f
    .    f  e    f  .    f  e    f  .    f
    gggg    gggg    ....    gggg    gggg
*/


let lines = DayEight.input
    .components(separatedBy: .newlines)

// MARK: Part 1
func reduce(
    for knownCases: Set<Int>
) -> Reducing<Int, String> {
    Reducing {
        $0 + $1
            .components(separatedBy: "|")[1]
            .dropFirst()
            .components(separatedBy: .whitespaces)
            .map(\.count)
            .filter(knownCases.contains)
            .count
    }
}

let knownDigitSet: Set<Int> = [2, 3, 4, 7] // Represents digits [1, 4, 7, 8]
let partOne = lines
    .reduce(0, reduce(for: knownDigitSet))

print(partOne)

// MARK: Part 2

let digitSegment: [Set<Character>] = [
    Set("abcefg"),
    Set("cf"),
    Set("acdeg"),
    Set("acdfg"),
    Set("bcdf"),
    Set("abdfg"),
    Set("abdefg"),
    Set("acf"),
    Set("abcdefg"),
    Set("abcdfg")
]

struct InputLine {
    let signalPatterns: [Set<Character>]
    let outputValue: [Set<Character>]
}

func parse(_ line: String) -> InputLine {
    let split = line
        .components(separatedBy: "|")
        .map { $0.trimmingCharacters(in: .whitespaces) }
    let signalPatterns = split[0]
        .components(separatedBy: .whitespaces)
        .map { Set($0) }
    let outputValue = split[1]
        .components(separatedBy: .whitespaces)
        .map { Set($0) }

    return InputLine(
        signalPatterns: signalPatterns,
        outputValue: outputValue
    )
}
