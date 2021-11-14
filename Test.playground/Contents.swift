import UIKit

class Human {
    
    class var ageMin : Int { return 0 }
    class var ageMax : Int { return  128 }
    
    var age: Int
    var name: String
    
    init?(name: String, age: Int) {
        self.name = name
        self.age = age
        if (age < type(of: self).ageMin || age > type(of: self).ageMax) {
            print("Возраст \(name) указан неверно")
            return nil
        }
    }
}

class Parent: Human {
    class override var ageMin : Int { return 18 }
    class override var ageMax : Int { return 128 }
}

class Child: Human {
    class override var ageMin : Int { return 0 }
    class override var ageMax : Int { return 18 }
}

let alex = Human(name: "Alex", age: 10)
let bob = Human(name: "Bob", age: 129)
let dad = Parent(name: "Sam", age: 17)
let son = Child(name: "Tom", age: 19)



