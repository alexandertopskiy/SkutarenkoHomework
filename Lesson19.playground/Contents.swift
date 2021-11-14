import UIKit

// MARK: - 19 - Инициализаторы (Часть 1)

class Student {
    var firstName : String
    var lastName : String
    var fullName : String {
        return firstName + " " + lastName
    }
    
    // базовый инициализатор
    init() {
        self.firstName = ""
        self.lastName = ""
    }
}
// значения задаются по умолчанию -> инициализатор не нужен
class Student2 {
    var firstName : String = ""
    var lastName : String = ""
}
class Student3 {
    var firstName : String
    var lastName : String
    var middleName : String? // если свойство опциональное, то необязательно задавать его в конструкторе
    
    init(firstName: String, lastName: String) {
        self.firstName = firstName
        self.lastName = lastName
    }
}

// Let-свойства нельзя переопределять в дочерних классах, если значение уже задано в родительском конструкторе
class Test1 {
    let maxAge : Int
    init() {
        maxAge = 100
    }
}
class Test2 : Test1 {
    override init() {
        // maxAge = 150 - ошибка!
    }
}

// MARK: - Структуры

// Можно обойтись без инициализатора
struct Student4 {
    var firstName : String
    var lastName : String
}
let student1 = Student4(firstName: "a", lastName: "b")
struct Student5 {
    var firstName : String
    var lastName : String
    
    // Можно сделать дефолтный
    init() {
        self.firstName = ""
        self.lastName = ""
    }
    
    // Можно сделать конкретный
    init(firstName: String, lastName: String) {
        self.firstName = firstName
        self.lastName = lastName
    }
}
let student2 = Student5(firstName: "a", lastName: "b")
let student3 = Student5()



// MARK: - Назначенный и вспомогательный инициализатор

class Human {
    var weight : Int
    var age: Int
    
    // назначенный (designated) инициализатор
    init(weight : Int, age: Int) {
        self.weight = weight
        self.age = age
    }
    
    // вспомогательный (convenience) инициализатор
    convenience init(age: Int) {
        self.init(weight: 0, age: age)
    }
    
    convenience init(weight: Int) {
        self.init(weight: weight, age: 0)
    }
    
    convenience init() {
        self.init(weight: 0)
    }
    
    func test() {
        
    }
}

class Man : Human {
    var firstName : String
    var lastName : String
    var fullName : String {
        return firstName + " " + lastName
    }
    
    init(firstName : String, lastName : String) {
//        super.init(weight: 0, age: 0) - ошибка, т.к. сначала нужно инициализировать новые свойства
//        test() - ошибка (еще не прошла 1 фаза)
//        self.weight - ошибка (еще не прошла 1 фаза)
        
        self.firstName = firstName
        self.lastName = lastName
        //  super.init() в подклассе можно вызвать только designated инициализатор!
        super.init(weight: 0, age: 0)
        
        // - прошла "1 фаза" инициализации, только после этого можно делать какие-то настройки (вызывать методы/менять свойства)
        test()
        self.weight
    }
    
    override convenience init(weight: Int, age: Int) {
        self.init(firstName: "firstName")
        self.weight = weight
        self.age = age
    }
    
    convenience init(firstName: String) {
        // super.init(age: 1) - нельзя вызывать super-init в convenience дочернего класса
        self.init(firstName : firstName, lastName : "")
    }

}


// MARK: - 20 - Инициализаторы (Часть 2)

// MARK: - Переопределение инициализаторов

// чтобы дочерний класс унаследовал все convenience инициализаторы родителя нужно выполнить 1 из 2 условий
// 1) в дочернем классе не должно быть своих designated инициализаторов
// 2) если у дочернего класса есть свои designated инициализаторы, то он должен переопределить все designated инициализаторы родителя

// можно переопределить родительский designated-метод в convenience (override convenience), тогда мы избавимся от двух зайцев: унаследуем все инициализаторы родителей без необходимости переопределения ДАННОГО инициализатора в дальнейшем, для дочерних классов


class Doctor : Man {
    var fieldOfStudy : String = ""
        
    // также можно определить convenience инициализаторы, которые внутри будут ссылаться на УЖЕ УНАСЛЕДОВАННЫЕ инициализаторы родителя (то есть к ним можно обратиться через self)
//    convenience init(fieldOfStudy : String) {
//        self.init(firstName: "", lastName: "")
//        self.fieldOfStudy = fieldOfStudy
//    }
    
    // если мы определили новый, собственный designated инициализатор,...
    init(fieldOfStudy : String) {
        self.fieldOfStudy = fieldOfStudy
        super.init(firstName: "Name", lastName: "Surname")
    }
    
//    , то мы можем вернуть инициализаторы родителя, переопределив их
    override init(firstName: String, lastName: String) {
        self.fieldOfStudy = "Some Field"
        super.init(firstName: firstName, lastName: lastName)
    }
    
    convenience init(firstName: String) {
        self.init(fieldOfStudy: "Math")
        self.firstName = firstName
        self.age = 35
    }
    
    // при этом также наследуются все convenience инициализаторы родителя (НО ПРИ УСЛОВИИ, ЧТО МЫ ПЕРЕОПРЕДЕЛИЛИ ВСЕ ЕГО DESIGNATED ИНИЦИАЛИЗАТОРЫ)
    
//    override init(weight: Int, age: Int) {
//        self.fieldOfStudy = "Some Field"
//        super.init(weight: weight, age: age)
//    }
    
}

let doc1 = Doctor(fieldOfStudy: "Testing Field") // собственный новый designated
let doc2 = Doctor(firstName: "Doc", lastName: "Tock") // переопределенный designated родителя
let doc3 = Doctor(firstName: "Doctor") // унаследованный от родителя convenience
let doc4 = Doctor(weight: 10, age: 10) // override convenience в классе Man и унаследованный доктором

class Animal {
    var weight : Int
    var age: Int
    
    // назначенный (designated) инициализатор
    init(weight : Int, age: Int) {
        self.weight = weight
        self.age = age
    }
    
    convenience init(age: Int) {
        self.init(weight: 0, age: age)
    }
    
    convenience init(weight: Int) {
        self.init(weight: weight, age: 0)
    }
    
    convenience init() {
        self.init(weight: 0)
    }
    
    func test() {
        
    }
}
class Dog : Animal {
    var name : String
    
    init(name : String) {
        self.name = name
        super.init(weight: 0, age: 0)
    }
    
    convenience init() {
        self.init(name : "")
    }
    

}



// MARK: - 20 - Инициализаторы (Часть 3)

// MARK: - Failable (Проваливающиеся) Инициализаторы

enum Color : Int {
    case Black
    case White
    case Yellow
    
    // явное описание проваливающегося инициализатора (который есть по умолчанию как init(rawValue:Int))
    init?(withValue: Int) {
        switch withValue {
        case 0: self = .Black
        case 1: self = .White
        case 2: self = .Yellow
        default: return nil
        }
    }
}
let color1 = Color(withValue: 0)
let color2 = Color(withValue: 1)
let color3 = Color(withValue: -1)
let color4 = Color(rawValue: 0)

struct ReqSize {
    var width : Int
    var height : Int
    
    
    init?(width : Int, height : Int) {
        if (width < 0 || height < 0) {
            return nil
        }
        self.width = width
        self.height = height
    }
}

class Friend : Man {
    var name : String
    var skinColor : Color = {
        let rand = Int.random(in: 0...2)
        return Color(withValue: rand)!
    }()
    
    init?(name: String) {
        self.name = name
        super.init(firstName: name, lastName: "")
        // MARK: - Failable инициализатор класса может выкидывать nil только после 1 фазы инициализации!
        if name.isEmpty {
            return nil
        }
    }
    
    // required - обязывает переопределять инициализатор во всех подклассах
    required init() {
        self.name = "Name"
        super.init(firstName: name, lastName: "")
    }
}
let nilBro = Friend(name: "")
let bro = Friend(name: "Bro")

// MARK: - Можно переопределить Failable в обычный, но нельзя сделать наоборот (обычный в Failable)
class BestFriend : Friend {
    
    override init(name: String) {
        if name.isEmpty {
            super.init()
        } else {
            super.init(name: name)!
        }
    }
    
    required init() {
        super.init()
    }
    
}

let bf = BestFriend(name: "")

// MARK: - Деинициализация
class TestClassParent {
    deinit {
        print("TestClassParent deinited")
    }
}
class TestClass : TestClassParent {
    deinit {
        print("TestClass deinited")
    }
}
struct TestStruct {
    var testClass : TestClass? = TestClass()
}
var testStruct = TestStruct()
testStruct.testClass = nil





// MARK: - Из методички Apple

// MARK: - Делегирование инициализатора для типов значения
struct Size {
  var width = 0.0, height = 0.0
}
struct Point {
  var x = 0.0, y = 0.0
}

struct Rect {
    
    var origin = Point()
    var size = Size()
    
    // MARK: - 1-й способ инициализации:
    init() {
        
    }
    
    // MARK: - 2-й способ инициализации:
    init(origin: Point, size: Size) {
        self.origin = origin
        self.size = size
    }
    
    // MARK: - 3-й способ инициализации:
    init(center: Point, size: Size) {
        let originX = center.x - (size.width / 2)
        let originY = center.y - (size.height / 2)
        self.init(origin: Point(x: originX, y: originY), size: size)
    }
    
}

let basicRect = Rect()
print("BasicRect: origin: \(basicRect.origin); size: \(basicRect.size)")

let originRect = Rect(origin: Point(x: 0, y: 0), size: Size(width: 5, height: 3))
print("OriginRect: origin: \(originRect.origin); size: \(originRect.size)")

let centerRect = Rect(center: Point(x: 3, y: 3), size: Size(width: 6, height: 4))
print("CenterRect: origin: \(centerRect.origin); size: \(centerRect.size)")



// MARK: - Переопределение инициализаторов

class Food {
    var name: String
    init(name: String) {
        print("test 1 ")
        self.name = name
    }
    convenience init() {
        print("test 2")
        self.init(name: "[Unnamed]")
    }
}

class RecipeIngredient: Food {
    var quantity: Int
    init(name: String, quantity: Int) {
        print("test 3 ")
        self.quantity = quantity
        super.init(name: name)
    }
    override convenience init(name: String) {
        print("test 4")
        self.init(name: name, quantity: 1)
    }
}

// MARK: - Порядок инициализации:
// 1. вызов данного УНАСЛЕДОВАННОГО инициализатора (convenience init() от родителя)
// 2. Так как предыдущий init унаследован, то сейчас self - это сам RecipeIngredient. Следовательно вызываем self.init(name: "[Unnamed]"). А именно override convenience init(name: String)
// 3. Он вызывает self.init(name: name, quantity: 1). Это собственный designated инициализатор RecipeIngredient
// 4. Он вызывает super.init(name: name) класса-родителя. Инициализация завершается в designated-инициализаторе базового класса!

let test = RecipeIngredient()

class ShoppingListItem: RecipeIngredient {
    var purchased = false
    var description: String {
        var output = "\(quantity) x \(name)"
        output += purchased ? " ✔" : " ✘"
        return output
    }
}

var breakfastList = [
    ShoppingListItem(),
    ShoppingListItem(name: "Bacon"),
    ShoppingListItem(name: "Eggs", quantity: 6),
]
breakfastList[0].name = "Orange juice"
breakfastList[0].purchased = true
for item in breakfastList {
    print(item.description)
}



// MARK: - Проваливающиеся инициализаторы

let wholeNumber: Double = 12345.0
let pi = 3.14159

if let valueMaintained = Int(exactly: wholeNumber) {
  print("\(wholeNumber) преобразование в Int поддерживает значение \(valueMaintained)")
}
// Prints "12345.0 conversion to Int maintains value of 12345"

let valueChanged = Int(exactly: pi)
// valueChanged is of type Int?, not Int

if valueChanged == nil {
  print("\(pi) преобразование в Int невозможно")
}
// Выведет "3.14159 преобразование в Int невозможно"


enum TemperatureUnit {
    case kelvin, celsius, fahrenheit
    init?(symbol: Character) {
        switch symbol {
            case "K": self = .kelvin
            case "C": self = .celsius
            case "F": self = .fahrenheit
            default: return nil
        }
    }
}

let celcius = TemperatureUnit(symbol: "C")
let fahrenheit = TemperatureUnit(symbol: "F")
let kelvin = TemperatureUnit(symbol: "K")
let someNil = TemperatureUnit(symbol: "Q")


class Product {
    let name: String
    init?(name: String) {
        if name.isEmpty { return nil }
        self.name = name
    }
}

class CartItem: Product {
    let quantity: Int
    init?(name: String, quantity: Int) {
        if quantity < 1 { return nil }
        self.quantity = quantity
        super.init(name: name)
    }
}

if let twoSocks = CartItem(name: "sock", quantity: 2) {
    print("Item: \(twoSocks.name), quantity: \(twoSocks.quantity)")
}

if let zeroShirts = CartItem(name: "shirt", quantity: 0) {
    print("Item: \(zeroShirts.name), quantity: \(zeroShirts.quantity)")
} else {
    print("Невозможно инициализировать ноль футболок")
}

if let oneUnnamed = CartItem(name: "", quantity: 1) {
    print("Item: \(oneUnnamed.name), quantity: \(oneUnnamed.quantity)")
} else {
    print("Невозможно инициализировать товар без имени")
}



// MARK: - Deinit

class Bank {
    static var coinsInBank = 10_000
    static func distribute(coins numberOfCoinsRequested: Int) -> Int {
        let numberOfCoinsToVend = min(numberOfCoinsRequested, coinsInBank)
        coinsInBank -= numberOfCoinsToVend
        return numberOfCoinsToVend
    }
    static func receive(coins: Int) {
        coinsInBank += coins
    }
}

class Player {
    var coinsInPurse: Int
    init(coins: Int) {
        coinsInPurse = Bank.distribute(coins: coins)
    }
    func win(coins: Int) {
        coinsInPurse += Bank.distribute(coins: coins)
    }
    deinit {
        Bank.receive(coins: coinsInPurse)
    }
}

var playerOne: Player? = Player(coins: 100)
print("A new player has joined the game with \(playerOne!.coinsInPurse) coins")
// Выведет "A new player has joined the game with 100 coins"
print("There are now \(Bank.coinsInBank) coins left in the bank")
// Выведет "There are now 9900 coins left in the bank"


playerOne!.win(coins: 2_000)
print("PlayerOne won 2000 coins & now has \(playerOne!.coinsInPurse) coins")
// Выведет "PlayerOne won 2000 coins & now has 2100 coins"
print("The bank now only has \(Bank.coinsInBank) coins left")
// Выведет "The bank now only has 7900 coins left"

playerOne = nil
print("PlayerOne has left the game")
// Выведет "PlayerOne has left the game"
print("The bank now has \(Bank.coinsInBank) coins")
// Выведет "The bank now has 10000 coins"

enum Chess {
    case King(color: ChessColor, x: Int)
    case Queen(color: ChessColor, x: Int)
}

enum ChessColor {
    case White
    case Black
}

var king = Chess.King(color: .White, x: 1)
var queen = Chess.Queen(color: .Black, x: 10)

switch king {
case .King(let color, let x) :
    print("King with \(color) color and \(x) coord")
case let .Queen(color, x) :
    print("Queen with \(color) color and \(x) coord")
}

if case .Queen(let color, let x) = queen {
    print("Queen with \(color) color and \(x) coord")
}

// MARK: - Домашка

