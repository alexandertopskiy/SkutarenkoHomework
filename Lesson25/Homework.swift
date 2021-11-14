import Foundation

// MARK: - Битовые операции

extension UInt8 {
    func binary() -> String {
        var result = ""
        for i in 0..<8 {
            let mask = 1 << i
            let set = Int(self) & mask != 0
            result = (set ? "1" : "0") + result
        }
        return result
    }
}

// MARK: - Домашка

//  1. Расширьте енум из урока и добавьте в него метод, помогающий установить соответствующий бит в переданную маску и метод, помогающий его прочитать. Эти методы должны принимать и возвращать маску, либо принимать адрес маски и менять его

print("\n TASK 1")

enum CheckList : UInt8 {
    case Bread =    0b0000_0001
    case Eggs =     0b0000_0010
    case Apples =   0b0000_0100
    case Chicken =  0b0000_1000
}

extension CheckList {
    static func setBit(purchase: CheckList, forMask checkList: inout UInt8) {
        checkList = checkList | purchase.rawValue
    }
    static func readBit(purchase: CheckList, forMask checkList: UInt8) -> Bool {
        return (checkList & purchase.rawValue) > 0
    }
}

var checkList : UInt8 = 0b0000_0000

print("checkList: \(checkList.binary())")
print("Bread: \(CheckList.readBit(purchase: .Bread, forMask: checkList))")
CheckList.setBit(purchase: .Bread, forMask: &checkList)
print("checkList: \(checkList.binary())")
print("Bread: \(CheckList.readBit(purchase: .Bread, forMask: checkList))")
print("Apples: \(CheckList.readBit(purchase: .Apples, forMask: checkList))")
CheckList.setBit(purchase: .Apples, forMask: &checkList)
print("checkList: \(checkList.binary())")
print("Apples: \(CheckList.readBit(purchase: .Apples, forMask: checkList))")
print("checkList: \(checkList.binary())")


//  2. Создать цикл, который будет выводить 1 байтное число с одним установленным битом в такой последовательности, чтобы в консоли получилась вертикальная синусоида

print("\n TASK 2")

var test : UInt8 = 0b0000_0001
var dir : Bool = false // left - false, right - true

for _ in 0..<24 {
    print(test.binary())
    test = dir ? test >> 1 : test << 1
    if (test << 1 == 0 || test >> 1 == 0) {
        dir = !dir
    }
}

//  3. Создайте 64х битное число, которое представляет клетки на шахматной доске.
//  Установите биты так, что 0 - это белое поле, а 1 - черное.
//  Младший бит это клетка а1 и каждый следующий байт начинается с клетки а (а2, а3, а4) и заканчивается клеткой h(h2, h3, h4).
//  Выбирая клетки но индексу столбца и строки определите цвет клетки опираясь исключительно на значение соответствующего бита

print("\n TASK 3")

extension UInt64 {
    func binary() -> String {
        var result = ""
        for i in 0..<64 {
            let mask : UInt64 = 1 << UInt64(i)
            let set = self & mask != 0
            result = (set ? "1" : "0") + result
        }
        return result
    }
}

var x : UInt64 = 0b0000_0000_0000_0000_0000_0000_0000_0000_0000_0000_0000_0000_0000_0000_0000_0000
                // h8, h7, ..........................................................., a3, a2, a1

// 0 - белые, 1 - черные

class Chess {
    
    let letters = ["A","B","C","D","E","F","G","H"]
    let numbers = 0..<8
    
    var dict = [String : UInt64]()
    
    var field : UInt64 = 0  // ...000000
    var mask : UInt64 = 1   // ...000001
    
    init() {
        for (j,value) in letters.enumerated() {
            for i in numbers {
                if (i % 2 == j % 2) { // черные
                    field = field | mask // каждый второй шаг маска будет накладываться на field (получим ..010101)
                    dict["\(value)\(i+1)"] = mask
                } else {
                    dict["\(value)\(i+1)"] = mask
                }
                mask <<= 1 // каждый шаг маска будет сдвигаться на 1 бит влево
                // 0. mask = ...001
                // 0. field = ...001
                // 1. mask = ...010
                // 1. field = ...001
                // 2. mask = ...100
                // 2. field = ...101
            }
        }
        // mask = 0 // маска обнулилась
        // field = 12273903644374837845
        // field.binary() = 10101010_01010101_10101010_01010101_10101010_01010101_10101010_01010101
    }

    // после инициализации
    // field = 0b10101010_01010101_10101010_01010101_10101010_01010101_10101010_01010101
    // mask  = 0b00000000_00000000_00000000_00000000_00000000_00000000_00000000_00000000
    
    subscript(letter: String, number: Int) -> String? {
        let cell = "\(letter)\(number)".uppercased()
        var mask : UInt64 = 0
        if dict[cell] != nil {
            mask = UInt64(dict[cell]!)
        } else {
            return nil
        }
        return mask & field == 0 ? "white" : "black"
    }
        
}
    

let chessBoard = Chess()
if let color = chessBoard["a",1] {
    print("Cell a1 is \(color)")
}
if let color = chessBoard["a",8] {
    print("Cell a8 is \(color)")
}
if let color = chessBoard["h",1] {
    print("Cell h1 is \(color)")
}
if let color = chessBoard["h",8] {
    print("Cell h8 is \(color)")
}
