import Foundation

class Family {
    
    static var countOfFamily : Int = 0
    var father : Father
    var mother : Mother
    var children : [Child]
    
    init(father: Father, mother: Mother, children: [Child]) {
        self.father = father // установка значений для отца/матери/детей семьи
        self.mother = mother
        self.children = children
        father.family = self // семья отца - данный экземпляр
        father.wife = mother // жена отца - входной параметр mother
        mother.children = children // дети матери - входной параметр-массив children
        children.forEach { // указываем связи (родителей) для всех детей в массиве
            $0.father = father
            $0.mother = mother
        }
        Family.countOfFamily += 1
    }
    
    func getFamily() -> [FamilyMember] {
        return [father,mother] + children
    }
    
    deinit {
        Family.countOfFamily -= 1
        print("Family deinit (\(Family.countOfFamily) Familys left)")
    }
}
