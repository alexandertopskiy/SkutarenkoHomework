import Foundation

// MARK: - Из методички

// MARK: - Расширения (extension)

extension Double {
    var km: Double { return self * 1_000.0 }
    var m: Double { return self }
    var cm: Double { return self / 100.0 }
    var mm: Double { return self / 1_000.0 }
    var ft: Double { return self / 3.28084 }
}
let oneInch = 25.4.mm
print("Один дюйм - это \(oneInch) метра")  // "Один дюйм- это 0.0254 метра"
let threeFeet = 3.ft
print("Три фута - это \(threeFeet) метра") // "Три фута - это 0.914399970739201 метра"

let aMarathon = 42.km + 195.m
print("Марафон имеет длину \(aMarathon) метров") // "Марафон имеет длину 42195.0 метров"

// MARK: - Инициализаторы

struct Size {
    var width = 0.0, height = 0.0
}
struct Point {
    var x = 0.0, y = 0.0
}
struct Rect {
      var origin = Point()
      var size = Size()
}

let defaultRect = Rect()

let specificRect = Rect(origin: Point(x: 2.0, y: 2.0), size: Size(width: 5.0, height: 5.0))

extension Rect {
    init(center: Point, size: Size) {
        let originX = center.x - (size.width / 2)
        let originY = center.y - (size.height / 2)
        self.init(origin: Point(x: originX, y: originY), size: size)
    }
}

let otherSpecificRect = Rect(center: Point(x: 0.0, y: 0.0), size: Size(width: 5.0, height: 5.0))

// MARK: - Методы в расширениях

extension Int {
    func repetition(task : () -> Void) {
        for _ in 0..<self {
            task()
        }
    }
}

let x = 5
5.repetition {
    print("hello!")
}

// MARK: - Изменяющиеся (mutating) методы экземпляра

extension Int {
    mutating func square() {
        self = self * self
    }
}
var someInt = 5
print("squared \(someInt) is", terminator: " ")
someInt.square()
print(someInt) // squared 5 is 25

// MARK: - Сабскрипты



extension Int {
    subscript(digitIndex: Int) -> Int {
        var decimalBase = 1
        for _ in 0..<digitIndex {
            decimalBase *= 10
        }
        return (self / decimalBase) % 10
    }
}
print(123456789[0]) // возвращает 9
print(123456789[1]) // возвращает 8
print(123456789[2]) // возвращает 7
print(123456789[8]) // возвращает 1
print(123456789[15]) // возвращает 0

// Если значение Int не имеет достаточно количество цифр для требуемого индекса, то сабскрипт возвращает 0, как если бы вместо этого числа стоял 0:
print(123456789[9])
// возвращает 0, как если бы вы запросили вот так:
print(0123456789[9])


// MARK: - Вложенные типы в расширениях

extension Int {
    enum Kind {
        case negative, zero, positive
    }
    var kind: Kind {
        switch self {
            case 0: return .zero
            case let x where x > 0: return .positive
            default: return .negative
        }
    }
}

let arr = [-100, 100, 0, 43, -20, 0]

func printTypesOfNumbers(_ arr: [Int]) {
    for number in arr {
        switch number.kind {
            case .negative: print("-",terminator: " ")
            case .positive: print("+",terminator: " ")
            case .zero: print("0",terminator: " ")
        }
    }
}

printTypesOfNumbers(arr) // - + 0 + - 0
