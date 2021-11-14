import UIKit

// MARK: - 17 - Сабскрипты (Индексы)

// MARK: - Скутаренко

let array = ["a","b","c","d","e"]
array[0] // сабскрипт (обращение к элементу по индексу)
array[1]
array[2]

struct Family {
    var father = "Father"
    var mother = "Mother"
    var kids = ["Kid-1","Kid-2","Kid-3"]
    
    var count : Int {
        return 2 + kids.count
    }
    
    subscript(index: Int) -> String? {
        get {
            switch index {
            case 0: return father
            case 1: return mother
            case 2..<(2 + kids.count): return kids[index - 2]
            default: return nil
            }
        }
        set {
            let value = newValue ?? ""
            switch index {
            case 0: father = value
            case 1: mother = value
            case 2..<(2 + kids.count): kids[index - 2] = value
            default: break
            }
        }
    }
    
    // MARK: - Можно сделать перегрузку (overloading) сабскрипта, то есть описать несколько вариантов с разными входными/выходными параметрами
    subscript(index: Int, suffix: String) -> String? {
        var name = self[index] ?? ""
        name += " " + suffix
        return name
    }
    
}

var family = Family()
family.count
family[0]
family[2]
family[5]

family[0] = "Dad"
family.father
family[0]

family[2] = "Bob"
family[2]
family.kids[0]

family[2, "& Bib"]


struct ChessField {
    
    var dict = [String:String]()
    
    func keyFor(column: String, row: Int) -> String {
        return column + String(row)
    }
    
    subscript(column: String, row: Int) -> String? {
        get {
            return dict[keyFor(column: column, row: row)]
        }
        set {
            dict[keyFor(column: column, row: row)] = newValue
        }
    }
}

var field = ChessField()
field["a",5]
field["a",5] = "King"
field["a",5]

// MARK: - Apple

struct  TimesTable{
    let multiplier: Int
    subscript(index: Int) -> Int {
        return multiplier * index
    }
}

let what = 3
let byWhat = 5

let threeTimesTable = TimesTable(multiplier: what)
//print("\(what) умножить на \(byWhat) будет \(threeTimesTable[byWhat])")

var numberOfLegs = ["паук": 8, "муравей": 6, "кошка": 4]
numberOfLegs["птичка"] = 2 // set-метод сабскрипта


// Множественные сабсткрипты (перегрузка)

struct Matrix {
    let rows: Int, columns: Int
    var grid: [Double]

    init(rows: Int, columns: Int) {
      self.rows = rows
      self.columns = columns
      grid = Array(repeating: 0.0, count: rows * columns)
    }

    func indexIsValid(row: Int, column: Int) -> Bool {
      return row >= 0 && row < rows && column >= 0 && column < columns
    }
    
    func printMatrix() -> Void {
        var index = 0
        var str = ""
        for _ in 0..<rows {
            for _ in 0..<columns {
                str += String(grid[index]) + " "
                index += 1
            }
            print(str)
            str = ""
        }
    }

    subscript(row: Int, column: Int) -> Double {
      get {
          assert(indexIsValid(row: row, column: column), "Index out of range")
          return grid[(row * columns) + column]
      }
      set {
          assert(indexIsValid(row: row, column: column), "Index out of range")
          grid[(row * columns) + column] = newValue
      }
    }
}

var matrix = Matrix(rows: 5, columns: 5)
//matrix.printMatrix()
print()
matrix[0,0] = 5.0
matrix[2,2] = 1.0
//matrix.printMatrix()

// MARK: - Домашка

// MARK: - Шахматная доска (Легкий уровень)
//1. Создайте тип шахматная доска.
//2. Добавьте сабскрипт, который выдает цвет клетки по координате клетки (буква и цифра).
//3. Если юзер ошибся координатами - выдавайте нил

print("\n TASK 1: Chess")

let lettersDict : [String : Int] = ["a": 1, "b": 2, "c": 3, "d": 4, "e": 5, "f": 6, "g": 7, "h": 8]

struct ChessBoard {
    
    var columns : Int
    var rows : Int
    
    func indexIsValid(row: Int, column: Int) -> Bool {
      return (row > 0 && row <= rows) && (column > 0 && column <= columns)
    }
    
    subscript(columnLetter: String, rowIndex: Int) -> String? {
        let columnIndex = lettersDict[columnLetter.lowercased()] ?? -1
        if indexIsValid(row: rowIndex, column: columnIndex) {
            let color = ((rowIndex % 2) == (columnIndex % 2)) ? "Black" : "White"
            return color
        } else {
            return nil
        }
    }
    
}

let board = ChessBoard(columns: 8, rows: 8)
board["d",3]
board["a",9]
board["r",2]

// MARK: - Крестики нолики (Средний уровень)
//1. Создать тип, представляющий собой поле для игры в крестики нолики
//На каждой клетке может быть только одно из значений: Пусто, Крестик, Нолик
//Добавьте возможность красиво распечатывать поле
//2. Добавьте сабскрипт, который устанавливает значение клетки по ряду и столбцу,
//причем вы должны следить за тем, чтобы программа не падала если будет введен не существующий ряд или столбец.
//3. Также следите за тем, чтобы нельзя было устанавливать крестик либо нолик туда, где уже что-то есть.
// Добавьте метод очистки поля.
//4. Если хотите, добавте алгоритм, который вычислит победителя

print("\n TASK 2: XOs")

enum TypeOfCell : String {
    case cross = "❌"
    case zero = "🅾️"
    case empty = "◻️"
}

struct XO {
    var columns : Int
    var rows : Int
    var cells : [TypeOfCell]
    
    init(columns: Int, rows: Int) {
        self.columns = columns
        self.rows = rows
        cells = [TypeOfCell](repeating: .empty, count: columns * rows)
    }
    
    subscript(column: Int, row: Int) -> TypeOfCell? {
        get {
            assert(indexIsValid(row: row, column: column), "Index out of range")
            return cells[((row - 1) * columns) + column - 1]
        }
        set {
            assert(indexIsValid(row: row, column: column), "Index out of range")
            let cell = cells[((row - 1) * columns) + column - 1]
            switch cell { // что сейчас в клетке
            case .cross, .zero:
                print("Ошибка! В клетке уже что-то есть!")
            case .empty:
                cells[((row - 1) * columns) + column - 1] = newValue ?? .empty
            }
            
        }
    }
        
    func printBoard() -> Void {
        var index = 0
        var str = ""
        for _ in 0..<rows {
            for _ in 0..<columns {
                str += cells[index].rawValue + " "
                index += 1
            }
            print(str)
            str = ""
        }
    }
        
    func indexIsValid(row: Int, column: Int) -> Bool {
        return (row > 0 && row <= rows) && (column > 0 && column <= columns)
    }
    
    func checkWinner() -> TypeOfCell? {
        
        var testArray: [TypeOfCell] = []
        var uniqueElements: Set<TypeOfCell>
                             
        // проверяем каждую строчку
        for i in 0..<rows {
            let rowArray = cells[i*rows..<i*rows+rows]
            uniqueElements = Set(rowArray)
            if (uniqueElements.count == 1 && uniqueElements.first != .empty) {
                return uniqueElements.first!
            }
        }
        
        // проверяем каждый столбец
        for i in 0..<columns {
            testArray.removeAll()
            for index in 0..<columns {
                testArray.append(cells[i + index*columns])
            }
            uniqueElements = Set(testArray)
            if (uniqueElements.count == 1 && uniqueElements.first != .empty) {
                return uniqueElements.first!
            }
        }
        
        // главная диагональ ([1,1], [2,2], [3,3])
        testArray.removeAll()
        for i in 1...rows {
            for j in 1...rows {
                if (i == j) {
                    testArray.append(self[i,j]!)
                }
            }
        }
        uniqueElements = Set(testArray)
        if (uniqueElements.count == 1 && uniqueElements.first != .empty) {
            return uniqueElements.first!
        }
        
        // дополнительная диагональ ([3,1], [2,2], [1,3])
        testArray.removeAll()
        for i in 1...rows {
            for j in 1...rows {
                if (i + j == rows + 1) {
                    testArray.append(self[i,j]!)
                }
            }
        }
        uniqueElements = Set(testArray)
        if (uniqueElements.count == 1 && uniqueElements.first != .empty) {
            return uniqueElements.first!
        }
        
        return nil
    }
    
}

var xoS = XO(columns: 3, rows: 3)
xoS.printBoard()
xoS[1,1] = .cross
xoS[2,2] = .cross
xoS[3,3] = .cross

print()
xoS.printBoard()
if let winner = xoS.checkWinner() {
    print("\n\(winner.rawValue) won!")
}


// MARK: - Морской бой (Тяжелый уровень)
//1. Создайте тип корабль, который будет представлять собой прямоугольник. В нем может быть внутренняя одномерная система координат (попахивает сабскриптом). Корабль должен принимать выстрелы по локальным координатам и вычислять когда он убит

//2. Создайте двумерное поле, на котором будут располагаться корабли врага. Стреляйте по полю и подбейте вражеский четырех трубник :)

//3. Сделайте для приличия пару выстрелов мимо, красивенько все выводите на экран :)

print("\n TASK 3: Sea Batle")

struct Point {
    let x: Int
    let y: Int
    var image: String?
}

class Ship {
    
    enum Directions {
        case vertical
        case horizontal
    }
    
    enum ShipTypes : Int {
        case P1 = 1
        case P2
        case P3
        case P4 // = 4
        var lenght : Int {
            return self.rawValue
        }
    }
    
    enum ImageOfShip : String {
        case normal = "🟢"
        case bitten = "🔥"
        case dead = "⛔️"
    }
        
    var direction : Directions
    var mainPoint : Point
    var cells : [ImageOfShip]
    var type: ShipTypes
    var shipStatus : ImageOfShip {
        let testSet = Set(self.cells)
        // если все одинаковые, то либо убит, либо живой
        // если разные, то точно подбит, но еще живой
        switch testSet.count {
        case 1 where testSet.first == .normal: return .normal
        case 1 where testSet.first == .bitten: return .dead
        case 1 where testSet.first == .dead: return .dead
        default: return .bitten
        }
    }
    
    init(mainPoint: Point, shipType: ShipTypes, direction: Directions) {
        self.direction = direction
        self.mainPoint = mainPoint
        self.type = shipType
        self.cells = Array(repeating: .normal, count: shipType.lenght)
    }
        
    // обращение к палубе корабля
    subscript(index: Int) -> ImageOfShip? {
        get {
            if (1...cells.count ~= index) { return cells[index - 1] }
            else { return nil }
        }
        set {
            if (cells[index - 1] == .normal) { // если было норм, то теперь он подбит
                cells[index - 1] = .bitten
            }
            if (shipStatus == .dead) { // если подбита последняя палуба, то корабль убит
                for i in 0..<cells.count {
                    cells[i] = .dead
                }
            }
        }
    }
    
    func printShip() -> Void {
        print(terminator: " ")
        for i in self.cells {
            print(i.rawValue, terminator: "")
        }
        print()
    }
    
}

class SeaBatle {
    struct SizeOfField {
        var w: Int // columns
        var h: Int // rows
        static var defaultSize : SizeOfField {
            return SizeOfField(w: 10, h: 10)
        }
    }
    
    var ships: [Ship]
    var size: SizeOfField
    var grid: [Point] = []
    var isDefaultSize : Bool {
        return (size.w,size.h) == (SizeOfField.defaultSize.w,SizeOfField.defaultSize.h)
    }
    var aliveShips : Int = 0
    
    init(size: SizeOfField = SizeOfField.defaultSize) {
        self.size = size
        self.ships = []
        for y in 1...size.h {
            for x in 1...size.w {
                self.grid.append(Point(x: x, y: y, image: "⬜️"))
            }
        }
    }
        
    func shot(x shotX: Int, y shotY: Int) -> Void {
        if (1...size.w ~= shotX) && (1...size.h ~= shotY) {
            
            guard let targetIndex = self.grid.firstIndex(where: { $0.x == shotX && $0.y == shotY }) else {
                print("there's no such cell")
                return
            }
            self.grid[targetIndex].image = "❌"
                        
            for ship in self.ships { // проверяем каждый корабль
                let shipPoint = ship.mainPoint
                for deckNumber in 0..<ship.type.lenght { // проверяем каждую палубу на попадание в нее
                    
                    if ((ship.direction == .horizontal) && (shipPoint.x + deckNumber == shotX && shipPoint.y == shotY)) ||
                       ((ship.direction == .vertical) && (shipPoint.x == shotX && shipPoint.y - deckNumber == shotY)) {
                        print("Есть пробитие!")
                        ship[deckNumber+1] = .bitten
                        self.grid[targetIndex].image = ship[deckNumber+1]!.rawValue
                        if ship[deckNumber+1]! == .dead {
                            self.aliveShips -= 1
                            print("Убит корабль! Осталось \(aliveShips) из \(ships.count)")
                        }
                    }

                }
            }
            
            printField()
            
        } else {
            print("ошибка, такой клетки нет на поле")
        }
    }
    
    func printField() {

        // сначала обновляем положение и статус кораблей
        for ship in self.ships {
            let point = ship.mainPoint
            for deckNumber in 0..<ship.type.lenght { // рисуем палубы
                if ship.direction == .horizontal {
                    if let targetIndex = self.grid.firstIndex(where: { $0.x == point.x + deckNumber && $0.y == point.y}) {
                        self.grid[targetIndex].image = ship[deckNumber+1]!.rawValue
                    }
                } else {
                    if let targetIndex = self.grid.firstIndex(where: { $0.x == point.x && $0.y == point.y - deckNumber}) {
                        self.grid[targetIndex].image = ship[deckNumber+1]!.rawValue
                    }
                }
            }
        }
        
        let indexArray = Array(arrayLiteral: "0️⃣","1️⃣","2️⃣","3️⃣","4️⃣","5️⃣","6️⃣","7️⃣","8️⃣","9️⃣","🔟")
        var str1: String = ""
        if self.isDefaultSize {
            str1 += indexArray[0]
            for i in 1...size.w {
                str1 += indexArray[i]
            }
            str1 += indexArray[0]
        }
        print(str1)
        
        var str2 = ""
        for y in (1...size.h).reversed() {
            if self.isDefaultSize { str2 += indexArray[y] }
            for x in 1...size.w {
                if let ind = grid.firstIndex(where: { ($0.x == x) && ($0.y == y) }) {
                    str2 += grid[ind].image!
                }
            }
            if self.isDefaultSize { str2 += indexArray[y] }
            print(str2)
            str2 = ""
        }
        
        print(str1 + "\n")
    }
    
    func isShipValid(pos: Point, dir: Ship.Directions, type: Ship.ShipTypes) -> Bool {

        // проверка на повторяющиеся корабли
        for ship in self.ships {
            let posOfExisting = ship.mainPoint
            if (posOfExisting.x == pos.x && posOfExisting.y == pos.y) {
                print("В этой клетке уже стоит корабль! Выберите другую клетку")
                return false
            }
        }
        
        switch (x: pos.x, y: pos.y, dir: dir, type: type) {
        
            // сначала проверить координаты (выходят ли они за границы)
            case let (x,y,_,_) where (x <= 0) || (y <= 0):
                print("Координаты должны быть положительными!")
                return false
            case let (x,y,_,_) where (x > size.w) || (y > size.h):
                print("Координаты не могут быть за пределами поля!")
                return false
                
            // проверить направление + тип
            case let (x,_,d,t) where (d == .horizontal):
                let emptyCells = size.w - x // сколько свободных клеток справа
                if (emptyCells < t.rawValue - 1) {
                    print("Корабль слишком большой, чтобы разместить его в этой клетке! Попробуйте корабль поменьше или измените его позицию")
                    return false
                } else {
                    return true
                }
            case let (_,y,d,t) where (d == .vertical):
                
                let humanY = size.h - y + 1
                // 1 = 10
                // 2 = 9
                // ...
                // 10 = 1
                // X = x - 10 + 1
                let emptyCells = size.h - humanY // сколько свободных клеток снизу
                
                if (emptyCells < t.rawValue - 1) {
                    print("Корабль слишком большой, чтобы разместить его в этой клетке! Попробуйте корабль поменьше или измените его позицию")
                    return false
                } else {
                    return true
                }
                
            default: break
        }
        return true
    }
    
    func addShip(ship: Ship) {
        if isShipValid(pos: ship.mainPoint, dir: ship.direction, type: ship.type) {
            self.ships.append(ship)
            self.aliveShips += 1
            printField()
        }
    }
    
}

var seaField = SeaBatle()
seaField.grid

seaField.addShip(ship: Ship(mainPoint: Point(x: 1, y: 1), shipType: .P2, direction: .horizontal))
seaField.addShip(ship: Ship(mainPoint: Point(x: 3, y: 8), shipType: .P4, direction: .vertical))
seaField.addShip(ship: Ship(mainPoint: Point(x: 8, y: 6), shipType: .P2, direction: .horizontal))

seaField.shot(x: 1, y: 1)
seaField.shot(x: 2, y: 1)
seaField.shot(x: 1, y: 2)
seaField.shot(x: 4, y: 4)
seaField.shot(x: 10, y: 10)
seaField.shot(x: 7, y: 6)
seaField.shot(x: 8, y: 6)
seaField.shot(x: 9, y: 6)

seaField.ships.count
