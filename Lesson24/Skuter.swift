import Foundation

// MARK: - 24 - Расширения (extension) и вложенные типы (Nested Types)

// MARK: - Скутаренко

// MARK: - Четное/Нечетное число
extension Int {
    var isEven : Bool { return self % 2 == 0 }
    var isOdd : Bool { return !isEven }
    
    
    // Вложенный тип. Внутри обращение к нему как к EvenOrOdd. Снаружи - как Int.EvenOrOdd
    enum EvenOrOdd {
        case Even
        case Odd
    }
    
    var evenOrOdd : EvenOrOdd {
        return isEven ? .Even : .Odd
    }

}

extension Int.EvenOrOdd {
    var stringValue : String {
        switch self {
        case .Even: return "even"
        case .Odd: return "odd"
        }
    }
}

var a = 5

if a % 2 == 0 { print("even") }
else { print("odd") }

if a.isEven { print("even") }
else { print("odd") }

print(a.evenOrOdd.stringValue)

// MARK: - Возведение в степень
extension Int {
    func pow(value: Int) -> Int {
        var temp = self
        for _ in 1..<value {
            temp *= self
        }
        return temp
    }
    
    mutating func powTo(value: Int) {
        self = pow(value: value)
    }
}

let x = a.pow(value: 3)
print("x=\(x), a=\(a)")
a.powTo(value: 2)
print("a=\(a)")


// MARK: - Получение двоичной записи числа
extension Int {
    var binaryString : String {
        var result = ""
        for i in 0..<8 {
            // если текущий бит установлен, то добавить 1, иначе - 0
            result = String(self & (1 << i) > 0) + result
        }
        return result
    }
}

// расширяем String, чтобы инициализатор не ругался на Bool входной параметр
extension String {
    init(_ value: Bool) {
        self.init(value ? 1 : 0)
    }
}

print(a)
print(a.binaryString)


// MARK: - Получение подстроки

let str = "hello, world!"

let startIndex = str.startIndex
let endIndex = str.index(startIndex, offsetBy: 5)
let range = startIndex..<endIndex
print(str[range])

extension String {
    subscript (start: Int, length: Int) -> String {
        let startIndex = self.index(self.startIndex, offsetBy: start)
        let endIndex = self.index(startIndex, offsetBy: length)
        let range = startIndex..<endIndex
        return String(self[range])
    }
}

print(str[0,5])
