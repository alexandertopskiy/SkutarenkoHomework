import Foundation

// MARK: - ОП как альтернатива принудительному извлечению

class Person {
    var residence: Residence?
}

class Residence {
    var numberOfRooms = 1
}

let john = Person() // свойство Residence пока nil
//let roomCount = john.residence!.numberOfRooms - вызовет ошибку

let test = john.residence?.numberOfRooms // результат - опционал

func countRooms(john: Person) {
    if let roomCount = john.residence?.numberOfRooms {
        print("john has \(roomCount) rooms")
    } else {
        print("john has no house")
    }
}

countRooms(john: john) // john has no house
john.residence = Residence()
countRooms(john: john) // john has 1 rooms
