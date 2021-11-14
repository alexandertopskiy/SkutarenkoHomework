import Foundation

// MARK: - Домашка

//1. Создайте тип Комната. У комнаты есть размеры W на H. И создайте тип Персонаж. У него есть координата в комнате X и Y. Реализуйте функцию, которая красивенько текстом будет показывать положение персонажа в комнате
//2. Персонажу добавьте метод идти, который принимает энумчик лево, право, верх, вниз. Этот метод должен передвигать персонажа. Реализуйте правило что персонаж не должен покинуть пределы комнаты. Подвигайте персонажа и покажите это графически
//3. Создать тип Ящик. У ящика также есть координата в комнате X и Y. Ящик также не может покидать пределы комнаты и ящик также должен быть распечатан вместе с персонажем в функции печати.
//4. Теперь самое интересное, персонаж может двигать ящик, если он стоит на том месте, куда персонаж хочет попасть. Главное что ни один объект не может покинуть пределы комнаты. Подвигайте ящик :)
//5. Добавьте точку в комнате, куда надо ящик передвинуть и двигайте :)
//Для суперменов: можете добавить массив ящиков и можете сделать консольное приложение

// IDEAS : переделать на классы, добавить класс-клетку со свойствами (пустая/ящик/человек/точка назначения/тупик)

enum Direction {
    case left
    case right
    case up
    case down
}

enum ErrorType {
    case wrongCommand
    case boxAhead
    case onTheBorder
    case outOfRoom
    case unknownError
}

struct Box {
    var x: Int
    var y: Int
    static var imageOfBox : String = "📦"
}

struct DestinationCell {
    var x: Int
    var y: Int
    var imageOfDestinationCell : String = "✅"
}

struct Room {
    var w: Int
    var h: Int
    static var imageOfEmptyCell : String = "◽️"
    static var winningCell : String = "🎁"
    func showRoom(person: Person, arrayOfBoxes: [Box], destinationCell cell: DestinationCell) {
        for y in 1...self.h {
            var str = ""
            for x in 1...self.w {
                if (x == person.x && y == self.h - person.y + 1) {
                    str += Person.imageOfPerson
                }
                else if (x == cell.x && y == self.h - cell.y + 1){
                    str += cell.imageOfDestinationCell
                }
                else if (arrayOfBoxes.contains { box in
                    if case x = box.x, y == self.h - box.y + 1 {
                        return true
                    } else {
                        return false
                    }
                }) {
                    str += Box.imageOfBox
                }
                else {
                    str += Room.imageOfEmptyCell
                }
            }
            print(str)
        }
    }
    func showWinningRoom(person: Person) {
        for y in 1...self.h {
            var str = ""
            for x in 1...self.w {
                if (x == person.x && y == self.h - person.y + 1) {
                    str += Person.imageOfPerson
                } else {
                    str += Room.winningCell
                }
            }
            print(str)
        }
    }
}

struct Person {
    var name: String
    var x: Int
    var y: Int
    static var imageOfPerson : String = "💁‍♂️"
        
    mutating func moveTo(toDirection: Direction, inRoom room: Room, withBoxes boxes: inout [Box], withDestCell cell: DestinationCell) -> Bool {
        var wasMoved : Bool = false
        for (i,box) in boxes.enumerated() {
            switch toDirection {
            case .left:
                if (self.x - 1 > 0) {
                    if (box.x == self.x - 1 && box.y == self.y) { // в точке, куда идем, лежит коробка
                        for otherBox in boxes { // если двигаем в клетку, где лежит другая коробка
                            if (otherBox.x == box.x - 1 && otherBox.y == box.y) {
                                return printError(errorType: .boxAhead)
                            }
                        }
                        if (box.x - 1 > 0) { // если клетка, куда двигаем лежит в пределах комнаты
                            self.x -= 1
                            boxes[i].x -= 1
                            wasMoved = true
                        } else {
                            return printError(errorType: .onTheBorder)
                        }
                    } else if (!wasMoved && i == boxes.count - 1) { // если проверили все коробки, и это последняя, то просто шагаем
                        self.x -= 1
                        wasMoved = true
                    }
                } else {
                    return printError(errorType: .outOfRoom)
                }
            case .right:
                if (self.x + 1 <= room.w) {
                    if (box.x == self.x + 1 && box.y == self.y) { // в точке, куда идем, лежит коробка
                        for otherBox in boxes { // если двигаем в клетку, где лежит другая коробка
                            if (otherBox.x == box.x + 1 && otherBox.y == box.y) {
                                return printError(errorType: .boxAhead)
                            }
                        }
                        if (box.x + 1 <= room.w) { // если клетка, куда двигаем лежит в пределах комнаты
                            self.x += 1
                            boxes[i].x += 1
                            wasMoved = true
                        } else {
                            return printError(errorType: .onTheBorder)
                        }
                    } else if (!wasMoved && i == boxes.count - 1) { // если проверили все коробки, и это последняя, то просто шагаем
                        self.x += 1
                        wasMoved = true
                    }
                } else {
                    return printError(errorType: .outOfRoom)
                }
            case .up:
                if (self.y + 1 <= room.h) {
                    if (box.x == self.x && box.y == self.y + 1) { // в точке, куда идем, лежит коробка
                        for otherBox in boxes { // если двигаем в клетку, где лежит другая коробка
                            if (otherBox.x == box.x && otherBox.y == box.y + 1) {
                                return printError(errorType: .boxAhead)
                            }
                        }
                        if (box.y + 1 <= room.h) { // если клетка, куда двигаем лежит в пределах комнаты
                            self.y += 1
                            boxes[i].y += 1
                            wasMoved = true
                        } else {
                            return printError(errorType: .onTheBorder)
                        }
                    } else if (!wasMoved && i == boxes.count - 1) { // если проверили все коробки, и это последняя, то просто шагаем
                        self.y += 1
                        wasMoved = true
                    }
                } else {
                    return printError(errorType: .outOfRoom)
                }
                
            case .down:
                if (self.y - 1 > 0) {
                    if (box.x == self.x && box.y == self.y - 1) { // в точке, куда идем, лежит коробка
                        for otherBox in boxes { // если двигаем в клетку, где лежит другая коробка
                            if (otherBox.x == box.x && otherBox.y == box.y - 1) {
                                return printError(errorType: .boxAhead)
                            }
                        }
                        if (box.y - 1 > 0) { // если клетка, куда двигаем лежит в пределах комнаты
                            self.y -= 1
                            boxes[i].y -= 1
                            wasMoved = true
                        } else {
                            return printError(errorType: .onTheBorder)
                        }
                    } else if (!wasMoved && i == boxes.count - 1) { // если проверили все коробки, и это последняя, то просто шагаем
                        self.y -= 1
                        wasMoved = true
                    }
                } else {
                    return printError(errorType: .outOfRoom)
                }
            }
        }
        if wasMoved { // сдвинулся ли человек и/или коробка
            var indexOfEaten : Int?
            for (i,box) in boxes.enumerated() {
                if (box.x == cell.x && box.y == cell.y) { // если убрали коробку, то удалить из массива
                    indexOfEaten = i
                }
            }
            // съели удинственный ящик в массиве? победили! нет? убрать из массива
            if let index = indexOfEaten {
                if (boxes.count == 1) {
                    print("\n CONGRATULATIONS, \(self.name)! YOU WON!!!")
                    room.showWinningRoom(person: self)
                    return true
                } else {
                    boxes.remove(at: index)
                    print("\n YOU JUST ATE A BOX! \(boxes.count) LEFT!!!")
                }
            }
            print("\n New position: ")
            room.showRoom(person: self, arrayOfBoxes: boxes, destinationCell: cell)
        }
        return false
    }
}

//проверка корректности ввода координат/размера (тюпл из двух интов)
func checkInput(input: String, range: ClosedRange<Int>) -> (a: Int, b: Int)? {
    let arr = Array(input)
    func index() -> Int? {
        for (i,num) in arr.enumerated() {
            if (num == ",") {
                return i
            }
        }
        return nil
    }
    if let i = index() {
        if (arr.count > i + 1) && (i > 0) {
            let a = arr.prefix(upTo: i)
            let b = arr.suffix(from: i+1)
            if let x = Int(String(a)), let y = Int(String(b)) {
                switch (x,y) {
                case let(x,y) where (x <= 0 || y <= 0):
                    print(" input incorrect! coords should be positive! ")
                    return nil
                case let(x,y) where (x > range.upperBound || y > range.upperBound):
                    print(" input incorrect! it's too big room!")
                    return nil
                case let(x,y) where (x < range.lowerBound || y < range.lowerBound):
                    print(" input incorrect! it's too small room! ")
                    return nil
                default:
                    return (x,y)
                }
            }
        }
    }
    print("input incorrect! please enter data like 'a,b'")
    return nil
}

//вывод ошибок
//@discardableResult - мы можем и не использовать результат работы функции
@discardableResult func printError(errorType: ErrorType) -> Bool {
    switch errorType {
        case .wrongCommand: print("there's no such action! please repeat enter")
        case .boxAhead: print("error! you can't move the box, because there's other one ahead of this one!")
        case .onTheBorder: print("error! you can't move the box, because it's on the border of room!")
        case .outOfRoom: print("error! this position is out of room!")
        case .unknownError: print("unknown error!")
    }
    return false
}

var globalName : String = ""
var room : Room = Room(w: 0, h: 0)
var countOfBoxes : Int = 0
var arrayOfBoxes : [Box] = []
var isGameOver = false

while !isGameOver {
    print("\n Hi! Please tell us your name and set up settings for game!")
    
    // MARK: - Указываем имя
    while true {
        print("\n Your name: ", terminator: "")
        if let name = readLine() {
            print("\n Hello, \(name)!")
            globalName = name
            break
        } else {
            printError(errorType: .unknownError)
        }
    }
    
    // MARK: - Задаем размеры комнаты
    while true { // вводить, пока не введем правильно
        print("\n Size of room in 'x,y' format (positive numbers, in range [4;25]): ", terminator: "")
        if let coords = readLine() { // если что-то ввели
            if let x = checkInput(input: coords, range: 4...25) { // если ввели верно
                room = Room(w: x.a, h: x.b)
                break
            }
        } else {
            printError(errorType: .unknownError)
        }
    }
                    
    // MARK: - Задаем координаты человека/число коробок и их координаты /точку назначения рандомно, но в разных точках
    // MARK: - Задаем сложность (сколько коробок будет)
    // TODO: - НАСТРОИТЬ ЛОГИКУ ПОСТРОЕНИЯ (при каждом размере свое максимальное число ящиков в комнате + их расположение)
    
    let personX = Int.random(in: 1...room.w)
    let personY = Int.random(in: 1...room.h)
    var person = Person(name: globalName, x: personX, y: personY)
    var (destinationX,destinationY) = (1,1)
    
    repeat {
        destinationX = Int.random(in: 1...room.w)
        destinationY = Int.random(in: 1...room.h)
    } while (personX,personY) == (destinationX,destinationY)
    let destCell = DestinationCell(x: destinationX, y: destinationY)
    
    countOfBoxes = Int.random(in: 1...room.w)
    
    // MARK: - Создаем коробку(и)
    // MARK: - Условия:
    // отличие от точки старта персонажа
    // отличие от точки назначения
    // не повторять положения коробок, если их несколько
    // не ставить коробки в углы
    // x коробки может быть 1 или Count, если точка назначения на той же Х координате
    // y коробки может быть 1 или Count, если точка назначения на той же Y координате
    
    var boxX, boxY: Int
    
    for _ in 1...countOfBoxes {
        checkCorrectCoordsLoop: repeat {
            boxX = Int.random(in: 1...room.w)
            boxY = Int.random(in: 1...room.h)
            
            switch (x: boxX,y: boxY) {
                case let box where box == (personX,personY): continue checkCorrectCoordsLoop
                case let box where box == (destinationX,destinationY): continue checkCorrectCoordsLoop
                case let box where box == (1,1): continue checkCorrectCoordsLoop
                case let box where box == (room.w,1): continue checkCorrectCoordsLoop
                case let box where box == (room.w,room.h): continue checkCorrectCoordsLoop
                case let box where box == (1,room.h): continue checkCorrectCoordsLoop
                case let (x,_) where (x == 1 && destinationX != 1) || (x == room.w && destinationX != room.w): continue checkCorrectCoordsLoop
                case let (_,y) where (y == 1 && destinationY != 1) || (y == room.h && destinationY != room.h): continue checkCorrectCoordsLoop
                default: break
            }
            
            if (countOfBoxes > 1) {
                // если все проверки прошли, то смотрим, нет ли уже такого ящика в массиве
                for boxInArr in arrayOfBoxes {
                    if (boxInArr.x == boxX && boxInArr.y == boxY) { // если нашли похожую, то запускаем весь цикл заново
                        continue checkCorrectCoordsLoop
                    }
                }
            }
            break // если все проверки прошли, то выходим из цикла
        } while true
        arrayOfBoxes.append(Box(x: boxX, y: boxY))
    }

    print(" array of boxes: ")
    for (i,box) in arrayOfBoxes.enumerated() {
        print(" \(i+1)) \(box.x),\(box.y)")
    }

    // MARK: - Отрисовка комнаты
    print("\n Current room: ")
    room.showRoom(person: person, arrayOfBoxes: arrayOfBoxes, destinationCell: destCell)
    
    // MARK: - Сама игра
    gameLoop: while true { // вводить, пока не введем правильно
        print("\n Print direction for man (UP - W, DOWN - S, LEFT - A, RIGHT - D) or quit (Q) game: ", terminator: "")
        if let action = readLine() { // если что-то ввели
            switch action.lowercased() {
            case "w","ц":
                if person.moveTo(toDirection: .up, inRoom: room, withBoxes: &arrayOfBoxes, withDestCell: destCell) {
                    break gameLoop
                }
            case "s","ы":
                if person.moveTo(toDirection: .down, inRoom: room, withBoxes: &arrayOfBoxes, withDestCell: destCell) {
                    break gameLoop
                }
            case "a","ф":
                if person.moveTo(toDirection: .left, inRoom: room, withBoxes: &arrayOfBoxes, withDestCell: destCell) {
                    break gameLoop
                }
            case "d","в":
                if person.moveTo(toDirection: .right, inRoom: room, withBoxes: &arrayOfBoxes, withDestCell: destCell) {
                    break gameLoop
                }
            case "q","й": break gameLoop
            default: printError(errorType: .wrongCommand)
            }
            for box in arrayOfBoxes {
                if (box.x,box.y) == (1,1) || (box.x,box.y) == (room.w,1) || (box.x,box.y) == (1,room.h) || (box.x,box.y) == (room.w,room.h) {
                    print("the box is stuck! game over, \(person.name)!")
                    break gameLoop
                }
            }

        }
    }
    
    // MARK: - Сыграть еще раз?
    isGameOverLoop: while true {
        print("\nDo you wanna play one more time? (yes/no): ", terminator: "")
        if let gameAgain = readLine() {
            switch gameAgain.lowercased() {
            case "yes","да","y","д":
                globalName = ""
                room = Room(w: 0, h: 0)
                countOfBoxes  = 0
                arrayOfBoxes.removeAll()
                person = Person(name: globalName, x: 0, y: 0)
                
                break isGameOverLoop
            case "no","нет","n","н":
                isGameOver = true
                break isGameOverLoop
            default: printError(errorType: .wrongCommand)
            }
        }
    }
}
