import Foundation

// MARK: - 23 - Опциональные Цепочки (optional chaining) и Приведение Типов

// MARK: - TODO: Настроить связи сестер/братьев (ставить связи в обратную сторону)

// MARK: - Домашка

//Сегодня будем строить свою небольшую социальную сеть.
//1. Сделать класс Человек, у этого класса будут проперти Папа, Мама, Братья, Сестры (всё опционально).
//Сделать примерно 30 человек, взять одного из них, поставить ему Папу/Маму. Папе и Маме поставить Пап/Мам/Братьев/Сестер. Получится большое дерево иерархии.
//Посчитать, сколько у этого человека двоюродных Братьев, троюродных Сестёр, Теть, Дядь, итд

//2. Все сестры, матери,... должны быть класса Женщина, Папы, братья,... класса Мужчины.
//У Мужчин сделать метод Двигать_диван, у Женщин Дать_указание (двигать_диван). Всё должно работать как и ранее.
//Всех этих людей положить в массив Семья, пройти по массиву посчитать количество Мужчин и Женщин, для каждого Мужчины вызвать метод Двигать_диван, для каждой женщины Дать_указание.

//3. Расширить класс человек, у него будет проперти Домашние_животные. Животные могут быть разные (попугаи, кошки, собаки...) их может быть несколько, может и не быть вообще.
//Раздать некоторым людям домашних животных. Пройти по всему массиву людей. Проверить каждого человека на наличие питомца, если такой есть - добавлять всех животных в массив животных. Посчитать сколько каких животных в этом массиве.
//Вся эта живность должна быть унаследована от класса Животные. У всех животных должен быть метод Издать_звук(крик) и у каждого дочернего класса этот метод переопределён на свой, т.е. каждое животное издаёт свой звук.
//Когда проходим по массиву животных, каждый представитель вида животных должен издать свой звук.

//Обязательно используем в заданиях Optional chaining и Type casting

if true {
    let alex = Man(name: "Alexander")    // сам человек
    let anya = Woman(name: "Ann")          // сестра

    let natalya = Woman(name: "Natalya")   // мать
    let nina = Woman(name: "Nina")         // мать матери (бабушка-2)
    let leonid = Man(name: "Leonid")     // отец матери (дедушка-2)
    let uriy = Man(name: "Juriy")        // брат матери (дядя-1)
    let natalya2 = Woman(name: "Natalya")  // жена дяди
        
    let misha = Man(name: "Mihail")      // сын дяди (дв.брат-2)
    let kate = Woman(name: "Kate")         // дочь дяди (дв.сестра-2)

    let vasya = Man(name: "Vasiliy")     // отец
    let ivan = Man(name: "Ivan")         // отец отца (дедушка-1)
    let galina = Man(name: "Galina")     // мать отца (бабушка-1)
        
    let lena = Woman(name: "Elena")        // сестра отца (тетя-1)
    let mishaUncle = Man(name: "Mihail") // муж тети
    let valeraUncle = Man(name: "Valeriy")    // муж тети
        
    let masha = Woman(name: "Maria")       // дочь тети (дв.сестра-1)
    let dima = Man(name: "Dmitry")       // сын тети (дв.брат-1)
        
    let olya = Woman(name: "Olga")         // сестра отца (тетя-2)
    let tolya = Man(name: "Tolya")         // сестра отца (тетя-2)
    let tanya = Woman(name: "Tatiana")     // дочь тети (дв.сестра-1)
    let alena = Woman(name: "Alena")       // дочь тети (дв.сестра-1)
    
    alex.setFamily(father: vasya, mother: natalya, sisters: [anya], brothers: nil)
    anya.setFamily(father: vasya, mother: natalya, sisters: nil, brothers: [alex])
    
    vasya.setFamily(father: ivan, mother: galina, sisters: [olya,lena], brothers: nil)
    olya.setFamily(father: ivan, mother: galina, sisters: [lena], brothers: [vasya])
    lena.setFamily(father: ivan, mother: galina, sisters: [olya], brothers: [vasya])
    
    natalya.setFamily(father: leonid, mother: nina, sisters: nil, brothers: [uriy])
    uriy.setFamily(father: leonid, mother: nina, sisters: [natalya], brothers: nil)
        
    misha.setFamily(father: uriy, mother: natalya2, sisters: [kate], brothers: nil)
    kate.setFamily(father: uriy, mother: natalya2, sisters: nil, brothers: [misha])
    
    tanya.setFamily(father: tolya, mother: olya, sisters: [alena], brothers: nil)
    alena.setFamily(father: tolya, mother: olya, sisters: [tanya], brothers: nil)
    masha.setFamily(father: mishaUncle, mother: lena, sisters: nil, brothers: [dima])
    dima.setFamily(father: valeraUncle, mother: lena, sisters: [masha], brothers: nil)
    
    let family : [Person] = [
        alex,anya,
        natalya,nina,leonid,uriy,natalya2,misha,kate,
        vasya,ivan,galina,
        lena,mishaUncle,valeraUncle,masha,dima,
        olya,tolya,tanya,alena
    ]
    
    print("\n TASK 1\n")
    alex.printFamilyTree(for: family)

    print("\n TASK 2\n")
        
    var manCount = 0
    var womanCount = 0
    
    for member in family {
        if let man = member as? Man {
            manCount += 1
            man.moveSofa()
        } else if let woman = member as? Woman {
            womanCount += 1
            woman.makeACall()
        }
    }
    
    print("There're \(manCount) men and \(womanCount) women in family")
    
    print("\n TASK 3\n")
        
    let rat1 = Rat(name: "Misha")
    let rat2 = Rat(name: "Makovka")
    let cat = Cat(name: "Busya")
    let dog = Dog(name: "Rex")
    let sparrow = Sparrow(name: "Kar-Karich")
    alex.pets = [rat1,rat2]
    natalya.pets = [cat]
    ivan.pets = [dog]
    dima.pets = [sparrow]
    
    var petCount = 0
    
    for member in family {
        if let pets = member.pets {
            petCount += pets.count
            for pet in pets {
                pet.makeASound()
            }
        }
    }
    
    print("There're \(petCount) pets in family")
    
    print("\n===\n")

}
