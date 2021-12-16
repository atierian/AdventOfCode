import Foundation

let input = DaySixteen.input

struct Packet {
    struct Header {
        let version: Int
        let typeID: Int
    }

    let header: Header
    let value: Int
    let subPackets: [Packet]

    var versionSum: Int {
        header.version + subPackets.reduce(0) { $0 + $1.versionSum }
    }
}

extension Packet {
    static func literal(_ bits: inout ArraySlice<Bool>, version: Int) -> Packet {
        var value = [Bool]()
        var nonFinalGroup = true
        while nonFinalGroup {
            let chunk = bits.removeFirst(5)
            value.append(contentsOf: chunk.suffix(4))
            nonFinalGroup = chunk[0] == true
        }
        return Packet(
            header: Header(version: version, typeID: 4),
            value: value.intValue,
            subPackets: []
        )
    }
}

extension Int {
    var bits: [Bool] {
        (0..<bitWidth)
            .map { self & (1 << $0) > 0 }
            .reversed()
    }
}

extension Bool {
    var intValue: Int {
        self ? 1 : 0
    }
}

extension Sequence where Element == Bool {
    var intValue: Int {
        reduce(0) {
            $0 << 1 | $1.intValue
        }
    }
}

extension ArraySlice {
    mutating func removeFirst(_ c: Int) -> [Element] {
        var result = [Element]()
        while result.count < c {
            result.append(removeFirst())
        }
        return result
    }
}

let operationLookup: [Int: ([Int]) -> Int] = [
    0: { $0.reduce(0, +) },
    1: { $0.reduce(1, *) },
    2: { $0.min()! },
    3: { $0.max()! },
    5: { $0[0] > $0[1] ? 1 : 0 },
    6: { $0[0] < $0[1] ? 1 : 0 },
    7: { $0[0] == $0[1] ? 1 : 0 }
]

func parse(_ bits: inout ArraySlice<Bool>) -> Packet {
    let version = bits.removeFirst(3).intValue
    let typeID = bits.removeFirst(3).intValue
    if typeID == 4 { return .literal(&bits, version: version) }

    var subPackets: [Packet] = []
    let lengthTypeID = bits.removeFirst()
    if lengthTypeID {
        let subPacketCount = bits.removeFirst(11).intValue
        for _ in 0..<subPacketCount {
            subPackets.append(parse(&bits))
        }
    } else {
        let subPacketLength = bits.removeFirst(15).intValue
        let bitTarget = bits.count - subPacketLength
        while bits.count != bitTarget {
            subPackets.append(parse(&bits))
        }
    }

    let subPacketValues = subPackets.map(\.value)
    guard let operation = operationLookup[typeID] else {  fatalError("Invalid TypeID input") }
    let value = operation(subPacketValues)
    return Packet(
        header: Packet.Header(version: version, typeID: typeID),
        value: value,
        subPackets: subPackets
    )
}

let bits = input
    .compactMap(\.hexDigitValue)
    .flatMap { $0.bits.suffix(4) }

var slice = bits[...]
let packet = parse(&slice)

let partOne = packet.versionSum
let partTwo = packet.value
