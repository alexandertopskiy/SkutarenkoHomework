import Foundation

// MARK: - Домашка

//1. Объявить протокол Food, который будет иметь проперти name (только чтение) и метод taste(), который будет выводить текст со вкусовыми ощущениями

//2.Все продукты разных типов, которые вы принесли из супермаркета, находятся в сумке (массив) и все, как ни странно, реализуют протокол Food.
//  Вам нужно пройтись по сумке, назвать предмет и откусить кусочек.
//  Можете отсортировать продукты по имени. Используйте для этого отдельную функцию, которая принимает массив продуктов

//3.Некоторые продукты могут испортиться, если их не положить в холодильник.
//  Создайте новый протокол Storable, он наследуется от протокола Food и содержит еще булевую проперти - expired.
//  У некоторых продуктов замените Food на Storable.
//  Теперь пройдитесь по всем продуктам и, если продукт надо хранить в холодильнике, то перенесите его туда, но только если продукт не испорчен уже, иначе просто избавьтесь от него.
//  Используйте функцию для вывода продуктов для вывода содержимого холодильника

//4.Добавьте проперти daysToExpire в протокол Storable. Отсортируйте массив продуктов в холодильнике. Сначала пусть идут те, кто быстрее портятся. Если срок совпадает, то сортируйте по имени.

//5.Не все, что мы кладем в холодильник, является едой. Поэтому сделайте так, чтобы Storable не наследовался от Food. Мы по прежнему приносим еду домой, но некоторые продукты реализуют теперь 2 протокола. Холодильник принимает только те продукты, которые еще и Storable. функция сортировки должна по прежнему работать.

print("\n TASK 1")

protocol Priority {
    var order: Int { get }
}

protocol Food : Priority {
    var name: String { get }
    func taste() -> String
}

protocol Storable {
    var expired: Bool { get }
    var daysToExpire: Int { get }
}


print("\n TASK 2")

class Apple : Food {
    var name: String = "Apple"
    func taste() -> String { return "It's Healthy and Sweet" }
    var order: Int = 1
}

class Milk : Food, Storable {
    var name: String = "Milk"
    func taste() -> String { return "It Healthy and Cold" }
    var order: Int = 2
    var expired: Bool = false
    var daysToExpire: Int = 7
}

class Eggs: Food, Storable {
    var name: String = "Eggs"
    func taste() -> String { return "It a bit liquid... I'd better to fry it" }
    var order: Int = 2
    var expired: Bool = false
    var daysToExpire: Int = 14
}

class Carrot : Food {
    var name: String = "Carrot"
    func taste() -> String { return "It's Just Healthy" }
    var order: Int = 1
}

class Candy : Food {
    var name: String = "Candy"
    func taste() -> String { return "It's Very sweet" }
    var order: Int = 3
}

let apple = Apple()
let milk = Milk()
let milk2 = Milk()
milk.name = "Prostokvashino"
milk2.name = "Selo Zelenoe"
milk2.expired = true
let eggs = Eggs()
eggs.name = "Red Price C0"
let eggsToo = Eggs()
eggsToo.name = "Eggs C0"
let carrot = Carrot()
let candy = Candy()
let cookie = Candy()
cookie.name = "Cookie"

var bag : [Food] = [carrot, cookie, apple, eggs, eggsToo, milk, candy, milk2]

func eatBag(bag: inout [Food]) {
    bag.sort { a, b in
        if (a.order == b.order) {
            return a.name.lowercased() < b.name.lowercased()
        } else {
            return a.order < b.order
        }
    }
    for item in bag {
        print("bite a \(item.name)... " + item.taste())
    }
}

eatBag(bag: &bag)

print("\n TASK 3")
func loadTheFridge(bag: [Food]) -> [Food & Storable] {
    var fridge = [Food & Storable]()
    for item in bag {
        switch item {
        case let product as Food & Storable where product.expired:
            print("\(product.name) is expired, let's throw it out")
        case let product as Food & Storable where !product.expired:
            print("\(product.name) isn't expired, put in in fridge...")
            fridge.append(product)
        default:
            print("\(item.name) is not storable, put it in food cabinet")
        }
    }
    return fridge
}

var fridge = loadTheFridge(bag: bag)
print("Items in fridge:")
for item in fridge {
    print(item.name)
}

print("\n TASK 4")
func printFridgeInfo(fridge: [Food & Storable]) {
    let sortedFridge = fridge.sorted { a, b in
        if (a.daysToExpire == b.daysToExpire) {
            return a.name < b.name
        } else {
            return a.daysToExpire < b.daysToExpire
        }
    }
    for item in sortedFridge {
        print("Item: \(item.name), daysToExpire: \(item.daysToExpire)")
    }
}

printFridgeInfo(fridge: fridge)
