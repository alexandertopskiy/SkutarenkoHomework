import Foundation

// MARK: - Приоритет и ассоциативность

2 + 3 % 4 * 5 // 17
// + имеет самый низкий приоритет -> это последняя операция
// % и * имеют одинаковый приоритет, поэтому выполняются слева направо
2 + ((3 % 4) * 5)
2 + (3 * 5)
2 + (15)

// MARK: - Операторные функции

struct Vector2D {
    var x = 0.0, y = 0.0
}

extension Vector2D {
    static func + (left: Vector2D, right: Vector2D) -> Vector2D {
        return Vector2D(x: left.x + right.x, y: left.y + right.y)
    }
    static func - (left: Vector2D, right: Vector2D) -> Vector2D {
        return Vector2D(x: left.x - right.x, y: left.y - right.y)
    }
}

let vector = Vector2D(x: 3.0, y: 1.0)
let anotherVector = Vector2D(x: 2.0, y: 4.0)
let combinedVector = vector + anotherVector



// MARK: - Префиксные и постфиксные операторы

extension Vector2D {
    static prefix func - (vector: Vector2D) -> Vector2D {
        return Vector2D(x: -vector.x, y: -vector.y)
    }
}
vector
let reverseVector = -vector


// MARK: - Составные операторы присваивания

extension Vector2D {
    static func += (left: inout Vector2D, right: Vector2D) {
        left = left + right
    }
}

var firstVector = Vector2D(x: 2.0, y: 3.0)
let secondVector = Vector2D(x: 3.0, y: 2.0)
firstVector += secondVector
firstVector


// MARK: - Операторы эквивалентности

extension Vector2D : Equatable {
    // это также реализует оператор !=
    static func == (left: Vector2D, right: Vector2D) -> Bool {
        return (left.x == right.x) && (left.y == right.y)
    }
}

Vector2D(x: 1.0, y: 2.0) == Vector2D(x: 2.0, y: 1.0)
Vector2D(x: 1.0, y: 2.0) != Vector2D(x: 2.0, y: 1.0)
Vector2D(x: 1.0, y: 1.0) == Vector2D(x: 1.0, y: 1.0)



// MARK: - Синтезированные операторы эквивалентности

struct Vector3D : Equatable {
    var x = 0.0
    var y = 0.0
    var z = 0.0
}

let first3dVector = Vector3D(x: 1.0, y: 1.0, z: 1.0)
let second3dVector = Vector3D(x: 2.0, y: 2.0, z: 2.0)

first3dVector == second3dVector
first3dVector != second3dVector


// MARK: - Пользовательские операторы

prefix operator +++

extension Vector2D {
    static prefix func +++ (vector: inout Vector2D) -> Vector2D {
        vector += vector
        return vector
    }
}

var toBeDoubled = Vector2D(x: 2.0, y: 3.0)
let afterDoubling = +++toBeDoubled
toBeDoubled
afterDoubling


// MARK: - Приоритет для пользовательских инфиксных операторов

infix operator +-: AdditionPrecedence
extension Vector2D {
    static func +- (left: Vector2D, right: Vector2D) -> Vector2D {
        return Vector2D(x: left.x + right.x, y: left.y - right.y)
    }
}
let fstVector = Vector2D(x: 1.0, y: 2.0)
let sndVector = Vector2D(x: 3.0, y: 4.0)
let plusMinusVector = fstVector +- sndVector


struct Point {
    var x: Int
    var y: Int
}

var p1 = Point(x: 2, y: 3)
var p2 = Point(x: 3, y: 2)

extension Point {
    static func + (a: Point, b: Point) -> Point {
        return Point(x: a.x + b.x, y: a.y + b.y)
    }

    static func * (a: Point, b: Point) -> Point {
        return Point(x: a.x * b.x, y: a.y * b.y)
    }

    static func += (a: inout Point, b: Point) -> Point {
        a = a + b
        return a
    }

    static func == (a: Point, b: Point) -> Bool {
        return (a.x == b.x) && (a.y == b.y)
    }

    static prefix func ++ (a: inout Point) -> Point {
        a.x += 1
        a.y += 1
        return a
    }

    static postfix func ++ (a: inout Point) -> Point {
        let b = a
        ++a
        return b
    }
}

print(++p1)
print(p1++)
print(p1)


// MARK: - Ассоциативность и приоритет

precedencegroup LogicalConjunctionPrecedence {
    associativity : left
    lowerThan: AdditionPrecedence
}

infix operator ** : LogicalConjunctionPrecedence

extension Point {
    static func ** (a: Point, b: Point) -> Point {
        return Point(x: 2 * (a.x + b.x), y: 2 * (a.y + b.y))
    }
}

p1 = Point(x: 2, y: 3)
p2 = Point(x: 3, y: 2)

print(p1 ** p2)

print(p1 + p2 ** p1)
print((p1 + p2) ** p1)

// MARK: - Удаление символов из строки

var str = "Hello, World!!!"

func -= (s1: inout String, s2: String) {
    let set = CharacterSet(charactersIn: s2)
    let components = s1.components(separatedBy: set)
    s1 = components.joined(separator: "")
}

str -= "lo"
print(str)
