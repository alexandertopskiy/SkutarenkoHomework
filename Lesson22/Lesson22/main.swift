import Foundation

// MARK: - Домашка

//Рассмотрим такую ситуацию: есть семья - папа, мама и дети.
//Папа глава семьи, у него есть Мама, Мама контролирует детей, т.е. иерархия: Папа - Мама - Дети, Дети на одном уровне.
//
//Дети могут
// вызывать друг друга и они могут искать пути, как общаться с другими Детьми, например говорить "дай игрушку",
// спрашивать Маму: "Мама, дай конфетку",
// общаться с Папой: "Папа, купи игрушку".
//
//Вся эта иерархия лежит в объекте класса Семья, у которого есть методы, например распечатать всю Семью, т.е. метод вернёт массив всех членов Семьи.
//
//У Папы есть 3 кложера (closures)
// 1. когда он обращается к Семье - распечатать всю Семью,
// 2. распечатать Маму,
// 3. распечатать всех Детей.
//Создать всю иерархию со связями. При выходе из зоны видимости все объекты должны быть уничтожены.
//Используем Command-Line Tool.

func test() {
    let father = Father(name: "Alex")
    let mother = Mother(name: "Victoria")
    let child1 = Child(name: "Bob", father: father, mother: mother)
    let child2 = Child(name: "Ched", father: father, mother: mother)
    let family = Family(father: father, mother: mother, children: [child1,child2])
    father.printChildren()
    father.printFamily()
    father.printMother()
    child1.buyAToy()
    child2.giveCandy()
    child1.talkToChild(with: child2, message: "what's up, bro?")
    print("============")
}

test()


