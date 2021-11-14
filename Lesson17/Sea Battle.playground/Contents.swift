import UIKit

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
