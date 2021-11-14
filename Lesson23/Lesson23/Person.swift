import Foundation

// оболочка для хранения братьев/сестер в массиве слабых ссылок (по дефолту массив нельзя сделать weak/unowned, потому что массив - value type)
class Weak<T: AnyObject> {
  weak var value : T?
  init (_ value: T) {
    self.value = value
  }
}

class Person {
    static var countOfPersons = 0
    var name : String
    var father : Person?
    var mother : Person?
    var sisters : [Weak<Person>]?
    var brothers : [Weak<Person>]?
    var pets: [Pet]?
    
    init(name: String = "Some Name") {
        self.name = name
        Person.countOfPersons += 1
    }
        
    func setFamily(father: Person, mother: Person, sisters: [Person]?, brothers: [Person]?) {
        self.father = father
        self.mother = mother
        self.brothers = []
        self.sisters = []
        if let sisters = sisters {
            for sister in sisters {
                self.sisters?.append(Weak(sister))
            }
            self.sisters?.forEach({
                $0.value?.mother = mother
                $0.value?.father = father
            })
        }
        if let brothers = brothers {
            for (index,brother) in brothers.enumerated() {
//                brother.brothers?.append(Weak(self)) // делаем самого себя братом (или сестрой - потом добавить)
                // 1 чел и 3 брата: первому брату сделать братьями самого чела и 2 других
                //                  второму брату сделать братьями самого чела и 2 других
                //                  третьему брату сделать братьями самого чела и 2 других
//                for i in index...brothers.count {
//
//                }
//                brothers[index...]
                self.brothers?.append(Weak(brother))
            }
            self.brothers?.forEach({
                $0.value?.mother = mother
                $0.value?.father = father
            })
        }
    }
    
    func printFamilyTree(for family: [Person]) {
        print("\(self.name) has \(self.sisters?.count ?? 0) sibling sisters and \(self.brothers?.count ?? 0) sibling brothers")
        
        if let grandDad_1 = self.father?.father, let grandDad_2 = self.mother?.father,
           let grandMam_1 = self.father?.mother, let grandMam_2 = self.mother?.mother {
            
            var (uncleCount, auntCount) = (0,0)
            var (cousinBrother, cousinSister) = (0,0)
            // проверить массив, и взять всех, чьи отцы/матери совпадают с отцом/материю родителей (это дяди тети)
            for member in family {
                if (member.father === grandDad_1) || (member.father === grandDad_2) ||
                   (member.mother === grandMam_1) || (member.mother === grandMam_2) {
                    if (member !== self.mother && member !== self.father) { // member - тетя/дядя
//                        print("\(member.name) is uncle/aunt")
                        if member is Man { uncleCount += 1 }
                        else { auntCount += 1 }
                        
                        for cousin in family {
                            if (cousin.father === member) || (cousin.mother === member) {
//                                print("\(cousin.name) is cousin")
                                if cousin is Man { cousinBrother += 1 }
                                else { cousinSister += 1 }
                            }
                        }
                    }
                }
            }
            print("\(self.name) has \(uncleCount) uncles and \(auntCount) aunts")
            print("\(self.name) has \(cousinBrother) cousin brothers and \(cousinSister) cousin sisters")
        } else {
            print("can't get info about uncle/aunt and their kids, because there's no info about grandparents")
        }
        
    }
    
    deinit {
        Person.countOfPersons -= 1
        print("\(name) deinit, \(Person.countOfPersons) persons left")
    }
}

class Man : Person {
    func moveSofa() { print("\(name) двигает диван") }
}
class Woman : Person {
    func makeACall() { print("\(name) сказала двигать диван") }
}
