import Foundation

class FamilyMember {
    static var countOfFamilyMember : Int = 0
    var name : String
    
    init(name: String) {
        FamilyMember.countOfFamilyMember += 1
        self.name = name
    }
    
    deinit {
        FamilyMember.countOfFamilyMember -= 1
        print("FamilyMember deinit: (\(FamilyMember.countOfFamilyMember) Family Members left)")
    }
}

