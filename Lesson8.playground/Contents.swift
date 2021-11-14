import UIKit

// MARK: - Словари (Dictionarys)

var dict : [String : String] = ["cat":"кошка","dog":"собака"] // пара Ключ : Значение
var dict2 : Dictionary<String, String> = ["cat":"кошка","dog":"собака"] // объявление через джинерики
var emptyDict = [Int : String]() //создание пустого словаря

let x = dict["cat"] // опциональный тип, т.к. может вернуть nil
let y : String? = dict["asd"]
dict.isEmpty
dict.count

dict["rabbit"] = "кролик" // добавление элемента в словарь
dict

dict["test"] = "test"
dict
dict["test"] = nil // удаление элемента из словаря
dict
dict.removeValue(forKey: "test") // удаление элемента из словаря

dict2 = [:] // удаление всех элементов
dict2.removeAll() // удаление всех элементов

dict["cat"] = "кролик" // изменение существующего элемента по ключу
dict
dict["cat"] = "кошка" // изменение существующего элемента по ключу
dict
dict.updateValue("кот", forKey: "cat") // изменение существующего элемента по ключу
dict
dict.updateValue("еуые", forKey: "test") // создание нового элемента
dict

// MARK: - Порядок в Словарях отличается от порядка его заполнения!!!
// Поэтому нельзя работать со словарем как с упорядоченной коллекцией, только по ключу
Array(dict.keys)
let keysArray = [String](dict.keys)
Array(dict.values)
let valuesArray = [String](dict.values)

// MARK: - Итерация

for key in dict.keys {
    print("key = \(key), value = \(dict[key]!)")
}

for (key, value) in dict {
    print("key = \(key), value = \(value)")
}

// MARK: - Значения по умолчанию
dict["rat",default: "крыса"]

let someDict = [String : Int]()
someDict["asd",default: -1]

// MARK: - Домашка
//1. Создайте дикшинари как журнал студентов, где имя и фамилия студента это ключ, а оценка за контрольную значение.
//     Некоторым студентам повысьте оценки - они пересдали.
//     Потом добавьте парочку студентов, так как их только что перевели к вам в группу.
//     А потом несколько удалите, так как они от вас ушли :(
//     После всех этих перетрубаций посчитайте общий бал группы и средний бал

print("\n TASK 1")

var group4410 = ["Козмодемьянов Антон" : 5,
                 "Лошаков Александр" : 3,
                 "Медведев Анатолий" : 3,
                 "Климанов Евгений" : 3,
                 "Филиппов Никита" : 4,
                 "Зуйков Даниил" : 3]

group4410.updateValue(4, forKey: "Медведев Анатолий")
group4410.updateValue(5, forKey: "Климанов Евгений")

group4410.updateValue(3, forKey: "Манешев Роман")
group4410.updateValue(4, forKey: "Сафаров Саид Ильгар оглы")

group4410.removeValue(forKey: "Манешев Роман")

var sumOfMarks = 0
for marks in group4410.values {
    sumOfMarks += marks
}
var averageScore : Double = Double(sumOfMarks) / Double(group4410.count)

print("sum of marks in group: \(sumOfMarks), average mark: \(averageScore)")

//2. Создать дикшинари дни в месяцах, где месяц это ключ, а количество дней - значение.
//В цикле выведите ключ-значение попарно, причем один раз выведите через тюплы, а другой раз пройдитесь по массиву ключей и для каждого из них доставайте значения.

print("\n TASK 2")

var monthAndDays : [String : Int] = ["november": 31,
                                     "october": 30,
                                     "december": 31,
                                     "february": 28,
                                     "april": 30,
                                     "may": 31,
                                     "march": 31,
                                     "august": 31,
                                     "september": 30,
                                     "january": 31,
                                     "june": 30,
                                     "july": 30]
print("\n 1st variant")
for (month, days) in monthAndDays {
    print("\(month) : \(days) days")
}

print("\n 2nd variant")
for month in monthAndDays.keys {
    print("\(month) : \(monthAndDays[month]!) days")
}
    
//3. Создать дикшинари , в которой ключ это адрес шахматной клетки (пример: a5, b3, g8),
// а значение это Bool.
// Если у клетки белый цвет, то значение true, а если черный - false.
// Выведите дикшинари в печать и убедитесь что все правильно.
//Рекомендация: постарайтесь все сделать используя вложенный цикл (объяснение в уроке).

print("\n TASK 3")

let arrayOfLetters = ["a", "b", "c", "d", "e", "f", "g", "h"]
let arrayOfNumbers = ["1", "2", "3", "4", "5", "6", "7", "8"]

var chessDict = [String : Bool]() // true - белые, false - черные

// если индекс буквы и цифры равны, то черный

for (indexOfLet,letter) in arrayOfLetters.enumerated() {
    for (indexOfNum,number) in arrayOfNumbers.enumerated() {
        chessDict[letter + String(number)] = !((indexOfLet % 2) == (indexOfNum % 2))
    }
}

for (cell, color) in chessDict {
    print("cell \(cell) is \(color ? "white" : "black")")
}

