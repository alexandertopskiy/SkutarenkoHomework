import Foundation

// MARK: - Слабые (weak) ссылки

class Person {
    let name : String
    init(name: String) { self.name = name }
    var apartment : Apartment?
    deinit { print("\(name) deinitialization...") }
}

class Apartment {
    let unit: String
    init(unit: String) { self.unit = unit }
    weak var tenant : Person?
    deinit { print("\(unit) deinitialization...") }
}

var john : Person?
var unit4A : Apartment?

john = Person(name: "John")
unit4A = Apartment(unit: "4A")

john!.apartment = unit4A // теперь имеет сильную ссылку на penthouse
unit4A!.tenant = john // ссылка на john слабая

john = nil // удаляем Person -> разрушаем сильную ссылку с Apartment -> Person уничтожается
unit4A = nil // удаляем Apartment -> разрушаем сильную ссылку (при инициализации) -> Apartment уничтожается

// однако если обнулить только unit4A, то из памяти ничего не освободится, т.к. john по прежнему будет иметь сильную ссылку на unit4A
