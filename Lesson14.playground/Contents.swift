import UIKit

// MARK: - 14 - Свойства (stored & computed)

//  stored properties лишь хранят значения (но им можно установить willSet/didSet методы)
//  computed properties сами по себе ничего не хранят, они выполняют роль функций через get/set-методы

struct Student {
    
    var firstName : String {
        willSet(newName) { // по умолчанию newValue
            print("will set to " + newName + " instead of " + firstName)
        }
        didSet(oldName) { // по умолчанию oldValue
            firstName = firstName.capitalized
            print("did set to " + firstName + " instead of " + oldName)
        }
    }
    var lastName : String {
        didSet {
            lastName = lastName.capitalized
            print("did set to " + lastName + " instead of " + oldValue)
        }
    }
    var fullName : String { // это computed property
        get {
            return firstName + " " + lastName
        }
        set { // по умолчанию newValue
            print("set \(newValue) instead of \(fullName)")
            let words = newValue.components(separatedBy: " ")
            if words.count > 0 {
                firstName = words[0]
            }
            if words.count > 1 {
                lastName = words[1]
            }
        }
    }
    var getHello : String { // вычисляемое свойство только для чтения (get можно опустить)
        return "Hello, \(fullName)"
    }
    
}

var student = Student(firstName: "Alex", lastName: "Topskiy") // при инициализации сеттеры не вызываются

student.firstName
student.lastName
student.fullName
student.fullName = "Tom"
student.firstName
student.lastName
student.fullName
student.getHello

// MARK: - Ленивые свойства (lazy properties)

class DataImporter {
    /*
    DataImporter - класс для импорта данных с внешних источников
    Считаем, что классу требуется большое количество времени для инициализации
    */
    var fileName = "data.txt"
    // класс DataImporter функционал данных будет описан тут
}

class DataManager {
    lazy var importer = DataImporter()
    var data = [String]()
    // класс DataManager функционал данных будет описан тут
}

let manager = DataManager()
manager.data.append("Some data")
manager.data.append("Also Some data")

// экземпляр класса DataImporter для lazy-свойства importer все еще не создан

print("file name: \(manager.importer.fileName)") // экземпляр класса создается только сейчас

// MARK: - Вычисляемые свойства

struct Point {
    var x = 0.0, y = 0.0
}
struct Size {
    var width = 0.0, height = 0.0
}
struct Rect {
    var origin = Point()
    var size = Size()
    var center : Point {
        get {
            let centerX = origin.x + (size.width / 2)
            let centerY = origin.y + (size.height / 2)
            return Point(x: centerX, y: centerY)
        }
        set(newCenter) {
            origin.x = newCenter.x - (size.width / 2)
            origin.y = newCenter.y - (size.height / 2)
        }
    }
}

var square = Rect(origin: Point(x: 0.0, y: 0.0), size: Size(width: 10.0, height: 10.0))
let initSquareCenter = square.center
print("initSquareCenter: \(square.center)")
print("initSquareOrigin: \(square.origin)")
square.center = Point(x: 3.0, y: 3.0)
print("newSquareCenter: \(square.center)")
print("newSquareOrigin: \(square.origin)")
// MARK: - Домашка

//1. Самостоятельно повторить проделанное в уроке
//2. Добавить студенту property «Дата рождения» (пусть это будет еще одна структура, содержащая день, месяц, год) и два computed property: первое — вычисляющее его возраст, второе — вычисляющее, сколько лет он учился (считать, что он учился в школе с 6 лет, если студенту меньше 6 лет — возвращать 0)

print("\n TASK 1 + 2")

struct DateBirth {
    let day : Int
    let month : Int
    let year : Int
}

struct SomeStudent {
    var firstName : String {
        didSet { // по умолчанию oldValue
            firstName = firstName.capitalized
        }
    }
    
    var lastName : String {
        didSet {
            lastName = lastName.capitalized
        }
    }
    
    var fullName : String { // это computed property
        get {
            return firstName + " " + lastName
        }
        set { // по умолчанию newValue
            print("set \(newValue) instead of \(fullName)")
            let words = newValue.components(separatedBy: " ")
            if words.count > 0 {
                firstName = words[0]
            }
            if words.count > 1 {
                lastName = words[1]
            }
        }
    }

    var dateOfBirth : DateBirth {
        didSet {
            let date = dateOfBirth
            let myDateFormatter = DateFormatter()
            myDateFormatter.dateFormat = "yyyy-MM-dd"
            let testDate = myDateFormatter.date(from: "\(date.year)-\(date.month)-\(date.day)")
            if testDate == nil {
                print("there's no that date! changing it to default: 01-01-2000...")
                dateOfBirth = DateBirth(day: 01, month: 01, year: 2000)
            }
        }
    }
    func diffDates(date1: Date?, date2: Date?) -> Int? {
        if let date1 = date1, let date2 = date2 {
            let difference = Calendar.current.dateComponents([.year], from: date1, to: date2).year
            return difference
        } else { return nil }
    }
    var studentAge : Int? {
        let myDateFormatter = DateFormatter()
        myDateFormatter.dateFormat = "yyyy-MM-dd"
        let firstDate = myDateFormatter.date(from: "\(dateOfBirth.year)-\(dateOfBirth.month)-\(dateOfBirth.day)")
        let secondDate = Date()
        return diffDates(date1: firstDate, date2: secondDate)
    }
    var ageOfStudied : Int? {
        if studentAge == nil { return nil }
        let myDateFormatter = DateFormatter()
        myDateFormatter.dateFormat = "yyyy-MM-dd"
        if (studentAge! < 6) { return 0 }
        let firstDate = myDateFormatter.date(from: "\(dateOfBirth.year+6)-09-01")
        let secondDate = Date()
        return diffDates(date1: firstDate, date2: secondDate)
    }
}



var someStudent = SomeStudent(firstName: "Alex", lastName: "Topskiy", dateOfBirth: DateBirth(day: 26, month: 01, year: 2000)) // при инициализации сеттеры не вызываются

//someStudent.dateOfBirth = DateBirth(day: 33, month: 01, year: 2000)
//someStudent.dateOfBirth

if let age = someStudent.studentAge {
    print(" you're \(age) year's old")
    let ageOfStudied = someStudent.ageOfStudied
    print(" you're studing for \(ageOfStudied!) years already!")
} else {
    print(" error! you set a wrong date birth")
}

//3. Создать структуру «Отрезок», содержащую две внутренние структуры «Точки». Структуру «Точка» создать самостоятельно, несмотря на уже имеющуюся в Swift’е. Таким образом, структура «Отрезок» содержит две структуры «Точки» — точки A и B (stored properties). Добавить два computed properties: « середина отрезка» и «длина» (считать математическими функциями)

print("\n TASK 3")

struct APoint {
    var x : Double
    var y : Double
}

struct Line {
    var pointA : APoint
    var pointB : APoint
    
    var middleOfLine : APoint {
        get {
            return APoint(x: (pointA.x+pointB.x)/2, y: (pointA.y+pointB.y)/2)
        }
        set {
            print(" set \(newValue) instead of \(middleOfLine)")
            let oldMiddleOfLine = middleOfLine
            print(" pointA was \(pointA) and pointB was \(pointB)")
            pointA.x = pointA.x + (newValue.x-oldMiddleOfLine.x)
            pointA.y = pointA.y + (newValue.y-oldMiddleOfLine.y)
            pointB.x = pointB.x + (newValue.x-oldMiddleOfLine.x)
            pointB.y = pointB.y + (newValue.y-oldMiddleOfLine.y)
            print(" now your pointA is \(pointA) and pointB is \(pointB)")
        }
    }
    
    var lenght : Double {
        get {
            return sqrt(pow((pointA.x-pointB.x), 2) + pow((pointA.y-pointB.y), 2))
        }
        set {
            /*
             из подобия треугольников
             newValue / oldLenght = (pointB.x - pointA.x) / (point?.x - pointA.x)
             newValue / oldLenght = (pointB.y - pointA.y) / (point?.y - pointA.y)
             */
            print(" set \(newValue) instead of \(lenght)")
            let oldLenght = lenght
            print(" pointB was \(pointB)")
            pointB.x = pointA.x + (newValue * (pointB.x - pointA.x)) / oldLenght
            pointB.y = pointA.y + (newValue * (pointB.y - pointA.y)) / oldLenght
            print(" now pointB is \(pointB)")
        }
    }
    
}

var line = Line(pointA: APoint(x: 0.0, y: 0.0), pointB: APoint(x: 3.0, y: 4.0))
print(" middle point of your line: (\(line.middleOfLine.x),\(line.middleOfLine.y))")
print(" the lenght of your line: \(line.lenght)")

//4. При изменении середины отрезка должно меняться положение точек A и B. При изменении длины, меняется положение точки B

print("\n TASK 4")

line.middleOfLine = APoint(x: 5, y: 5)
print()
line.lenght = 10.0

