import UIKit

// MARK: - 18 - Наследование (Inheritance)

class Human {
    var firstName : String = ""
    var lastName : String = ""
    
    var fullName : String {
        return firstName + " " + lastName
    }
    
    func sayHello() -> String {
        return "Hello"
    }
    
    // final - ключевое слово, которое не дает дочерним классам переопределять метод/свойство
    // можно даже сделать final class, и никто не сможет наследоваться от него
    final func humanInfo() -> String {
        return self.fullName
    }
    
    init(firstName: String, lastName: String) {
        self.firstName = firstName
        self.lastName = lastName
    }
}

let human = Human(firstName: "Alex", lastName: "Topskiy")
human.firstName
human.lastName
human.fullName
human.sayHello()

class Student : Human {
    var group : Int = 0
    
    // переопределение методов родителя
    override func sayHello() -> String {
        return "Wassap"
    }
}

let student = Student(firstName: "Tolya", lastName: "Medvedev")
student.group = 4194
student.sayHello()

class Teacher : Human {
    var fatherName : String = ""
    
    // переопределять можно не только методы, но и свойства
    override var fullName: String {
        return self.firstName + " " + fatherName
    }
    
    override func sayHello() -> String {
        return super.sayHello() + ", students"
    }
}

let teacher = Teacher(firstName: "Sergay", lastName: "Sotnikov")
teacher.sayHello()
teacher.fullName
teacher.fatherName = "Victorovich"
teacher.fullName


class Kid : Human {
    override var firstName: String {
        get { return super.firstName }
        set { super.firstName = newValue + " :)" }
    }
    
    override var lastName: String {
        didSet {
            print("\(oldValue) changed to \(self.lastName)")
        }
    }
    
    override func sayHello() -> String {
        return "vabudubu"
    }
}

let kid = Kid(firstName: "", lastName: "Testov")
kid.firstName = "Tom"
kid.firstName
kid.lastName = "Bobov"


// MARK: - Пример полиморфизма

let arrayOfHumans : [Human] = [kid, human, student, teacher]

for human in arrayOfHumans {
    print(human.sayHello())
}



// MARK: - Из методички Apple

class SomeCar {
    var speed : Double = 0.0
    var gear = 1
}

class AutomaticCar : SomeCar {
    override var speed: Double {
        didSet {
            gear = Int(speed / 45.0) + 1
        }
    }
}

let autoCar = AutomaticCar()
autoCar.speed
autoCar.gear
autoCar.speed = 95
autoCar.speed
autoCar.gear




// MARK: - Домашка

//1. У нас есть базовый клас "Артист" и у него есть имя и фамилия. И есть метод "Выступление". У каждого артиста должно быть свое выступление: танцор танцует, певец поет и тд. А для художника, что бы вы не пытались ставить, пусть он ставит что-то свое (пусть меняет имя на свое артистическое). Когда вызываем метод "выступление" показать в консоле имя и фамилию артиста и собственно само выступление. Полиморфизм используем для артистов. Положить их всех в массив, пройтись по нему и вызвать их метод "выступление"

print("\n TASK 1 ")

class Artist {
    final var name : String = ""
    final var surname : String = ""
    var fullName : String { return name + " " + surname }
    func performing() -> String {
        return "Artist " + fullName + " performs a "
    }
    init(name: String, surname: String) {
        self.name = name
        self.surname = surname
    }
}

class Dancer : Artist {
    override func performing() -> String {
        return super.performing() + "dance"
    }
}

class Singer : Artist {
    override func performing() -> String {
        return super.performing() + "song"
    }
}

class Painter : Artist {
    override var fullName: String { return "Some Mistery Name" }
    override func performing() -> String {
        return super.performing() + "picture"
    }
}

let dancer = Dancer(name: "Cool", surname: "Man")
let singer = Singer(name: "Big", surname: "Throat")
let painter = Painter(name: "Some", surname: "Dude")
var arrOfArtists = [dancer,singer,painter]

for artist in arrOfArtists { print(artist.performing()) }

//2. Создать базовый класс "транспортное средство"
//   добавить три разных проперти: скорость, вместимость и стоимость одной перевозки (computed).
//   Создайте несколько дочерних классов и переопределите их компютед проперти у всех.
//   Создайте класс самолет, корабль, вертолет, машина и у каждого по одному объекту.
//   В компютед пропертис каждого класса напишите свои значения скорости, вместимости, стоимости перевозки.
//   + у вас должен быть свой метод который считает сколько уйдет денег и времени на то, чтобы перевести из пункта А в пункт В определенное количество людей с использованимем наших транспортных средств.
// Вывести в консоль результат (как быстро сможем перевести, стоимость, количество перевозок). Используем полиморфизм

print("\n TASK 2 ")

class Transport {
    var type : String { return "Transport: " }
    var speed : Int { return 0 }
    var capacity : Int { return 0 }
    var coast : Int { return 0 }
        
    func calculate(persons: Int, distance: Int) -> (count: Int, time: Double, money: Int) {
        let count = (persons % capacity) == 0 ? persons/capacity : persons/capacity + 1
        let time = Double(count) * Double(distance)/Double(speed)
        let money = count * self.coast
        return (count,time,money)
    }
}

class Plane : Transport {
    override var type: String { super.type + "Plane" }
    override var speed: Int { return 1000 }
    override var capacity: Int { return 100 }
    override var coast: Int { return 100000 }
}

class Ship : Transport {
    override var type: String { super.type + "Ship" }
    override var speed: Int { return 80 }
    override var capacity: Int { return 300 }
    override var coast: Int { return 200000 }
}

class Helicopter : Transport {
    override var type: String { super.type + "Helicopter" }
    override var speed: Int { return 160 }
    override var capacity: Int { return 6 }
    override var coast: Int { return 10000 }
}

class Car : Transport {
    override var type: String { super.type + "Car" }
    override var speed: Int { return 100 }
    override var capacity: Int { return 5 }
    override var coast: Int { return 5000 }
}

let plane = Plane()
let ship = Ship()
let helicopter = Helicopter()
let car = Car()

var arrOfTransport: [Transport] = [plane, ship, helicopter, car]

func checkTransport(arr: [Transport], people: Int, distance: Int) {
    print("search for a suitable vehicle to transport \(people) people on \(distance) km")
    for vehicle in arrOfTransport {
        print("\n \(vehicle.type)")
        let (count, time, money) = vehicle.calculate(persons: people, distance: distance)
        print(" Number of shipments: \(count)")
        print(" Time for all shipments: \(time) hours")
        print(" Coast of all shipments: \(money) rub")
    }
}

checkTransport(arr: arrOfTransport, people: 100, distance: 500)

// 3. Есть 5 классов: люди, крокодилы, обезьяны, собаки, жирафы. (в этом задании вы будете создавать не дочерние классы, а родительские и ваша задача создать родительский таким образом, что бы группировать эти 5).
//- Создайте по пару объектов каждого класса.
//- Посчитайте пресмыкающихся (создайте масив, поместите туда пресмыкающихся и скажите сколько в нем объектов)
//- Сколько четвероногих?
//- Сколько здесь животных?
//- Сколько живых существ?

print("\n TASK 3")

class Alive { }
class Animal : Alive { }
class Quadruped : Animal { }
class Reptiles : Animal { }

class Man : Alive { }
class Crocodile : Reptiles { }
class Monkey : Animal { }
class Dog : Quadruped { }
class Giraffe : Quadruped { }

let man1 = Man()
let man2 = Man()
let croc1 = Crocodile()
let croc2 = Crocodile()
let monkey1 = Monkey()
let monkey2 = Monkey()
let dog1 = Dog()
let dog2 = Dog()
let giraffe1 = Giraffe()
let giraffe2 = Giraffe()

let arrOfAlives : [Alive] = [man1,man2,croc1,croc2,monkey1,monkey2,dog1,dog2,giraffe1,giraffe2]


//- Пресмыкающихся:
//- Четвероногих:
//- Животных:
//- Живых существ:

print("Пресмыкающихся: \(arrOfAlives.filter{ $0 is Reptiles }.count)")
print("Четвероногих: \(arrOfAlives.filter{ $0 is Quadruped || $0 is Crocodile || $0 is Monkey }.count)")
print("Животных: \(arrOfAlives.filter{ $0 is Animal }.count)")
print("Живых существ: \(arrOfAlives.count)")
