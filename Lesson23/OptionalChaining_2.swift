import Foundation

// MARK: - Определение классовых моделей для ОП

class Person {
    var residence: Residence?
    var name : String
    
    init(name: String) { self.name = name }
}

class Room {
    let name: String
    
    init(name: String) { self.name = name }
}

class Address {
    var buildingName : String?
    var buildingNumber : String?
    var street : String?
    
    func buildingIdentifier() -> String? {
        if let buildingNumber = buildingNumber, let street = street {
            return "\(street), \(buildingNumber)"
        } else if buildingName != nil {
            return buildingName
        }
        return nil
    }
}

class Residence {
    var rooms = [Room]()
    var numberOfRooms : Int { return rooms.count }
    var address : Address?
    
    subscript(index: Int) -> Room {
        get { return rooms[index] }
        set { rooms[index] = newValue }
    }
    func printCount() {
        print("Number of rooms: \(numberOfRooms)")
    }
}

// MARK: - Доступ к свойствам через ОП

let john = Person(name: "John")

func countRooms(person: Person) {
    if let roomCount = person.residence?.numberOfRooms {
        print("\(person.name) has \(roomCount) rooms")
    } else {
        print("\(person.name) has no house")
    }
}

countRooms(person: john) // john has no house

func createAddress() -> Address {
    print("func is called")
    let someAddress = Address()
    someAddress.buildingNumber = "61d"
    someAddress.street = "Chistopolskaya"
    return someAddress
}

john.residence?.address = createAddress() // функция даже не вызовется, потому что свойство residence все еще nil
countRooms(person: john) // john has no house

// MARK: - Вызов методов через ОП

if john.residence?.printCount() != nil {
  print("Есть возможность вывести общее количество комнат.")
} else {
  print("Нет возможности вывести общее количество комнат.")
}
// Нет возможности вывести общее количество комнат.

if (john.residence?.address = createAddress()) != nil {
  print("Была возможность установить адрес.")
} else {
  print("Не было возможности установить адрес.")
}
// Не было возможности установить адрес.



// MARK: - Доступ к сабскриптам через ОП

if let firstRoomName = john.residence?[0].name {
    print("Название первой комнаты: \(firstRoomName).")
} else {
    print("Не было возможности получить название первой комнаты.")
}
// Не было возможности получить название первой комнаты.

if (john.residence?[0] = Room(name: "Bathroom")) != nil {
    print("Была возможность установить название первой комнаты.")
} else {
    print("Не было возможности установить название первой комнаты.")
}
// Не было возможности установить название первой комнаты.


let johnHouse = Residence()
johnHouse.rooms.append(Room(name: "Bathroom"))
johnHouse.rooms.append(Room(name: "Kitchen"))
john.residence = johnHouse
if let firstRoomName = john.residence?[0].name {
    print("Название первой комнаты: \(firstRoomName).")
} else {
    print("Не было возможности получить название первой комнаты.")
}
// Название первой комнаты: Bathroom.



// MARK: - Получение доступа к сабскрипту (индексу) опционального типа

var testScores = ["Dave": [86, 82, 84], "Bev": [79, 94, 81]]
testScores["Dave"]?[0]  =  91 // элемент с таким ключом есть
testScores["Bev"]?[0]   += 1  // элемент с таким ключом есть
testScores["Brian"]?[0] =  72 // элемента с таким ключом нет
// массив "Dave" теперь имеет вид [91, 82, 84], массив "Bev" - [80, 94, 81]



// MARK: - Соединение нескольких уровней ОП

john.residence?.address = createAddress()
if let johnStreet = john.residence?.address?.street {
    print("john's street is \(johnStreet)")
} else {
    print("failure")
}
// john's street is Chistopolskaya



// MARK: - Связывание методов в ОП с опциональными возвращаемыми значениями


if let buildingIdentifier = john.residence?.address?.buildingIdentifier() {
    print("john's full address is \(buildingIdentifier)")
} else {
    print("can't get john's full address")
}
// john's full address is Chistopolskaya, 61d

if let _ = john.residence?.address?.buildingIdentifier()?.hasPrefix("Chistopolskaya") {
    print("john lives on Chistopolskaya street!")
} else {
    print("john doesn's lives on Chistopolskaya street!")
}
// john lives on Chistopolskaya street!
