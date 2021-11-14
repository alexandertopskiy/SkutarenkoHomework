import Foundation

// MARK: - Требования свойств

protocol FullyName {
    var fullName: String { get }
}

struct Person : FullyName {
    var fullName : String
}

var person = Person(fullName: "Alexander Topskiy")

class Starship : FullyName {
    var name: String
    var prefix: String?
    init(name: String, prefix: String?) {
        self.name = name
        self.prefix = prefix
    }
    var fullName: String {
        return (prefix == nil ? "" : prefix! + " ") + name
    }
}

var ncc1701 = Starship(name: "Enterprise", prefix: "USS")




// MARK: - Требования методов

protocol RandomNumberGenerator {
  func random() -> Double
}

// алгоритм линейного конгруэнтного генератора
class LinearCongruentialGenerator: RandomNumberGenerator {
    var lastRandom = 42.0
    let m = 139968.0
    let a = 3877.0
    let c = 29573.0
    func random() -> Double {
        lastRandom = ((lastRandom * a + c).truncatingRemainder(dividingBy:m))
        return lastRandom / m
    }
}
let generator = LinearCongruentialGenerator()
print("a random number: \(generator.random())")
print("another one: \(generator.random())")
print("another one: \(generator.random())")
print("another one: \(generator.random())")

// MARK: - Требования изменяющихся (mutating) методов

protocol Togglable {
    mutating func toggle()
}

enum OnOffSwitch: Togglable {
    case on, off
    mutating func toggle() {
        switch self {
        case .off: self = .on
        case .on: self = .off
        }
    }
}

var lightSwitch = OnOffSwitch.off
lightSwitch
lightSwitch.toggle()
lightSwitch



// MARK: - Протоколы как типы

// игральная кость
class Dice {
    let sides: Int
    let generator: RandomNumberGenerator
    init(sides: Int, generator: RandomNumberGenerator) {
        self.sides = sides
        self.generator = generator
    }
    func roll() -> Int {
        return Int(generator.random() * Double(sides)) + 1
    }
}

var d6 = Dice(sides: 6, generator: LinearCongruentialGenerator())
for _ in 1...d6.sides {
    print("     Выпало... \(d6.roll())")
}

// MARK: - Делегирование

protocol DiceGame {
    var dice: Dice { get }
    func play()
}

protocol DiceGameDelegate: AnyObject {
    func gameDidStart(_ game: DiceGame)
    func game(_ game: DiceGame, didStartNewTurnWithDiceRoll diceRoll: Int)
    func gameDidEnd(_ game: DiceGame)
}

class SnakesAndLadders : DiceGame {
    let finalSquare = 25
    let dice = Dice(sides: 6, generator: LinearCongruentialGenerator())
    var square = 0
    var board = [Int]()
    init() {
        board = Array(repeating: 0, count: finalSquare + 1)
        board[03] = +08; board[06] = +11; board[09] = +09; board[10] = +02;
        board[14] = -10; board[19] = -11; board[22] = -02; board[24] = -08;
    }
    weak var delegate : DiceGameDelegate?
    func play() {
        square = 0
        delegate?.gameDidStart(self)
        gameLoop: while square != finalSquare {
            let diceRoll = dice.roll()
            delegate?.game(self, didStartNewTurnWithDiceRoll: diceRoll)
            switch square + diceRoll {
                case finalSquare: break gameLoop
                case let newSquare where newSquare > finalSquare: continue gameLoop
                default:
                    square += diceRoll
                    square += board[square]
            }
        }
        delegate?.gameDidEnd(self)
    }
}

class DiceGameTracker : DiceGameDelegate {
    var numberOfNurns = 0
    func gameDidStart(_ game: DiceGame) {
        numberOfNurns = 0
        switch game {
            case is SnakesAndLadders: print("Начали новую игру в Змеи и Лестницы")
            default: print("Начали новую игру")
        }
        print("У игральной кости \(game.dice.sides) граней")
        
    }
    
    func game(_ game: DiceGame, didStartNewTurnWithDiceRoll diceRoll: Int) {
        numberOfNurns += 1
        print("Выпало \(diceRoll)")
    }
    
    func gameDidEnd(_ game: DiceGame) {
        print("Игра закончилась! Число бросков за игру \(numberOfNurns)")
    }
    
}

print("\nигра")

let tracker = DiceGameTracker()
let game = SnakesAndLadders()
game.delegate = tracker
game.play()




// MARK: - Добавление реализации протокола через расширение

protocol TextRepresentable {
    var textDescription: String { get }
}

extension Dice : TextRepresentable {
    var textDescription: String {
        return "Игральная кость с \(self.sides) гранями"
    }
}

let d12 = Dice(sides: 12, generator: LinearCongruentialGenerator())
print(d12.textDescription)

extension SnakesAndLadders : TextRepresentable {
    var textDescription: String {
        return "Игра Змеи и Лестницы с полем в \(self.finalSquare) клеток"
    }
}
print(game.textDescription)



// MARK: - Условное соответствие протоколу

extension Array : TextRepresentable where Element : TextRepresentable {
    var textDescription: String {
        let itemsAsText = self.map { $0.textDescription }
        
        return "[" + itemsAsText.joined(separator: ", ") + "]"
    }

}

// [1,2,3].textDescription - ошибка, нет метода, т.к. элементы не подписаны под протокол
print([d6, d12].textDescription)



// MARK: - Принятие протокола через расширение
struct Hamster {
    var name: String
    var textDescription: String {
        return "Хомяка назвали \(name)"
    }
}
extension Hamster : TextRepresentable { }

let simonTheHamster = Hamster(name: "Фруша")
let somethingTextRepresentable: TextRepresentable = simonTheHamster
print(somethingTextRepresentable.textDescription)


// MARK: - Коллекции типов протокола

let things : [TextRepresentable] = [game, d6, d12, simonTheHamster]
for thing in things {
    print(thing.textDescription)
}



// MARK: - Наследование протоколов

protocol PrettyTextRepresentable : TextRepresentable {
    // обычный textDescription наследуется
    var prettyTextDescription: String { get }
}

extension SnakesAndLadders : PrettyTextRepresentable {
    var prettyTextDescription: String {
        var result = self.textDescription + ": \n"
        for index in 1...self.finalSquare {
            switch board[index] {
            case let ladder where ladder > 0 : result += "🔼"
            case let snake where snake < 0 : result += "🔽"
            default: result += "0️⃣"
            }
        }
        return result
    }
}

print(game.prettyTextDescription)


// MARK: - Композиция протоколов

// пример 1

protocol Named {
    var name: String { get }
}
protocol Aged {
    var age: Int { get }
}
struct SomePerson: Named, Aged {
    var name: String
    var age: Int
}
func wishHappyBirthday(to celebrator: Named & Aged) {
    print("С Днем Рождения, \(celebrator.name)! Тебе уже \(celebrator.age)!")
}
let birthdayPerson = SomePerson(name: "Alex", age: 21)
wishHappyBirthday(to: birthdayPerson)

// пример 2 (композиция протокола с суперклассом)

class Location {
    var latitude: Double
    var longitude: Double
    init(latitude: Double, longitude: Double) {
        self.latitude = latitude
        self.longitude = longitude
    }
}

class City: Location, Named {
    var name: String
    init(name: String, latitude: Double, longitude: Double) {
        self.name = name
        super.init(latitude: latitude, longitude: longitude)
    }
}

// класс + протокол (записывать можно в любом порядке)
func beginConcert(in location: Location & Named) {
    print("Hello, \(location.name)!")
}

let seattle = City(name: "Seattle", latitude: 47.6, longitude: -122.3)
beginConcert(in: seattle) // Выведет "Hello, Seattle!



// MARK: - Проверка соответствия протоколу


protocol HasArea {
    var area : Double { get }
}

class Circle: HasArea {
    let pi = 3.1415927
    var radius: Double
    var area: Double { return pi * radius * radius }
    init(radius: Double) { self.radius = radius }
}

class Country: HasArea {
    var area: Double
    init(area: Double) { self.area = area }
}

class Cat {
    var legs: Int
    init(legs: Int) { self.legs = legs }
}

let objects : [AnyObject] = [
    Circle(radius: 10.0),
    Country(area: 100_000),
    Cat(legs: 4)
]

for obj in objects {
    if let objectWithArea = obj as? HasArea {
        let area = objectWithArea.area
        if objectWithArea is Circle { print("Круг с площадью \(area)") }
        else if objectWithArea is Country { print("Страна с площадью \(area)") }
    } else {
        print("Объект не подписан на протокол HasArea")
    }
}


// MARK: - Опциональные требования протокола

@objc protocol CounterDataSource {
    @objc optional func increment(forCount count: Int) -> Int
    @objc optional var fixedIncrement: Int { get }
}

class Counter {
    var count = 0
    var dataSourse : CounterDataSource?
    func increment() {
        if let amount = dataSourse?.increment?(forCount: count) {
            count += amount
        } else if let amount = dataSourse?.fixedIncrement {
            count += amount
        }
    }
}

class ThreeSource: NSObject, CounterDataSource {
    let fixedIncrement = 3
}

print("Счетчик (Вариант 1)")
var counter = Counter()
counter.dataSourse = ThreeSource()
for _ in 1...4 {
    counter.increment()
    print(counter.count)
}

class TowardsZeroSource: NSObject, CounterDataSource {
    func increment(forCount count: Int) -> Int {
        switch count {
            case 0: return 0
            case let x where x < 0 : return 1
            default: return -1
        }
    }
}

print("Счетчик (Вариант 2)")
counter.count = -4
counter.dataSourse = TowardsZeroSource()
for _ in 1...5 {
    counter.increment()
    print(counter.count)
}



// MARK: - Расширения протоколов

extension RandomNumberGenerator {
    // func newFunc() - ошибка! в расширении нужно прописывать работу функции
    func randomBool() -> Bool {
        return random() > 0.5
    }
}

print("a random number: \(generator.random())")
print("a random bool: \(generator.randomBool())")
print("a random number: \(generator.random())")
print("a random bool: \(generator.randomBool())")


// MARK: - Дефолтная реализация

extension PrettyTextRepresentable {
    var prettyTextDescription: String {
        return textDescription
    }
}


// MARK: - Добавление ограничений к расширениям протоколов

extension Collection where Element: Equatable {
    func allEqual() -> Bool {
        for item in self {
            if item != self.first { return false }
        }
        return true
    }
}

[1,1,1,1].allEqual()
[1,2,3,4].allEqual()
