import UIKit


//объявление типа массива разными способами
var array1 : Array<Int> = [1,2,3,4,5]
var array2 : [Int] = [1,2,3,4,5]
var someArray = [Int]()
let test = [Int](repeating: 10, count: 5)

array1
array1[1...3] = [3]
array1

// MARK: - добавление/удаление элементов
array1.insert(7, at: 3 ) // добавление по индексу
array1 += [10] // добавление в конец
array1.append(5) // добавление в конец
array1.remove(at: 1) // удаление по индексу
array1.removeLast()
array1

let money = [100, 20, 1, 5, 5, 1, 100, 20, 50]

var sum = 0
for item in money { sum += item }
sum

sum = 0

for (index, value) in money.enumerated() {
    sum += value
    print("index = \(index), value = \(value)")
}
sum

// MARK: - Множества (Set'ы)

// MARK: - Инициализация
 var letters = Set<Character>()
 print("letters имеет тип Set<Character> с \(letters.count) элементами.")
 
var favoriteGenres: Set<String> = ["Rock", "Classical", "Hip hop"]
var testSet: Set = ["Rock", "Classical", "Hip hop"]

// MARK: - Свойства и методы
favoriteGenres.count
favoriteGenres.isEmpty
favoriteGenres.insert("Rock") // не вставит элемент, т.к. он уже есть
favoriteGenres.insert("Rap")
favoriteGenres.remove("Rock")
favoriteGenres.remove("Rock-n-Roll")
favoriteGenres.contains("Hip hop")

// MARK: - Итерация
for item in favoriteGenres { print(item) }

// MARK: - Сортировка (от меньшего к большему)
favoriteGenres.sorted()

// MARK: - Операции над множествами

let oddDigits: Set = [1, 3, 5, 7, 9]
let evenDigits: Set = [0, 2, 4, 6, 8]

oddDigits.union(evenDigits) // логическое ИЛИ
oddDigits.intersection(evenDigits) // объединение (логическое И)
oddDigits.symmetricDifference(evenDigits) // симметричная разница (все, кроме общего)
oddDigits.subtracting(evenDigits) // разница (то, что есть только в первом)

let setA: Set = ["1", "2", "3", "4", "5"]
let setB: Set = ["1", "2"]
let setC: Set = ["3", "4"]
let copyOfSetB: Set = setB

setA == setC // для определения все ли значения двух множеств одинаковы.
setB.isSubset(of: setA) // является ли подмножеством
setA.isSuperset(of: setB) // является ли "множеством-родителем" (содержит ли все значения второго)
setB.isDisjoint(with: setC) //отсутствуют ли общие значения в двух множествах или нет.
setB.isStrictSubset(of: setA) // является ли подмножеством И не равным второму
setB.isStrictSubset(of: copyOfSetB)
setB.isStrictSuperset(of: copyOfSetB)
setA.isStrictSuperset(of: setB) // является ли надмножеством И не равным второму


// MARK: - Домашка

/* 1. создать массив "дни в месяцах"
12 элементов содержащих количество дней в соответствующем месяце
используя цикл for и этот массив
- выведите количество дней в каждом месяце (без имен месяцев)
- используйте еще один массив с именами месяцев чтобы вывести название месяца + количество дней
- сделайте тоже самое, но используя массив тюплов с параметрами (имя месяца, кол-во дней)
- сделайте тоже самое, только выводите дни в обратном порядке (порядок в массиве не меняется)
- для произвольно выбранной даты (месяц и день) посчитайте количество дней до этой даты от начала года */

print("\n TASK 1")

// days in month
let (january, february, march) = (31, 28, 31)
let (april, may, june) = (30, 31, 30)
let (july, august, september) = (30, 31, 30)
let (october, november, december) = (30, 31, 31)

let arraysOfDays = [january,february,march,april,may,june,july,august,september,october,november,december]
let arraysOfMonthNames = ["january","february","march","april","may","june","july","august","september","october","november","december"]

var str1 = ""
print("\n 1. Number of Days: ")
for (index,day) in arraysOfDays.enumerated() { print(" month #\(index+1) has \(day) dys") }

print("\n 2. Number of Days: ")
for (index,day) in arraysOfDays.enumerated() {
    print(" month \(arraysOfMonthNames[index]) has \(day) dys")
}

let birthDay = 26 // January
let today = 30 // August

var tupleArray = [(month: String , days: Int)]()
for (index,month) in arraysOfMonthNames.enumerated() {
    tupleArray.append((month: month, days: arraysOfDays[index]))
}
print("\n 3. Tuple array: ")
for item in tupleArray {
    print(" month \(item.month) has \(item.days) dys")
}

print("\n 4. Reversed Tuple array: ")
for item in tupleArray.reversed() {
    print(" month \(item.month) has \(item.days) dys")
}

//- для произвольно выбранной даты (месяц и день) посчитайте количество дней до этой даты от начала года
let testData = (month: "september", day: 3)
var sumOfDays = 0
for item in tupleArray {
    sumOfDays += item.days
    if (item.month == testData.month) {
        sumOfDays -= (item.days - testData.day)
        break
    }
}

print("\n 5. \(sumOfDays) days have past since the beggining of year")

/* 2. Сделайте первое задание к уроку номер 4 используя массивы:
(создайте массив опшинал интов и посчитайте сумму)

- в одном случае используйте optional binding
- в другом forced unwrapping
- а в третьем оператор ?? */
 
print("\n TASK 2")

let (one, two, three, four, five) = ("-2","51d","351","4a2","42")
let (intOne, intTwo, intThree, intFour, intFive) = (Int(one),Int(two),Int(three),Int(four),Int(five))

let arrayOfInt : [Int?] = [intOne, intTwo, intThree, intFour, intFive]

var (sum1, sum2, sum3) = (0, 0, 0)

for item in arrayOfInt { if item != nil { sum1 += item! } }
for item in arrayOfInt { if let x = item { sum2 += x } }
for item in arrayOfInt { sum3 += item ?? 0 }

print(" sum1 (forced unwrapping) = \(sum1)")
print(" sum2 (optional binding) = \(sum2)")
print(" sum3 (??) = \(sum3)")

/* 3. создайте строку алфавит и пустой массив строк
в цикле пройдитесь по всем символам строки попорядку, преобразовывайте каждый в строку и добавляйте в массив, причем так, чтобы на выходе получился массив с алфавитом задом-наперед */

print("\n TASK 3")

let alphabet = "abcdefghijklmnopqrstuvwxyz"
var arrayOfStr : [String] = []

for letter in alphabet {
    arrayOfStr.insert(String(letter), at: 0)
}

print(" Reversed Array of Strings : \(arrayOfStr) ")
