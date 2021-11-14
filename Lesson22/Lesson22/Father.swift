import Foundation

class Father : FamilyMember {
    static var countOfFathers : Int = 0
    
    weak var wife : Mother? // слабая ссылка: если удалили жену, то можно удалить и отца
    weak var family: Family? // слабая ссылка: если удалили семью, то можно удалить и отца
        
    lazy var printFamily : () -> Void = { [unowned self] in
        // так как это lazy свойство, оно может быть не инициализоровано в 1 фазе -> можно использовать self прямо в нем
        guard let family = self.family else {
            print("\(self.name), you don't have family")
            return
        }
        print("\(self.name)'s Family: \(family.getFamily().map( { $0.name } ))")
    }
    
    lazy var printMother = { [unowned self] in
        guard let wife = self.wife else {
            print("you don't have wife")
            return
        }
        print("\(self.name)'s Wife/Mother of Children: " + wife.name)
    }
    
    lazy var printChildren = { [unowned self] in
        guard let family = self.family, !family.children.isEmpty else {
            print("you don't have chilren")
            return
        }
        print("\(self.name)'s Children: \(family.children.map( { $0.name } ))" )
    }
    
    override init(name: String) {
        super.init(name: name)
        Father.countOfFathers += 1
    }
    
    deinit {
        Father.countOfFathers -= 1
        print("Father deinit: \(self.name) (\(Father.countOfFathers) Fathers left)")
    }
}
