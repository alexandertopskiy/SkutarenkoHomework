import Foundation

// MARK: - Цикл сильных ссылок

class Person {
    let name : String
    init(name: String) { self.name = name }
    var apartment : Apartment?
    deinit { print("\(name) deinitialization...") }
}

class Apartment {
    let unit: String
    init(unit: String) { self.unit = unit }
    var tenant : Person?
    deinit { print("\(unit) deinitialization...") }
}

var john : Person?
var penthouse : Apartment?

john = Person(name: "John")
penthouse = Apartment(unit: "4A")

john!.apartment = penthouse // теперь имеет сильную ссылку на penthouse
penthouse!.tenant = john // теперь имеет сильную ссылку на john

// не освобождает объекты, потомы что свойство apartment у john все еще ссылается на penthouse
john = nil
penthouse = nil

// поможет только john!.apartment = nil перед обнулением самого john

