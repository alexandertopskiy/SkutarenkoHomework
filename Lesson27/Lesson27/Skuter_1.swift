import Foundation

// MARK: - Скутаренко Часть 1

protocol Priority {
    var order: Int { get }
}

// протоколы могут наследоваться от других протоколов
protocol ShowName : Priority {
    var name : String { get } // требование протокола - реализовать геттер для свойства name
}

class Student : ShowName {
    var firstName : String
    var lastName : String
    var fullName : String {
      return firstName + " " + lastName
    }
    init(firstName: String, lastName : String) {
        self.firstName = firstName
        self.lastName = lastName
    }
    // исполненеие требования протокола
    var name: String {
        return fullName
    }
    let order: Int = 1
}

class Animal {
    
}

// если класс наследуется и подписывается под протоколы, то сначала пишется суперкласс
class Cow : Animal, ShowName {
    var nickname: String?
    var name: String {
        return nickname ?? "a cow"
    }
    let order: Int = 2
}

struct Grass : ShowName {
    var type: String
    var name: String {
        return type
    }
    let order: Int = 3
}

let student1 = Student(firstName: "Alex", lastName: "Topskiy")
let student2 = Student(firstName: "Tolya", lastName: "Medvedev")
let student3 = Student(firstName: "Anton", lastName: "Kozmod")

let cow1 = Cow()
cow1.nickname = "Mumu"
let cow2 = Cow()

let grass1 = Grass(type: "Type1")
let grass2 = Grass(type: "Type2")

var array : [Any] = [student1, student2, student3, cow1, cow2, grass1, grass2]

for item in array {
    switch item {
    case let grass as Grass: print(grass.type)
    case let student as Student: print(student.fullName)
    case let cow as Cow: print(cow.nickname ?? "a cow")
    default: break
    }
}

// теперь можно объеденить элеметны массива по признаку принадлежности к протоколу

print("\n\n\n")

var array2 : [ShowName] = [student2, grass1, cow1, student3, cow2, student1, grass2]

func printFarm(array: inout [ShowName]) {
    array.sort { a, b in
        if (a.order == b.order) {
            return a.name.lowercased() < b.name.lowercased()
        } else {
            return a.order < b.order
        }
    }

    for item in array {
        print(item.name)
    }
}

printFarm(array: &array2)
