import Foundation

class Mother : FamilyMember {
    static var countOfMothers : Int = 0
    
    var children : [Child]?
    
    override init(name: String) {
        super.init(name: name)
        Mother.countOfMothers += 1
    }
    
    deinit {
        Mother.countOfMothers -= 1
        print("Mother deinit: \(self.name) (\(Mother.countOfMothers) Mothers left)")
    }
}

