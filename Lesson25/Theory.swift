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
extension UInt32 {
    func binary() -> String {
        var result = ""
        for i in 0..<32 {
            let mask = 1 << i
            let set = Int(self) & mask != 0
            result = (set ? "1" : "0") + result
        }
        return result
    }
}
extension Int8 {
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
UInt8.min
UInt8.max
let min = 0b00000000
let max = 0b11111111

// MARK: - Двоичный вид числа
var a : UInt8 = 57 // UInt8 - число, которое может содержаться в одном байте (0...255)
a.binary()
a += 2
a.binary()
a += 3
a.binary()

a = 0b00111001
a.binary()            // "00111001"
(5 as UInt8).binary() // "00000101"

// MARK: - Переполнение операторов
//   Арифметические операторы в Swift не переполняются по умолчанию. Переполнения отслеживаются и выводятся как ошибка.
//   Для того, чтобы этого избежать, вы можете использовать оператор из второго набора арифметических операторов Swift (&+). Все операторы переполнения начинаются с амперсанда (&).

a
a = a * 2
a = a &* 4 // & перед знаком означает, что мы понимаем, что может произойти переполнение числа

a = 0b11111111
a = a &+ 1

a = 0b00000000
a = a &- 1


// MARK: - Битовые операции

var c : UInt8 = 0b11100001
var d : UInt8 = 0b00110011

// Инверсия
c.binary()
(~c).binary()

// битовое умножение (и, &)
c.binary()
d.binary()
(c & d).binary()

// битовое сложение (или, |)
c.binary()
d.binary()
(c | d).binary()

// сумма по модулю (исключающее или?)
c.binary()
d.binary()
(c ^ d).binary()



// MARK: Битовый сдвиг
    // "<< N" битовый сдвиг влево на N бит.
    // Свдиг влево на 1 бит = умножение на 2. Свдиг вправо на 1 бит = деление на 2.

// MARK: Поведение сдвига для беззнаковых целых чисел
    
a.binary()
a <<= 1
a.binary()

let shiftBits: UInt8 = 4
shiftBits.binary()             // 00000100 бинарный вид
(shiftBits << 1).binary()      // 00001000
(shiftBits << 2).binary()      // 00010000
(shiftBits << 5).binary()      // 10000000
(shiftBits << 6).binary()      // 00000000
(shiftBits >> 2).binary()      // 00000001


// MARK: - Пример использования - (де)шифрование значений

let pink: UInt32 = 0xCC6699

// Каждая пара символов в шестнадцатеричном числе использует 8 битов (проще представить как 0x00CC6699)
// Сдвиг вправо на 16 позиций преобразует число 0xCC0000 в 0x0000CC
let redComponent = (pink & 0xFF0000) >> 16  // redComponent равен 0xCC, или 204
pink.binary()
(0xFF0000 as UInt32).binary()
(pink & 0xFF0000).binary()
redComponent.binary()

let greenComponent = (pink & 0x00FF00) >> 8 // greenComponent равен 0x66, или 102
greenComponent.binary()
let blueComponent = pink & 0x0000FF         // blueComponent равен 0x99, или 153
blueComponent.binary()


// MARK: - Поведение побитового сдвига для знаковых целых чисел

// MARK: - Знаковые числа

var fourPlus : Int8 = 4
fourPlus.binary()
var fourMinus : Int8 = -4 // 2^7-4 или 128 - 4 = 124
(124 as Int8).binary()
fourMinus.binary()

// у ЗНАКОВЫХ типов данных первый бит отвечает за знак (0 +, 1 -)
var b : Int8 = 57
b.binary()

// MARK: - Операторы переполнения

var potentialOverflow = Int16.max // 32767
//potentialOverflow += 1 // это вызовет ошибку

var willOverflow = UInt8.max // 255
willOverflow.binary()
willOverflow = willOverflow &+ 1 // 0
willOverflow.binary()

var unsignedOverflow = UInt8.min // 0
unsignedOverflow.binary()
unsignedOverflow = unsignedOverflow &- 1 // 255
unsignedOverflow.binary()

var signedUnderflow = Int8.min // -128
signedUnderflow.binary()
signedUnderflow = signedUnderflow &- 1 // 127
signedUnderflow.binary()

b = 0b01111111
b.binary()
b = b &+ 1
b.binary()

b = 0b00000000
b.binary()
b = b &- 1
b.binary()

b = 0b00100001
b.binary()
b = b << 1
b.binary()
b = b << 1
b.binary()

// MARK: - Применение битовых операций (битовые маски)
// вместо обявления множества булевых значений можно создать маску (например, 1101) и сравнить вход с ней

// проверка бита
var mask : UInt8 = 0b0010_0000
c.binary()
mask.binary()
(c & mask).binary() // проверка, больше 0 или равно 0 после умножения на маску

// установка бита
mask = 0b0000_0100
d.binary()
mask.binary()
d = (d | mask)
d.binary()

// установка бита, если там ничего нет и сброс бита, если там уже 1
mask = 0b1010_0100
d.binary()
mask.binary()
(d ^ mask).binary() // сумма по модулю (исключающее или?)

// чтобы сбросить бит числа нужно уножить это число на инвертированную маску

mask = 0b0001_0000
d.binary()
(~mask).binary()
d = (d & ~mask)
d.binary()
