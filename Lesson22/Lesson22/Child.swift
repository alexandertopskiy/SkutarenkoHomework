import Foundation

//Дети могут
// вызывать друг друга и они могут искать пути, как общаться с другими Детьми, например говорить "дай игрушку",
// спрашивать Маму: "Мама, дай конфетку",
// общаться с Папой: "Папа, купи игрушку".

class Child : FamilyMember{
    static var countOfChilds : Int = 0
        
    unowned var father : Father  // ссылки бесхозные, т.к. родители точно есть, не могут быть nil
    unowned var mother : Mother
    
    init(name: String, father: Father, mother: Mother) {
        self.father = father
        self.mother = mother
        super.init(name: name)
        Child.countOfChilds += 1
    }
    
    func talkToChild(with child: Child, message: String) {
        print("\(self.name) says to bro/sis: \(child.name), \(message)!")
    }
    
    func giveCandy() {
        print("\(self.name) says to mother: \(mother.name), give me a candy!")
    }
    
    func buyAToy() {
        print("\(self.name) says to father: \(father.name), buy me a toy!")
    }
    
    deinit {
        Child.countOfChilds -= 1
        print("Child deinit: \(self.name) (\(Child.countOfChilds) Childs left)")
    }
}
