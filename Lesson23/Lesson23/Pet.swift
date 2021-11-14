import Foundation

class Pet {
    static var countOfPets = 0
    var name: String
    init(name: String) {
        self.name = name
        Pet.countOfPets += 1
    }
    func makeASound() { }
    deinit {
        Pet.countOfPets -= 1
        print("\(name) deinit, \(Pet.countOfPets) pets left")
    }
}
class Sparrow: Pet {
    override func makeASound() { print("\(name) says: Kar-kar") }
}
class Cat: Pet {
    override func makeASound() { print("\(name) says: Meow") }
}
class Dog: Pet {
    override func makeASound() { print("\(name) says: Gav") }
}
class Rat: Pet {
    override func makeASound() { print("\(name) says: Psss") }
}

