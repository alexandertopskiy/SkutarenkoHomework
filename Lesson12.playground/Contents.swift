import UIKit


// MARK: - Синтаксис перечислений
//Перечисления начинаются с ключевого слова enum, после которого идет имя перечисления и полное его определение в фигурных скобках:
enum SomeEnumeration {
    //здесь будет объявление перечисления
}

enum CompassPoint {
    case north
    case south
    case east
    case west
}

// MARK: - CaseIterable протокол для использования энума как коллекции

enum SomeEnum : CaseIterable { // подписываем под протокол, чтобы использовать все кейсы энума
    case one, two, three // кейсы можно писать через запятую
}
print("in SomeEnum there's \(SomeEnum.allCases.count) cases")

for someCase in SomeEnum.allCases {
    print("\(someCase)")
}

// MARK: - Ассоциативные значения
enum Barcode {
    case upc(Int, Int, Int, Int) // ассоциативные значения
    case qrCode(String)
}

var productBarcode = Barcode.upc(8, 85909, 51226, 3)
productBarcode = .qrCode("ABCDEFGHIJKLMNOP")

switch productBarcode {
case .upc(let numberSystem, let manufacturer, let product, let check):
    print("UPC: \(numberSystem), \(manufacturer), \(product), \(check).")
case .qrCode(let productCode):
    print("QR code: \(productCode).")
}

// MARK: - Исходные значения (rawValue)
enum ASCIIControlCharacter: Character {
    case tab = "\t" // исходные значения
    case lineFeed = "\n"
    case carriageReturn = "\r"
}

// MARK: - Неявно установленные исходные значения
// если исходные значения имеют тип Int или String, то можно указать их один раз, а остальные определятся автоматически
enum Planet: Int { // для Int это будут индексы, нижняя граница указывается первым элементом
    case mercury = 1, venus, earth, mars, jupiter, saturn, uranus, neptune
}

enum StringPlanet: String { // для String это будет строчное значение имени кейса
    case mercury, venus, earth, mars, jupiter, saturn, uranus, neptune
}

Planet.earth.rawValue // 3
StringPlanet.earth.rawValue // earth

// MARK: - Инициализация через исходное значение
let somePlanet = StringPlanet(rawValue: "?") // nil, потому что такого кейса нет
let earth = StringPlanet(rawValue: "earth") // тип StringPlanet?, т.к. может быть nil

// MARK: - Рекурсивные перечисления
// indirect - индиректность (можно указать перед каждым нужным кейсом или перед всем перечислением)
indirect enum ArithmeticExpression {
    case number(Int)
    case addition(ArithmeticExpression, ArithmeticExpression)
    case multiplication(ArithmeticExpression, ArithmeticExpression)
}

let five = ArithmeticExpression.number(5)
let four = ArithmeticExpression.number(4)
let sum = ArithmeticExpression.addition(five, four)
let product = ArithmeticExpression.multiplication(sum, ArithmeticExpression.number(2))

// Рекурсивные функции - самый простой путь работать с данными, которые имеют рекурсивную структуру
func evaluate(_ expression: ArithmeticExpression) -> Int {
    switch expression {
        case let .number(value):
            return value
        case let .addition(left, right):
            return evaluate(left) + evaluate(right)
        case let .multiplication(left, right):
            return evaluate(left) * evaluate(right)
    }
}

print("result: \(evaluate(product))")


// MARK: - Скутаренко
enum Action {
    case Walk(meters: Int) // в скобках - ассоциативное значение
    case Run(meters: Int, speed: Int)
    case Turn(direction: Direction)
    case Stop
    // этот энум можно объявить и снаружи, и внутри, код сам определит тип, если он указан неявно (через ".Тип")
    enum Direction : String {
        case Left = "Left!" // типу энума можно задать rawValue ("сырое" значение)
        case Right = "Right!"
        case Behind = "Behind!"
    }
}

var action = Action.Walk(meters: 10)
action = .Run(meters: 20, speed: 10) // можно уже не указывать тип Action, свифт автоматически определит это
action = .Turn(direction: .Behind)

let direction = Action.Direction(rawValue: "Left!") // опционал, потому что такого типа может не быть

switch action {
    case .Stop:
        print("stop")
    case .Turn(let dir) where dir == .Left:
        print("turn left")
    case .Turn(let dir) where dir == .Right:
        print("turn right")
    case .Turn(let dir) where dir == .Behind:
        print("turn \(dir.rawValue)")
    case .Walk(let meters) where meters < 100:
        print("short walk \(meters)m")
    case .Walk(let meters):
        print("long walk \(meters)m")
    case .Run(let meters, let speed):
        print("run \(meters)m with speed \(speed)km/h")
    default: break
}






// MARK: - Домашка

//1. Создать энум с шахматными фигруами (король, ферзь и т.д.). Каждая фигура должна иметь цвет белый либо черный (надеюсь намек понят), а так же букву и цифру для позиции. Создайте пару фигур с расположением на доске, так, чтобы черному королю был мат :) Поместите эти фигуры в массив фигур

print("\n TASK 1")

enum Color : String {
    case Black = "Black"
    case White = "White"
}

enum ChessFigure : String {
    case King = "King"// король
    case Queen = "Queen"// королева (ферзь)
    case Rook = "Rook"// ладья
    case Bishop = "Bishop"// слон
    case Knight = "Knight"// конь
    case Pawn = "Pawn"// пешка
}

var blackKing : (type: ChessFigure,color: Color,let: Character, num: Int) = (ChessFigure.King,Color.Black,"h",8)
var blackRook : (type: ChessFigure,color: Color,let: Character, num: Int) = (ChessFigure.Rook,Color.Black,"g",8)
var blackPawn : (type: ChessFigure,color: Color,let: Character, num: Int) = (ChessFigure.Pawn,Color.Black,"g",7)
var whiteKnight : (type: ChessFigure,color: Color,let: Character, num: Int) = (ChessFigure.Knight,Color.White,"f",7)

print("the white knight \(whiteKnight.let)\(whiteKnight.num) checkmated the black king \(blackKing.let)\(blackKing.num)")

//2. Сделайте так, чтобы энумовские значения имели rawValue типа String. Каждому типу фигуры установите соответствующее английское название. Создайте функцию, которая выводит в консоль (текстово, без юникода) название фигуры, цвет и расположение. Используя эту функцию распечатайте все фигуры в массиве.

print("\n TASK 2")

var figuresArrays = [blackKing,blackRook,blackPawn,whiteKnight]

func printFigure(figure: (type: ChessFigure, color: Color, let: Character, num: Int)) -> String {
    return "figure: \(figure.type.rawValue), color: \(figure.color.rawValue), place: \(figure.let)\(figure.num)"
}

for (index,figure) in figuresArrays.enumerated() {
    print("\(index): \(printFigure(figure: figure))")
}
 
//3. Используя красивые юникодовые представления шахматных фигур, выведите в консоли вашу доску. Если клетка не содержит фигуры, то используйте белую или черную клетку. Это должна быть отдельная функция, которая распечатывает доску с фигурами (принимает массив фигур и ничего не возвращает)

print("\n TASK 3")

let lettersArray : [Character] = ["a","b","c","d","e","f","g","h"]
let numbersArray : [Int] = [1,2,3,4,5,6,7,8]

func printChessboard(array: [(type: ChessFigure, color: Color, let: Character, num: Int)]) {
    var chessString : String = ""
    for (indexOfNum,number) in numbersArray.sorted().reversed().enumerated() {
        chessString += String(number) + ": "
        lettersLoop: for (indexOfLet,letter) in lettersArray.sorted().enumerated() { //выбрали клетку
            for figure in array { // ещем, есть ли в ней фигура из массива фигур
                if (figure.let == letter) && (figure.num == number) { //нашли фигуру в этой клетке
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

//4. Создайте функцию, которая будет принимать шахматную фигуру и тюпл новой позиции. Эта функция должна передвигать фигуру на новую позицию, причем перемещение должно быть легальным: нельзя передвинуть фигуру за пределы поля и нельзя двигать фигуры так, как нельзя их двигать в реальных шахматах (для мегамонстров программирования). Вызовите эту функцию для нескольких фигур и распечатайте поле снова.

// MARK: - Правила шахмат
// Если на клетке, куда мы ходим, стоит фигура, то мы ее рубим

// Слон может ходить на любое поле по диагонали, на которых он стоит.

// Ладья может ходить на любое поле по вертикали или горизонтали, на которых она стоит.

// Ферзь ходит на любое поле по вертикали, горизонтали или диагонали, на которых он стоит.

// Нельзя сделать ход сквозь фигуру! (ферзь, ладья или слон)

// Конь может ходить на одно из ближайших полей от того, на котором он стоит, но не на той же самой вертикали, горизонтали или диагонали.

//Король может перемещаться двумя различными путями: ходить на любое примыкающее поле, которое не атаковано одной или более фигурами партнера.

//Считается, что король находится «под шахом», если он атакован хотя бы одной фигурой партнера, даже если она не может сделать ход из-за того, что её собственный король остается под шахом или под него попадает. Ни одна из фигур не может сделать ход, который ставит или оставляет своего короля под шахом.

//Когда пешка достигает самой дальней горизонтали от своей исходной позиции, она должна быть заменена на ферзя, ладью, слона или коня «своего» цвета, что является частью того же хода.

print("\n TASK 4")

func moveFigure(figure: inout (type: ChessFigure, color: Color, let: Character, num: Int), moveTo: (x: Character, y: Int)) {
    // сначала проверяем на легальность (не выходит ли новая клетка за пределы доски)
    if lettersArray.contains(moveTo.x) && numbersArray.contains(moveTo.y) {
        let fromTo = (from: (x: figure.let,y: figure.num), to: moveTo) // откуда куда делаем ход
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
                    if (figuresArrays.contains { (type: ChessFigure, color: Color, let: Character, num: Int) in
                        (color != figure.color) && (`let` == to.x) && (num == to.y)
                    }) {
                        print("Congratulations! Your pawn ate something in cell \(to.x)\(to.y)!")
                        // реализация удаления съеденной фигуры
                        figure.let = to.x
                        figure.num = to.y
                    } else if (figuresArrays.contains { (type: ChessFigure, color: Color, let: Character, num: Int) in
                        (color == figure.color) && (`let` == to.x) && (num == to.y)
                    }) {
                        print("this move is illegal! you can't beat your own figure in cell \(to.x)\(to.y)!")
                    } else {
                        print("this move is illegal! A pawn can only move vertically!")
                    }
                default: print("your pawn moved from \(fromTo.from) to \(fromTo.to)")
                }
            default: print("moves for this figure have not yet been written. sorry :( ")
        }
    } else {
        print("this move is illegal! board has no cell \"\(moveTo.x)\(moveTo.y)\"")
    }

}
blackKing   = (ChessFigure.King,Color.Black,"h",8)
blackRook   = (ChessFigure.Rook,Color.Black,"g",8)
blackPawn   = (ChessFigure.Pawn,Color.Black,"e",8)
whiteKnight = (ChessFigure.Knight,Color.White,"f",7)

figuresArrays = [blackKing,blackRook,blackPawn,whiteKnight] // обновляем массив, т.к. в него были записаны старые фигуры
printChessboard(array: figuresArrays)
moveFigure(figure: &blackPawn, moveTo: ("f",7))
figuresArrays = [blackKing,blackRook,blackPawn,whiteKnight] // обновляем массив, т.к. в него были записаны старые фигуры
printChessboard(array: figuresArrays)

//5. Следите чтобы ваш код был красивым!
