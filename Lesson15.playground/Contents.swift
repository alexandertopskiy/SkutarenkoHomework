import UIKit

// MARK: - Свойства типов

struct Cat {
    var name : String
    static let maxAge = 20 // static property
    //  статичное свойство/свойства ТИПА (оно относится не к каждому отдельному классу, а ко всему типу, то есть это    свойство не копируется каждый раз при создании нового экземпляра)
    //  для свойства типа обязательно необходимо указывать дефолтное значение
    static var totalCats = 0
    var age : Int {
        didSet {
            if age > Cat.maxAge {
                age = oldValue
            }
        }
    }
    
    init(name: String, age: Int) {
        self.name = name
        self.age = age
        Cat.totalCats += 1
    }
    
}

let cat1 = Cat(name: "Barsick", age: 10)
let cat2 = Cat(name: "Snow", age: 10)
let cat3 = Cat(name: "Boris", age: 10)
// cat.maxAge - ошибка
Cat.maxAge // свойство типа Cat
Cat.totalCats

class Student {
    var name : String
    static let maxAge = 100
    // в старых версиях Swift static для классов не поддерживался, и все свойства типов указывались так
    // class - указывает, что это свойство типа можно переопределить в подклассах
    class var maxAgeOld : Int {
        return 0
    }
    
    lazy var lifestory = "This is the story of my life...."
    
    var age : Int {
        didSet {
            if age > Student.maxAge {
                age = oldValue
            }
        }
    }
    init(name: String, age: Int) {
        self.name = name
        self.age = age
    }
    
}

let student = Student(name: "Bob", age: 20)
// lazy properties
student
student.lifestory
student


// свойства типов для энумов

enum Direction {
    static let description = "all kinds of directions"
    case up
    case down
    case left
    case right
    
    // энумы не могут хранить stored-свойства, но могут хранить computed properties
    var isVertical : Bool {
        return self == .up || self == .down
    }
    var isHorizontal : Bool {
        return self == .left || self == .right
    }
    
}

Direction.description
let d = Direction.left
d.isVertical
d.isHorizontal

// MARK: - Из методички Apple

struct SomeStructure {
    static var storedTypeProperty = "Some value."
    static var computedTypeProperty: Int {
        return 1
    }
}
enum SomeEnumeration {
    static var storedTypeProperty = "Some value."
    static var computedTypeProperty: Int {
        return 6
    }
}
class SomeClass {
    static var storedTypeProperty = "Some value."
    static var computedTypeProperty: Int {
        return 27
    }
    class var overrideableComputedTypeProperty: Int {
        return 107
    }
}

struct AudioChannel {
    static let thresholdLevel = 10 // максимальное значение порога, которое звуковой уровень может воспроизвести
    static var maxInputLevelForAllChannels = 0 // максимальное входное значение, которое было получено любым экземпляром AudioChannel
    var currentLevel: Int = 0 {
        didSet {
            if currentLevel > AudioChannel.thresholdLevel {
                // ограничиваем уровень звука максимально допустимым уровнем
                currentLevel = AudioChannel.thresholdLevel
            }
            if currentLevel > AudioChannel.maxInputLevelForAllChannels {
                // храним значение в качестве максимального уровня
                AudioChannel.maxInputLevelForAllChannels = currentLevel
            }
        }
    }
}

var leftChannel = AudioChannel()
var rightChannel = AudioChannel()

AudioChannel.maxInputLevelForAllChannels
leftChannel.currentLevel
leftChannel.currentLevel = 7
AudioChannel.maxInputLevelForAllChannels
leftChannel.currentLevel

rightChannel.currentLevel = 11
rightChannel.currentLevel
AudioChannel.maxInputLevelForAllChannels


// MARK: - Домашка

//1. Создать структуру “Описание файла” содержащую свойства:
//- путь к файлу
//- имя файла
//- максимальный размер файла на диске
//- путь к папке, содержащей этот файл
//- тип файла (скрытый или нет)
//- содержимое файла (можно просто симулировать контент)

//Главная задача - это использовать правильные свойства там, где нужно, чтобы не пришлось хранить одни и те же данные в разных местах и т.д. и т.п.

print("\n TASK 1")

enum FileType {
    case open
    case hidden
}

struct FileDescription {
    var fileName : String
    
    static var maxSize : Int = 1024
    var fileSize : Int = 0 {
        didSet {
            if fileSize > FileDescription.maxSize {
                fileSize = oldValue
            }
        }
    }
    
    var pathToFolder : String
    var pathToFile : String {
        return pathToFolder + "/\(fileName)"
    }
    
    var fileType : FileType
    lazy var content : String = "some very big amount of data...."
}
    
let swiftApp = FileDescription(fileName: "swiftApp", fileSize: 1000, pathToFolder: "", fileType: .open)


//2. Создайте энум, который будет представлять некую цветовую гамму. Этот энум должен быть типа Int и как raw значение должен иметь соответствующее 3 байтное представление цвета. Добавьте в этот энум 3 свойства типа: количество цветов в гамме, начальный цвет и конечный цвет.
print("\n TASK 2")

enum ColorGamma : Int, CaseIterable {
    
    case black = 0x00_00_00
    case red = 0xFF_00_00
    case green = 0x00_FF_00
    case blue = 0x00_00_FF
    case white = 0xFF_FF_FF
    
    
    static var countOfColors : Int = ColorGamma.allCases.count
    static var startColor : ColorGamma = ColorGamma.allCases.first!
    static var lastColor : ColorGamma = ColorGamma.allCases.last!
}

print(" ColorGamma has \(ColorGamma.countOfColors) colors")
print(" Start Color is \(ColorGamma.startColor)")
print(" Last Color is \(ColorGamma.lastColor)")




//3. Создайте класс человек, который будет содержать имя, фамилию, возраст, рост и вес. Добавьте несколько свойств непосредственно этому классу чтобы контролировать:
//- минимальный и максимальный возраст каждого объекта
//- минимальную и максимальную длину имени и фамилии
//- минимально возможный рост и вес
//- самое интересное, создайте свойство, которое будет содержать количество созданных объектов этого класса
print("\n TASK 3")

class Human {
    
    static let minAge = 0
    static let maxAge = 100
    static let minNameLenght = 1
    static let maxNameLenght = 15
    static let minHeight = 0.0
    static let maxHeight = 3.0
    static let minWeight = 0.0
    static let maxWeight = 650.0
    
    static var countOfObjects = 0
    
    var name : String {
        didSet {
            if (name.count < Human.minNameLenght) || (name.count > Human.maxNameLenght) {
                name = oldValue
            }
        }
    }
    var lastName : String {
        didSet{
            if (lastName.count < Human.minNameLenght) || (lastName.count > Human.maxNameLenght) {
                lastName = oldValue
            }
        }
    }
    var age : Int {
        didSet {
            if (age < Human.minAge) || (age > Human.maxAge) {
                age = oldValue
            }
        }
    }
    var height : Double {
        didSet {
            if (height < Human.minHeight) || (height > Human.maxHeight) {
                height = oldValue
            }
        }
    }
    var weight : Double {
        didSet {
            if (weight < Human.minWeight) || (weight > Human.maxWeight) {
            weight = oldValue
            }
        }
    }
    
    init(name: String, lastName: String, age: Int, height: Double, weight: Double) {
        self.name = name
        self.lastName = lastName
        self.age = age
        self.height = height
        self.weight = weight
        
        Human.countOfObjects += 1
    }
    
    deinit {
        Human.countOfObjects -= 1
    }
    
}

Human.countOfObjects
let human1 = Human(name: "Alexander", lastName: "Topskiy", age: 21, height: 163, weight: 61)
Human.countOfObjects
let human2 = Human(name: "Alexiy", lastName: "Pryadko", age: 25, height: 163, weight: 61)
Human.countOfObjects

func printInfo(human: Human) {
    print("\(human.name) \(human.lastName): \(human.age) y.o.; \(human.height) sm; \(human.weight) kg")
}

printInfo(human: human1)
printInfo(human: human2)
