import UIKit
import Swift

/*
// MARK: - Управление потоком

// MARK: - Оператор switch



let age = 17

switch age {
case 0...15:
    print("пиздюк")
case 16, 17:
    print("не пиздюк, но и не взрослый")
case 18...27:
    print("годен к службе")
case 28...65:
    print("пенсия")
case 65...:
    print("смерть...")
default:
    break
}

// MARK: - Кортежи в switch

let somePoint = (1, 1)
switch somePoint {
case (0, 0):
    print("\(somePoint) is at the origin")
case (_, 0):
    print("\(somePoint) is on the x-axis")
case (0, _):
    print("\(somePoint) is on the y-axis")
case (-2...2, -2...2):
    print("\(somePoint) is inside the box")
default:
    print("\(somePoint) is outside of the box")
}


// MARK: - Value binding (связывание значений)
let anotherPoint = (2, 0)
switch anotherPoint {
case (let x, 0):
    print("on the x-axis with an x value of \(x)")
case (0, let y):
    print("on the y-axis with a y value of \(y)")
case let (x, y):
    print("somewhere else at (\(x), \(y))")
}


// MARK: - Условие where
let yetAnotherPoint = (1, -1)
switch yetAnotherPoint {
case let (x, y) where x == y:
    print("(\(x), \(y)) is on the line x == y")
case let (x, y) where x == -y:
    print("(\(x), \(y)) is on the line x == -y")
case let (x, y):
    print("(\(x), \(y)) is just some arbitrary point")
}


// MARK: - Составные кейсы
let stillAnotherPoint = (9, 0)
switch stillAnotherPoint {
case (let distance, 0), (0, let distance):
    print("On an axis, \(distance) from the origin")
default:
    print("Not on an axis")
}

// MARK: - Операторы передачи управления (continue, break, fallthrough, return, throw)

// MARK: - continue
// Оператор continue говорит циклу прекратить текущую итерацию и начать новую. Он как бы говорит: "Я закончил с текущей итерацией", но полностью из цикла не выходит.

let puzzleInput = "great minds think alike"
var puzzleOutput = ""
let charactersToRemove: [Character] = ["a", "e", "i", "o", "u", " "]
for character in puzzleInput {
    if charactersToRemove.contains(character) {
        continue //"пропускай, переходи к следующей итерации"
    } else {
        puzzleOutput.append(character)
    }
}
print(puzzleOutput)

// MARK: - break
// Оператор break останавливает выполнение всей инструкции управления потоком. Оператор break может быть использован внутри инструкции switch или внутри цикла, когда вы хотите остановить дальнейшее выполнение switch или цикла раньше, чем он должен закончиться сам по себе.
// Когда оператор break используется внутри цикла, то он немедленно прекращает работу цикла, и выполнение кода продолжается с первой строки после закрывающей скобки цикла (}). Никакой последующий код из текущей итерации цикла выполняться не будет, и никакие дальнейшие итерации цикла не будут запускаться

let numberSymbol: Character = "三"  // Цифра 3 в упрощенном Китайском языке
var possibleIntegerValue: Int?
switch numberSymbol {
case "1", "١", "一", "๑":
    possibleIntegerValue = 1
case "2", "٢", "二", "๒":
    possibleIntegerValue = 2
case "3", "٣", "三", "๓":
    possibleIntegerValue = 3
case "4", "٤", "四", "๔":
    possibleIntegerValue = 4
default:
    break
}
if let integerValue = possibleIntegerValue {
    print("The integer value of \(numberSymbol) is \(integerValue).")
} else {
    print("An integer value could not be found for \(numberSymbol).")
}
// Выведет "The integer value of 三 is 3."

// MARK: - fallthrough
//Если вам по какой-то причине нужно аналогичное проваливание как в C, то вы можете использовать оператор fallthrough в конкретном кейсе. Пример ниже использует fallthrough для текстового описания целого числа
//!!!Важно: Ключевое слово fallthrough не проверяет условие кейса, оно позволяет провалиться из конкретного кейса в следующий или в default, что совпадает со стандартным поведением инструкции switch в языке C.

let integerToDescribe = 5
var description = "The number \(integerToDescribe) is"
switch integerToDescribe {
case 2, 3, 5, 7, 11, 13, 17, 19:
    description += " a prime number, and also"
    fallthrough
default:
    description += " an integer."
}
print(description)

// MARK: - Маркированные инструкции
//иногда полезно явно указывать какой цикл или какую инструкцию switch вы хотите прервать оператором break
//Так же, если у вас есть несколько вложенных циклов, то может быть полезным явное указание того, на какой цикл именно будет действовать оператор continue.

mainLoop: for _ in 1...100 {
    
    for i in 0...10 {
        if i == 5 {
            break mainLoop
        }
        print(i)
    }
    
}

// MARK: - Ранний выход из функции через return

func greet(person: [String: String]) {
    guard let name = person["name"] else {
        return
    }
    print("Привет \(name)!")

    guard let location = person["location"] else {
        print("Надеюсь у тебя там хорошая погода.")
        return
    }
    print("Надеюсь в \(location) хорошая погода.")
}

greet(person: ["name": "John"])
greet(person: ["name": "Jane", "location": "Cupertino"])

// MARK: - Проверка доступности API

if #available(iOS 10, macOS 10.12, *) {
    // Используйте API iOS 10 для iOS и используйте API macOS 10.12 на macOS
} else {
    // Используйте более старые API для iOS и macOS
}

let array : [Any] = [2, Double(2.5), Float(2.3)]

switch array[2] {
case _ as Int: print("Int")
case _ as Double: print("Double")
case _ as Float: print("Float")
default:
    print("Unknown type :(")
}
*/
// MARK: - Домашка

//1. Создать строку произвольного текста, минимум 200 символов. Используя цикл и оператор свитч посчитать количество гласных, согласных, цифр и символов.
print("\n TASK 1")
let string = "Marianne distant breakfast exercise replying screened knew picture favourite assistance. Sportsmen amiable savings likely engaged danger beauty said ﻿no view diverted if. Suffer sang sportsman service park need temper adieus simplicity park present. Although colonel arise."

string.count
var sumOfVowels = 0 // гласные
var sumOfСonsonant = 0 // согласные
var sumOfNumbers = 0 // цифры
var sumOfSymbols = 0 // другие символы
for char in string {
    switch char {
    case "0", "1", "2", "3", "4", "5", "6", "7", "8", "9": sumOfNumbers += 1
    case "a", "e", "i", "o", "u", "y", "A", "E", "I", "O", "U", "Y": sumOfVowels += 1
    case "b", "c", "d", "f", "g", "h", "j", "k", "l", "m", "n", "p", "q", "r", "s", "t", "v", "w", "x", "z", "B", "C", "D", "F", "G", "H", "J", "K", "L", "M", "N", "P", "Q", "R", "S", "T", "V", "W", "X", "Z": sumOfСonsonant += 1
    default: sumOfSymbols += 1
    }
}
print("sumOfVowels: \(sumOfVowels), sumOfСonsonant: \(sumOfСonsonant), sumOfNumbers: \(sumOfNumbers), sumOfSymbols: \(sumOfSymbols)")

//2. Создайте свитч который принимает возраст человека и выводит описание жизненного этапа
print("\n TASK 2")
let yourAge = 21

switch yourAge {
case 0...5: print("детский сад")
case 6...16: print("школа")
case 17: print("призывная комиссия")
case 18...25: print("универ, отсрочка от армии")
case 26: print("откосить не вышло, теперь в дурку")
case 27: print("все равно не вышло откосить, иди в армию")
case 28: print("смерть в афганистане")
default: print("R.I.P")
}

//3. У вас есть имя отчество и фамилия студента (русские буквы).
//Имя начинается с А или О, то обращайтесь к студенту по имени, если же нет, то
//если у него отчество начинается на В или Д, то обращайтесь к нему по имени и отчеству, если же опять нет,
//то в случае если фамилия начинается с Е или З, то обращайтесь к нему только по фамилии.
//В противном случае обращайтесь к нему по полному имени.
print("\n TASK 3")
let fio = (surname: "Лошаков", name: "Александр", fatherName: "Васильевич")
let str = "asd"
switch fio {
case let (_, name, _) where name.first == "А" || name.first == "О":
    print("Здравствуйте, \(name)")
case let (_, name, fatherName) where fatherName.first == "В" || fatherName.first == "Д":
    print("Здравствуйте, \(name) \(fatherName)")
case let (surname, _, _) where surname.first == "Е" || surname.first == "З":
    print("Здравствуйте, \(surname)")
default:
    print("Здравствуйте, \(fio.surname) \(fio.name) \(fio.fatherName)")
}

//4. Представьте что вы играете в морской бои и у вас осталось некоторое количество кораблей на поле 10Х10 (можно буквы и цифры, а можно только цифры). Вы должны создать свитч, который примет тюпл с координатой и выдаст один из вариантов: мимо, ранил, убил.
//
//задание не выполнено полностью, не учтены многие моменты, но в рамках данного урока только так...

print("\n TASK 4")

let point = (x: "f", y: 3)

/// корабль (x,y - координаты левой верхней границы, w,h - ширина и высота, z - число оставшихся "вживых" клеток)
var ship0 = (x: "f", y: 1, w: 3, h: 1, z: 3)
var ship1 = (x: "e", y: 3, w: 1, h: 1, z: 1)


switch point {
case let (x, 1...3) where x == "f" : print("ранил")
case let (x, y) where x == "e" && y == 3: print("убил")
default: print("мимо")
}
