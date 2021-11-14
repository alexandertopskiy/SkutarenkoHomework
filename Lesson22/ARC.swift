import Foundation

// MARK: - ARC в действии

class Person {
    let name: String
    init(name: String) {
        self.name = name
        print(" \(name) initialization...")
    }
    deinit {
        print(" \(name) deinitialization...")
    }
}

var reference1 : Person?
var reference2 : Person?
var reference3 : Person?

reference1 = Person(name: "Tom") // у reference1 1 сильная ссылка
reference2 = reference1 // у reference1 2 сильных ссылки
reference3 = reference1 // у reference1 3 сильных ссылки

reference1 = nil // у reference1 2 сильных ссылки
reference2 = nil // у reference1 1 сильная ссылка
reference3 = nil // у reference1 0 сильных ссылок, только теперь память освобождается
