import UIKit

// MARK: - Классы и структуры









// MARK: - Свойства, дефолтные значения, инициализатор (конструктор)
class StudentClass {
    var className = "10-В" //свойству можно задать значение сразу
    var name : String // или указать тип, а само значение будет устанавливаться в конструкторе (инициализаторе)
    var age : Int
    init() { // пустой констркутор (ничего не принимает, но устанавливает значения)
        name = "Alex"
        age = 10
    }
    init(name: String, age: Int) { // конструктор с параметрами
        self.name = name // имя входной переменной совпадает с именем свойства класса -> к последнему добавляют self
        self.age = age
    }
}

let studClass1 = StudentClass() // объявление экземпляра класса через дефолтный конструктор
studClass1.name
studClass1.age
studClass1.name = "Tom" // свойства можно менять, несмотря на то, что экземпляр объявлен константой
studClass1.age = 20
studClass1.name
studClass1.age
let studClass2 = StudentClass(name: "Bob", age: 17) // объявление экземпляра через конструктор с параметрами
studClass2.name
studClass2.age

// MARK: - Свойства структур
// у структуры необязательно писать консутрктор, он есть по умолчанию
struct StudentStruct {
    var name : String
    var age : Int
}

// у структур нельзя менять свойства, если экземпляр объявлен константой
let studStruct1 = StudentStruct(name: "Martin", age: 19)
//studStruct1.age = 20 - ошибка
var studStruct2 = StudentStruct(name: "Martin", age: 19)
studStruct2.age
studStruct2.age = 20
studStruct2.age


// MARK: - Value/Reference type
// все базовые типа (Int, String,...), все коллекции(Array, Dictionary,Set), а также Перечисления (Enum) - это value type, они все описаны структурами
// Классы же - это reference type
//
// объяснение разницы value/reference type на аналогии:
// если у вас лежат 5 яблок, кто-то пришел и взял одно, то теперь у вас 4 яблока - reference type
// при value type: кто-то пришел к вам, скопировал эти 5 яблок на 3д принтере, съел одно, и у него осталось 4, а у вас по прежнему 5, потому что с ними ничего не делали, их просто скопировали

// MARK: - Value type
var studStruct3 = studStruct2 // мы СКОПИРОВАЛИ в новую переменную значение studStruct2
studStruct3.age = 5 // меняем значения у нового экземпляра
studStruct3.name = "?"

studStruct3.age  // значения свойств у нового экземпляра обновились
studStruct3.name

studStruct2.age // а у старого - нет, потому что произошло копирование
studStruct2.name

// MARK: - Reference type
var studClass3 = studClass2 // мы поставили указатель на studClass2, теперь studClass3 будет ссылаться на этот объект, и все манипуляции с одним будут влиять на другой
studClass3.age = 5 // меняем значения у нового экземпляра
studClass3.name = "?"

studClass3.age  // значения свойств у нового экземпляра обновились
studClass3.name

studClass2.age // и у старого тоже!
studClass2.name

// в обратную сторону
studClass2.age = 77 // меняем значения у нового экземпляра
studClass2.name = "Юра"

studClass3.age  // значения свойств у нового экземпляра обновились
studClass3.name

studClass2.age // и у старого тоже!
studClass2.name

// MARK: - Value/Reference type в функциях

studStruct2.age
func incrAge(student: StudentStruct) {
    var student = student
    student.age += 1
    student.age
}

incrAge(student: studStruct2)
studStruct2.age

studClass2.age
func incrAge(student: StudentClass) {
    student.age += 1
    student.age
}
incrAge(student: studClass2)
studClass2.age

// для структур также можно написать функцию, которая будет менять свойство - inout
studStruct2.age
func incrAge(student: inout StudentStruct) {
    student.age += 1
    student.age
}

incrAge(student: &studStruct2)
studStruct2.age


// MARK: - Оператор Тождественности (=== или !==)
//Проверяет, ссылаются ли две переменные на один экземпляр
let exOne = StudentClass()
let exTwo = exOne
let exThree = StudentClass()
exOne === exTwo
exOne === exThree
exTwo !== exThree


// MARK: - Домашка

//1. Создайте структуру студент. Добавьте свойства: имя, фамилия, год рождения, средний бал. Создайте несколько экземпляров этой структуры и заполните их данными. Положите их всех в массив (журнал).

print("\n TASK 1")

struct Student {
    var name : String
    var surname : String
    var yearBorn : Int
    var averageScore : Double
}

let student1 = Student(name: "Alexander", surname: "Loshakov", yearBorn: 2000, averageScore: 4.0)
let student2 = Student(name: "Anatoliy", surname: "Medvedev", yearBorn: 1999, averageScore: 4.5)
let student3 = Student(name: "Anton", surname: "Kozmodemyanov", yearBorn: 1998, averageScore: 4.3)

var group4410 : [Student] = [student1, student2, student3]

//2. Напишите функцию, которая принимает массив студентов и выводит в консоль данные каждого. Перед выводом каждого студента добавляйте порядковый номер в “журнале”, начиная с 1.

print("\n TASK 2")

print(" group 4410:")

func printJournal(array: [Student]) {
    for (index,student) in array.enumerated() {
        print(" \(index + 1): \(student.name) \(student.surname) (\(student.yearBorn)), average score: \(student.averageScore)")
    }
}

printJournal(array: group4410)

//3. С помощью функции sorted отсортируйте массив по среднему баллу, по убыванию и распечатайте “журнал”.

print("\n TASK 3")
group4410 = group4410.sorted { $0.averageScore > $1.averageScore }
print(" group 4410 (by decreasing the average score):")
printJournal(array: group4410)

//4. Отсортируйте теперь массив по фамилии (по возрастанию), причем если фамилии одинаковые, а вы сделайте так чтобы такое произошло, то сравниваются по имени. Распечатайте “журнал”.

print("\n TASK 4")
let student4 = Student(name: "Ilya", surname: "Medvedev", yearBorn: 1999, averageScore: 4.3)
let student5 = Student(name: "Dmitry", surname: "Medvedev", yearBorn: 1999, averageScore: 4.3)
group4410.append(student4)
group4410.append(student5)

group4410 = group4410.sorted {
    ($0.surname == $1.surname) ? ($0.name < $1.name) : ($0.surname < $1.surname)
}
print(" group 4410 (by ascending last name):")
printJournal(array: group4410)

//5. Создайте переменную и присвойте ей ваш существующий массив. Измените в нем данные всех студентов. Изменится ли первый массив? Распечатайте оба массива.

print("\n TASK 5")
var copyOfGroup4410 = group4410
copyOfGroup4410[0].averageScore = 3.0
copyOfGroup4410[1].yearBorn = 2001
copyOfGroup4410[1].yearBorn = 2001
print("group4410:")
printJournal(array: group4410)
print("copyOfGroup4410:")
printJournal(array: copyOfGroup4410)

//6. Теперь проделайте все тоже самое, но не для структуры Студент, а для класса. Какой результат в 5м задании? Что изменилось и почему?

print("\n TASK 1 for Classes")

class StudentByClass {
    var name : String
    var surname : String
    var yearBorn : Int
    var averageScore : Double
    
    init(name: String, surname: String, yearBorn: Int,averageScore : Double) {
        self.name = name
        self.surname = surname
        self.yearBorn = yearBorn
        self.averageScore = averageScore
    }
}

let student1ByClsss = StudentByClass(name: "Alexander", surname: "Loshakov", yearBorn: 2000, averageScore: 4.0)
let student2ByClsss = StudentByClass(name: "Anatoliy", surname: "Medvedev", yearBorn: 1999, averageScore: 4.5)
let student3ByClsss = StudentByClass(name: "Anton", surname: "Kozmodemyanov", yearBorn: 1998, averageScore: 4.3)

var group4410ByClass : [StudentByClass] = [student1ByClsss, student2ByClsss, student3ByClsss]

print("\n TASK 2 for Classes")
print(" group 4410:")
func printJournal(array: [StudentByClass]) {
    for (index,student) in array.enumerated() {
        print(" \(index + 1): \(student.name) \(student.surname) (\(student.yearBorn)), average score: \(student.averageScore)")
    }
}
printJournal(array: group4410ByClass)

print("\n TASK 3 for Classes")
group4410ByClass = group4410ByClass.sorted { $0.averageScore > $1.averageScore }
print(" group 4410 (by decreasing the average score):")
printJournal(array: group4410ByClass)

print("\n TASK 4 for Classes")
let student4ByClsss = StudentByClass(name: "Ilya", surname: "Medvedev", yearBorn: 1999, averageScore: 4.3)
let student5ByClsss = StudentByClass(name: "Dmitry", surname: "Medvedev", yearBorn: 1999, averageScore: 4.3)
group4410ByClass.append(student4ByClsss)
group4410ByClass.append(student5ByClsss)

group4410ByClass = group4410ByClass.sorted {
    ($0.surname == $1.surname) ? ($0.name < $1.name) : ($0.surname < $1.surname)
}
print(" group 4410 (by ascending last name):")
printJournal(array: group4410ByClass)

print("\n TASK 5 for Classes")
var copyOfGroup4410ByClass = group4410ByClass
copyOfGroup4410ByClass[0].averageScore = 3.0
copyOfGroup4410ByClass[1].yearBorn = 2001
copyOfGroup4410ByClass[1].yearBorn = 2001
print("group4410:")
printJournal(array: group4410ByClass)
print("copyOfGroup4410:")
printJournal(array: copyOfGroup4410ByClass)


//007. Уровень супермен. Выполните задание шахмат из урока по энумам используя структуры либо классы

print("\n TASK 007. ChessGame")

class ChessFigure {
    var type : TypeOfChessFigure
    var color : Color
    var letterOfCell : Character
    var numberOfCell : Int
    
    init(type: TypeOfChessFigure, color: Color, letterOfCell : Character, numberOfCell : Int) {
        self.type = type
        self.color = color
        self.letterOfCell = letterOfCell
        self.numberOfCell = numberOfCell
    }
}

enum Color : String {
    case Black = "Black"
    case White = "White"
}

enum TypeOfChessFigure : String {
    case King = "King"// король
    case Queen = "Queen"// королева (ферзь)
    case Rook = "Rook"// ладья
    case Bishop = "Bishop"// слон
    case Knight = "Knight"// конь
    case Pawn = "Pawn"// пешка
}

let blackKing = ChessFigure(type: .King, color: .Black, letterOfCell: "h", numberOfCell: 8)
let blackRook = ChessFigure(type: .Rook, color: .Black, letterOfCell: "g", numberOfCell: 8)
let blackPawn = ChessFigure(type: .Pawn, color: .Black, letterOfCell: "g", numberOfCell: 7)
let whiteKnight = ChessFigure(type: .Knight, color: .White, letterOfCell: "f", numberOfCell: 7)

var figuresArrays = [blackKing,blackRook,blackPawn,whiteKnight]
 
let lettersArray : [Character] = ["a","b","c","d","e","f","g","h"]
let numbersArray : [Int] = [1,2,3,4,5,6,7,8]

func printChessboard(array: [ChessFigure]) {
    var chessString : String = ""
    for (indexOfNum,number) in numbersArray.sorted().reversed().enumerated() {
        chessString += String(number) + ": "
        lettersLoop: for (indexOfLet,letter) in lettersArray.sorted().enumerated() { //выбрали клетку
            for figure in array { // ещем, есть ли в ней фигура из массива фигур
                if (figure.letterOfCell == letter) && (figure.numberOfCell == number) { //нашли фигуру в этой клетке
                    switch (figure.type, figure.color) {
                        case (.Knight, .White): chessString += " ♘"; continue lettersLoop // белый конь
                        case (.King, .Black): chessString += " ♚"; continue lettersLoop// черный король
                        case (.Rook, .Black): chessString += " ♜"; continue lettersLoop// черная ладья
                        case (.Pawn, .Black): chessString += " ♟"; continue lettersLoop // черная пешка
                        default: break
                    }
                    print("нашли фигуру")
                }
            }
            chessString += ((indexOfNum % 2) == (indexOfLet % 2)) ? "◽️" : "▪️" //фигуры нет, добавляем пустую клетку
        }
        print(chessString) // ряд пройден, переходим к следующему
        chessString = ""
    }
}

printChessboard(array: figuresArrays)

func moveFigure(figure: ChessFigure, moveTo: (x: Character, y: Int)) {
    // сначала проверяем на легальность (не выходит ли новая клетка за пределы доски)
    if lettersArray.contains(moveTo.x) && numbersArray.contains(moveTo.y) {
        let fromTo = (from: (x: figure.letterOfCell,y: figure.numberOfCell), to: moveTo) // откуда куда делаем ход
        switch figure.type {
            case .Pawn: // пешка
                switch (fromTo.from,fromTo.to) {
                case let(from,to) where (figure.color == .White) && (from.y > to.y): // допустим, что белые всегда в нижней части
                    print("this move is illegal! A pawn can only move forward!")
                case let(from,to) where (figure.color == .Black) && (from.y < to.y): // допустим, что черные всегда в верхней части
                    print("this move is illegal! A pawn can only move forward!")
                case let(from,to) where (abs(to.y - from.y) > 2):
                    print("this move is illegal! A pawn can't make such big move!")
                case let(from,to) where (from.y >= 3) && (abs(to.y - from.y) > 1):
                    print("this move is illegal! A pawn can't make such big move!")
                case let(from,to) where from.x != to.x: // если идем по диагонали
                    var eatenFigure : ChessFigure?
                    for (index,otherFigure) in figuresArrays.enumerated() {
                        if ((otherFigure.color != figure.color) && (otherFigure.letterOfCell == to.x) && (otherFigure.numberOfCell == to.y)) {
                            eatenFigure = otherFigure
                            print("Congratulations! Your pawn ate \(eatenFigure!.color) \(eatenFigure!.type) in cell \(to.x)\(to.y)!")
                            figure.letterOfCell = to.x
                            figure.numberOfCell = to.y
                            figuresArrays.remove(at: index) // удаляем съеденную фигуру из массива
                            break
                        } else if ((otherFigure.color == figure.color) && (otherFigure.letterOfCell == to.x) && (otherFigure.numberOfCell == to.y)){
                            print("this move is illegal! you can't beat your own figure in cell \(to.x)\(to.y)!")
                            break
                        }
                    }
                    print("this move is illegal! A pawn can only move vertically!")
                default:
                    print("your pawn moved from \(fromTo.from) to \(fromTo.to)")
                    figure.letterOfCell = moveTo.x
                    figure.numberOfCell = moveTo.y
                }
            default: print("moves for this figure have not yet been written. sorry :( ")
        }
    } else {
        print("this move is illegal! board has no cell \"\(moveTo.x)\(moveTo.y)\"")
    }

}

//blackKing   = (ChessFigure.King,Color.Black,"h",8)
//blackRook   = (ChessFigure.Rook,Color.Black,"g",8)
//blackPawn   = (ChessFigure.Pawn,Color.Black,"e",8)
//whiteKnight = (ChessFigure.Knight,Color.White,"f",7)
whiteKnight.letterOfCell = "f"
whiteKnight.numberOfCell = 6
print("")
print("\(figuresArrays.count) figures")
printChessboard(array: figuresArrays)
moveFigure(figure: blackPawn, moveTo: ("f",6))
print("\(figuresArrays.count) figures")
printChessboard(array: figuresArrays)
