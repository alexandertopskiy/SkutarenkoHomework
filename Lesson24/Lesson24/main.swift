import Foundation

// MARK: - 24 - Расширения (extension) и вложенные типы (Nested Types)

// MARK: - Домашка

//1. Создайте расширение для Int с пропертисами isNegative, isPositive, bool

print("\n TASK 1")

extension Int {
    var isPositive : Bool {
        return self > 0
    }
    
    var isNegative : Bool {
        return self < 0
    }
    
    var bool : Bool {
        return self != 0
    }
}

let a1 = 5
let a2 = -5
let a3 = 0

print("Is Positive? a1: \(a1.isPositive), a2: \(a2.isPositive), a3: \(a3.isPositive)")
print("Is Negative? a1: \(a1.isNegative), a2: \(a2.isNegative), a3: \(a3.isNegative)")
print("Is Bool? a1: \(a1.bool), a2: \(a2.bool), a3: \(a3.bool)")

//2. Добавьте проперти, которое возвращает количество символов в числе

print("\n TASK 2")

extension Int {
    var countOfNumbers : Int {
        var count = 1
        var temp = self
        while (temp / 10 != 0) {
            temp = temp / 10
            count += 1
        }
        return count
    }
}

let a4 = 123

print("number \(a4) has \(a4.countOfNumbers) numbers")

//3. Добавьте сабскрипт, который возвращает символ числа по индексу:
//
//let a = 8245
//a[1] // 4
//a[3] // 8
//
//Профи могут определить и сеттер :)

print("\n TASK 3")

extension Int {
    subscript(rightIndex: Int) -> Int {
        get {
            var decimalBase = 1
            for _ in 0..<rightIndex {
                decimalBase *= 10
            }
            return (self / decimalBase) % 10
        }
        set {
            var result = ""
            let countOfSelf = self.countOfNumbers
            if rightIndex < countOfSelf {
                for index in 0..<countOfSelf {
                    if index == rightIndex {
                        result = "\(newValue)" + result
                    } else {
                        result = "\(self[index])" + result
                    }
                }
                self = Int(result)!
            } else { print("Index is out of range") }
        }
    }
}

var a = 123
print(a[0]) // 3
print(a[1]) // 2
print(a[2]) // 1
print(a[3]) // 0
a[2] = 5
print(a)  // 523

//4. Расширить String, чтобы принимал сабскрипт вида s[0..<3] и мог также устанавливать значения используя его
// Сделать и геттер, и сеттер
print("\n TASK 4")

extension String {
    subscript (start: Int, length: Int) -> String {
        let startIndex = self.index(self.startIndex, offsetBy: start)
        let endIndex = self.index(startIndex, offsetBy: length)
        let range = startIndex..<endIndex
        return String(self[range])
    }
    
    subscript(range: Range<Int>) -> String? {
        get {
            if (range.lowerBound > self.count || range.upperBound > self.count) {
                print("Index is out of bounds")
                return nil
            } else {
                let startIndex = self.index(self.startIndex, offsetBy: range.lowerBound)
                let endIndex = self.index(startIndex, offsetBy: range.upperBound - range.lowerBound)
                let range = startIndex..<endIndex
                return String(self[range])
            }
        }
        set {
            guard let newValue = newValue else {
                print("newValue can't be nil!")
                return
            }
            if (range.lowerBound > self.count || range.upperBound > self.count) {
                print("Index is out of bounds")
            } else {
                let (x,y) = (range.lowerBound, range.upperBound)
                let start = self.startIndex
                let beginningRange = start..<self.index(start, offsetBy: x)     // левая часть от заменяемой
                let endRange = self.index(start, offsetBy: y)..<self.endIndex   // правая часть от заменяемой
                self = String(self[beginningRange]) + newValue + String(self[endRange])
            }
        }
    }
    
    subscript(range: ClosedRange<Int>) -> String? {
        get {
            if (range.lowerBound > self.count || range.upperBound >= self.count) {
                print("Index is out of bounds")
                return nil
            } else {
                let startIndex = self.index(self.startIndex, offsetBy: range.lowerBound)
                let endIndex = self.index(startIndex, offsetBy: range.upperBound - range.lowerBound)
                let range = startIndex...endIndex
                return String(self[range])
            }
        }
        set {
            guard let newValue = newValue else {
                print("newValue can't be nil!")
                return
            }
            if (range.lowerBound > self.count || range.upperBound > self.count) {
                print("Index is out of bounds")
            } else {
                let (x,y) = (range.lowerBound, range.upperBound)
                let start = self.startIndex
                let beginningRange = start..<self.index(start, offsetBy: x)     // левая часть от заменяемой
                let endRange = self.index(start, offsetBy: y + 1)..<self.endIndex   // правая часть от заменяемой
                self = String(self[beginningRange]) + newValue + String(self[endRange])
            }
        }
    }
}

var str = "hello, world!"

print(str[7..<12]!)
print("old: \(str)")
str[7..<12] = "Alex"
print("new: \(str)") // "hello, Alex!"

print(str[0...4]!)
print("old: \(str)")
str[0...4] = "bye"
print("new: \(str)") // "bye, Alex!"


//5. Добавить стрингу метод truncate, чтобы отрезал лишние символы и , если таковые были, заменял их на троеточие:

print("\n TASK 5")

extension String {
    mutating func truncate(lenght: Int) {
        if lenght < self.count {
            let startIndex = self.startIndex
            let endIndex = self.index(startIndex, offsetBy: lenght)
            let range = startIndex..<endIndex
            self = String(self[range]) + "..."
        }
    }
}

var s = "Hi hi hi"
s.truncate(lenght: 10) // Hi hi hi
print("string now is : \(s)")
s.truncate(lenght: 8) // Hi hi hi
print("string now is : \(s)")
s.truncate(lenght: 4) // Hi h...
print("string now is : \(s)")
s.truncate(lenght: 1) // H...
print("string now is : \(s)")
s.truncate(lenght: 0) // ...
print("string now is : \(s)")
