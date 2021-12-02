import Foundation

// MARK: Input
let input = DayTwo.input
let commands = input
    .components(separatedBy: .newlines)
    .compactMap(Command.init)


// MARK: Part 1
let dive = Reducing<Position, Command>.init { position, command in
    switch command.direction {
    case .forward:
        return .init(x: command.units, startingPosition: position)
    case .down:
        return .init(y: command.units, startingPosition: position)
    case .up:
        return .init(y: -command.units, startingPosition: position)
    }
}

let partOneSolution = commands
    .reduce(Position(), dive)
    .travelled


// MARK: Part 2
let diveWithAim = Reducing<(Position, Int), Command>.init { initial, command in
    let (position, aim) = initial
    switch command.direction {
    case .forward:
        return (Position(x: command.units, y: command.units * aim, startingPosition: position), aim)
    case .down:
        return (Position(startingPosition: position), aim + command.units)
    case .up:
        return (Position(startingPosition: position), aim - command.units)
    }
}

let partTwoSolution = commands
    .reduce((Position(), 0), diveWithAim).0
    .travelled
