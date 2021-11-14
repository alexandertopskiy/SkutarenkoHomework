import Foundation

// MARK: - Перегрузка операторов

// MARK: - Домашка

//1. Для нашей структуры Point перегрузить операторы: -, -=, prefix —, postfix —, /, /=, *=

print("\nTASK 1")

struct Point {
    var x: Int
    var y: Int
}

extension Point {
    static func + (a: Point, b: Point) -> Point {
        return Point(x: a.x + b.x, y: a.y + b.y)
    }

    static func * (a: Point, b: Point) -> Point {
        return Point(x: a.x * b.x, y: a.y * b.y)
    }
    
    static func - (a: Point, b: Point) -> Point {
        return Point(x: a.x - b.x, y: a.y - b.y)
    }
    
    static func / (a: Point, b: Point) -> Point {
        return Point(x: a.x / b.x, y: a.y / b.y)
    }
    
    static func -= (a: inout Point, b: Point) {
        a = a - b
    }
    
    static func *= (a: inout Point, b: Point) {
        a = a * b
    }
    
    static func /= (a: inout Point, b: Point) {
        a = a / b
    }
    
    static prefix func -- (a: inout Point) -> Point {
        a.x -= 1
        a.y -= 1
        return a
    }
    
    static postfix func -- (a: inout Point) -> Point  {
        let b = a
        --a
        return b
    }
}

var p1 = Point(x: 2, y: 3)
var p2 = Point(x: 3, y: 2)

p1 = Point(x: 2, y: 3)
p2 = Point(x: 3, y: 4)
print(p1 - p2)

p1 = Point(x: 10, y: 9)
p2 = Point(x: 5, y: 3)
print(p1 / p2)

p1 = Point(x: 5, y: 4)
p2 = Point(x: 3, y: 2)
p1 -= p2
print(p1)

p1 = Point(x: 2, y: 3)
p2 = Point(x: 2, y: 4)
p1 *= p2
print(p1)

p1 = Point(x: 8, y: 9)
p2 = Point(x: 4, y: 3)
p1 /= p2
print(p1)

p1 = Point(x: 10, y: 10)
print(p1--)

p1 = Point(x: 10, y: 10)
print(--p1)


//2. Создать структуру Rect, аналог CGRect, содержащую структуру Size и Point. Перегрузить операторы +, +=, -, -= для этой структуры.

// MARK: - Некорректная работа операторов

print("\nTASK 2")

struct Size {
    var w: Int
    var h: Int
}

struct Rect {
    var origin: Point
    var size: Size
}

extension Size {
    static func + (a: Size, b: Size) -> Size {
        return Size(w: a.w + b.w, h: a.h + b.h)
    }
    static func - (a: Size, b: Size) -> Size {
        return Size(w: a.w - b.w, h: a.h - b.h)
    }
}

extension Rect {
    static func + (rectA: Rect, rectB: Rect) -> Rect {
        let origin = rectA.origin + rectB.origin
        let size = rectA.size + rectB.size
        return Rect(origin: origin, size: size)
    }
    
    static func += (rectA: inout Rect, rectB: Rect) {
        rectA = rectA + rectB
    }
    
    static func - (rectA: Rect, rectB: Rect) -> Rect {
        let origin = rectA.origin - rectB.origin
        let size = rectA.size - rectB.size
        return Rect(origin: origin, size: size)
    }
    
    static func -= (rectA: inout Rect, rectB: Rect) {
        rectA = rectA - rectB
    }
}

var rect1 = Rect(origin: Point(x: 0, y: 0), size: Size(w: 3, h: 4))
var rect2 = Rect(origin: Point(x: 3, y: 3), size: Size(w: 5, h: 2))
print("rect1: \(rect1.origin), \(rect1.size)")
print("rect2: \(rect2.origin), \(rect2.size)")
print("rect1 + rect2: \((rect1 + rect2).origin), \((rect1 + rect2).size)")
rect1 -= rect2
print("rect1 - rect2: \(rect1.origin), \(rect1.size)")

//3. Перегрузить оператор + и += для String, но второй аргумент должен быть Int

print("\nTASK 3")

extension String {
    static func + (a: String, b: Int) -> String {
        return a + String(b)
    }
    
    static func += (a: inout String, b: Int) {
        a = a + b
    }
}

var strA = "Hello,"
var strB = 123
print("strA: \(strA)")
print("strB: \(strB)")
print("strA + strB: \(strA + strB)")
strA += strB
print("strA += strB: \(strA)")

//4. Создать свой оператор, который будет принимать 2 String и в первом аргументе, при совпадении буквы с вторым аргументом, менять совпадения на заглавные буквы

print("\nTASK 4")

infix operator +++=

extension String {
    static func +++= (a: inout String, b: String) {
        let set = Set(b)
        var array = Array(a)
        
        for (index,letter) in array.enumerated() {
            if set.contains(letter) {
                array[index] = Character(letter.uppercased())
            }
        }
        a = String(array)
    }
}

var strTest1 = "abcdefgh"
var strTest2 = "bfh"
print("strTest1: \(strTest1)")
print("strTest2: \(strTest2)")
strTest1 +++= strTest2
print("strTest1 +++= strTest2: \(strTest1)")
