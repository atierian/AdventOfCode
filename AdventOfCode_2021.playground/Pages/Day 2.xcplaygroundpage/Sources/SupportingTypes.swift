import Foundation

public struct Command {
    public let direction: Direction
    public let units: Int

    public init?(_ command: String) {
        let components = command
            .components(separatedBy: .whitespaces)

        assert(components.count == 2, "incorrectly formatted input string")

        guard let direction = Direction(rawValue: components[0]),
              let units = Int(components[1])
        else { return nil }

        self.direction = direction
        self.units = units
    }

    public enum Direction: String {
        case forward, down, up
    }
}

public struct Position {
    public let x: Int
    public let y: Int

    public init(x: Int = 0, y: Int = 0) {
        self.x = x
        self.y = y
    }

    public init(x: Int = 0, y: Int = 0, startingPosition: Position = .init()) {
        self.x = startingPosition.x + x
        self.y = startingPosition.y + y
    }

    public var travelled: Int { x * y }
}
