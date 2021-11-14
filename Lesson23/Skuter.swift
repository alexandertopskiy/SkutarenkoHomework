import Foundation

// MARK: - 23 - Опциональные Цепочки и Приведение Типов

// MARK: - Скутаренко

class Address {
    var street = "Chistopolskaya"
    var number = "61d"
    var city = "Kazan"
    var country = "Russia"
}

// структура для наглядности работы optional chaining и с классами, и со структурами
struct Garage {
    var size = 2 // число машин
}

class House {
    var rooms = 1
    var address = Address()
    var garage : Garage? = Garage()
}

class Car {
    var model = "Porche"
    func drive() {
        
    }
}

class Person {
    var cars : [Car]? = [Car()]
    var house : House? = House()
}

let p = Person()
// p.house
// p.cars![0]

// узнать размер гаража
// p.house!.garage!.size // но программа упадет, если хоть что-то будет nil

// альтернатива - optional binding
if let house = p.house {
    if let garage = house.garage {
        garage.size
    }
}
// но так нужно делать много проверок и если глубина будет большой, то будет много кода

// альтернатива - optional chaining

p.house?.garage?.size
if let size = p.house?.garage?.size {
    size
}

// также можно и устанавливать значение
p.house?.garage?.size = 3 // это вернет нам значение (или nil)
if let size = p.house?.garage?.size {
    size
}

if (p.house?.garage?.size = 5) != nil {
    print("upgrade!")
} else {
    print("failure!")
}
p.house?.garage?.size

(p.cars?[0].model)!

// MARK: - Type casting (приведение типов)

class Symbol {
    func symbolMethod() {}
}

class A : Symbol {
    func aMethod() {}
}

class B : Symbol {
    func bMethod() {}
}

var (aCount,bCount,sCount) = (0,0,0)

//AnyObject - любой ОБЪЕКТ
//Any - вообще что угодно (объкты, цифры, строки, замыкания, функции)

let array : [Any] = [A(), B(), Symbol(), A(), A(), B(), "a", 5, {() -> () in print("closureText")}]

// is - проверка типа класса (вернет bool)
// as - приведение к типу (вернет объект типа или nil), есть as? и as! (или простое as)

for value in array {
    if value is A { aCount += 1 }
    else if value is B { bCount += 1 }
    else if value is String { print(value) }
    else if value is Int { print(value) }
    else if value is () -> () { print("closure") }
    else { sCount += 1 }
    
    if let a = value as? A {
        a.aMethod()
    } else if let b = value as? B {
        b.bMethod()
    } else if let s = value as? Symbol {
        s.symbolMethod()
    }
    else if let fun = value as? () -> () {
        fun()
    }
}

print(aCount)
print(bCount)
print(sCount)
