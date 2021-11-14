import UIKit

// MARK: - Методы

struct Point {
    var x: Int
    var y: Int
    
    // желательно первый параметр описать в названии метода и не писать для нее label (но в новых версиях Swift ругается, если не указать _)
    // mutating - ключевое слово для value type (структуры и энумы) для изменения свойств самого экземпляра
    mutating func moveByX(_ x: Int, andY y: Int) {
        self.x += x
        self.y += y
    }
    // альернативный метод - изменение самого self (экземпляра), а не свойств
    mutating func moveBy(x: Int, y: Int) {
        self = Point(x: self.x + x, y: self.y + y)
    }
}

var point = Point(x: 1, y: 1)
point.moveByX(2, andY: 3)


// MARK: - для энумов

enum Color {
    case Black
    case White
    
    mutating func invert() {
        self = self == .Black ? .White : .Black
        self.printInfo()
    }
    
    func printInfo() {
        if self == .Black {
            print("Black")
        } else {
            print("White")
        }
        
    }
    
    // метод типа
    static func count() -> Int {
        return 2
    }
    
}

Color.count()

var white = Color.White
white.invert()
white.invert()



// MARK: - Из методички Apple

struct LevelTracker {
    static var highestUnlockedLevel = 1
    var currentLevel = 1
    
    static func unlock(_ level: Int) {
        if level > highestUnlockedLevel { highestUnlockedLevel = level }
    }
    
    static func isUnlocked(_ level: Int) -> Bool {
        return level <= highestUnlockedLevel
    }

    //  маркер @discardableResult означает, что мы можем и не использовать результат работы функции
    @discardableResult mutating func advance(to level: Int) -> Bool {
        if LevelTracker.isUnlocked(level) {
            currentLevel = level
            return true
        } else {
            return false
        }
    }
}

class Player {
    var tracker = LevelTracker()
    let name : String
    func complete(level: Int) {
        LevelTracker.unlock(level + 1)
        tracker.advance(to: level + 1)
    }
    init(name: String) {
        self.name = name
    }
}

let player = Player(name: "Alex")
print("Current level of \(player.name) is \(player.tracker.currentLevel)")
player.complete(level: 1)
print("Level 1 completer")
print("Current level of \(player.name) is \(player.tracker.currentLevel)")
print("Max available level now is of \(LevelTracker.highestUnlockedLevel)")

let x = 3
if (player.tracker.advance(to: x)) {
    print("\(player.name) is on \(x) level now")
} else {
    print("Level \(x) is not unlocked yet")
}


// MARK: - Домашка (в отдельном проекте)

//Сделаем с вами небольшую игру

//1. Создайте тип Комната. У комнаты есть размеры W на H. И создайте тип Персонаж. У него есть координата в комнате X и Y. Реализуйте функцию, которая красивенько текстом будет показывать положение персонажа в комнате

//2. Персонажу добавьте метод идти, который принимает энумчик лево, право, верх, вниз
// Этот метод должен передвигать персонажа. Реализуйте правило что персонаж не должен покинуть пределы комнаты. Подвигайте персонажа и покажите это графически

//3. Создать тип Ящик. У ящика также есть координата в комнате X и Y. Ящик также не может покидать пределы комнаты и ящик также должен быть распечатан вместе с персонажем в функции печати.

//4. Теперь самое интересное, персонаж может двигать ящик, если он стоит на том месте, куда персонаж хочет попасть. Главное что ни один объект не может покинуть пределы комнаты. Подвигайте ящик :)

//5. Добавьте точку в комнате, куда надо ящик передвинуть и двигайте :)

//Для суперменов: можете добавить массив ящиков и можете сделать консольное приложение

