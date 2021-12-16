import Foundation

let input = """
NNCB

CH -> B
HH -> N
CB -> H
NH -> C
HB -> C
HC -> B
HN -> C
NN -> C
BH -> H
NC -> B
NB -> B
BN -> B
BB -> N
BC -> B
CC -> N
CN -> C
"""

let polymerTemplate = String(input
    .prefix(while: { $0 != "\n" }))

let insertionRules = input
    .components(separatedBy: .newlines)
    .dropFirst(2)
    .map { $0.components(separatedBy: " -> ") }
    .reduce(into: [String: Character]()) {
        $0[$1[0]] = Character($1[1])
    }

let a = polymerTemplate.map { $0 }
let polymerPairs = zip(a, a.dropFirst())
    .reduce(into: [String: Int]()) {
        $0["\($1.0)\($1.1)", default: 0] += 1
    }

struct Pair: Hashable {
    let letters: String
    var count: Int

    mutating func increment() { count += 1 }
    mutating func decrement() { count -= 1 }
}

func handle(_ pairs: [String: Int], rules: [String: Character]) {
    
}

func pairInsert(_ template: String, rounds: Int) -> String {
    if rounds == 0 { return template }

    func insert(_ pair: (String.Element, String.Element)) -> String {
        var pair = "\(pair.0)\(pair.1)"
        if let a = insertionRules[pair] {
            pair.insert(a, at: pair.index(after: pair.startIndex))
        }
        return pair
    }

    let polymers = template.map { $0 }
    let triplets = zip(polymers, polymers.dropFirst())
        .map(insert)

    return triplets.joined()
}
