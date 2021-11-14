let numbers = [1,3,5,7,9]
var arr = numbers
for (i,item) in arr.enumerated() {
//    item = item * 2
    arr[i] = arr[i]*2
}
arr


//операторы: унарные, бинарные, тернарные

let x = 2, y = -2
-x // Оператор унарного минуса
+y // Оператор унарного плюса (не меняет знак)

let num : UInt = 2
let z = +num

5 / 2
5.0 / 2

var sum = 0
sum = sum + 1
sum += 1

let a = 5, b = 6
var c : Int

// MARK: - Тернарный оператор
// тернарный оператор : 3 значения, первый - булевое значение и два варианты (true/false) для результата
// Этот вариант не только короче второго примера, но и позволяет объявить величину rowHeight константой, так как в отличие от конструкции if ее значение не нужно изменять.
if a > b { c = a }
else { c = b }

c = a > b ? a : b
//записи идентичны

// MARK: - Тернарный оператор для опционалов
// Оператор объединения по nil — это более элегантный, короткий и понятный способ одновременно проверить условие и извлечь значение
let text = "123"
let textInt = Int(text)

if textInt != nil { c = textInt! }
else { c = 0 }

c = textInt != nil ? textInt! : 0

c = textInt ?? 0

// MARK: - Диапазоны

let names = ["Anna", "Alex", "Brian", "Jack"]

let count = names.count
for i in 0..<count {
print("Person \(i + 1) будет \(names[i])")
}

// Односторонние диапазоны
for name in names[2...] { print(name) }
for name in names[..<2] { print(name) }

let range = ...5
range.contains(7)   // false
range.contains(4)   // true
range.contains(-1)  // true»


// MARK: - ДОМАШКА

// 1. Посчитать количество секунд от начала года до вашего дня рождения. Игнорируйте високосный год и переходы на летнее и зимнее время. Но если хотите - не игнорируйте :)

print("\n TASK 1")

let secsInMinute = 60
let minutesInHour = 60
let hoursInDay = 24
let secsInDay = secsInMinute * minutesInHour * hoursInDay

let january = 31 * secsInDay
let february = 28 * secsInDay
let march = 31 * secsInDay

let april = 30 * secsInDay
let may = 31 * secsInDay
let june = 30 * secsInDay

let july = 30 * secsInDay
let august = 31 * secsInDay
let september = 30 * secsInDay

let october = 30 * secsInDay
let november = 31 * secsInDay
let december = 31 * secsInDay

let birthDay = 26 // January
let today = 30 // August

let daysInJanFromBday = january / secsInDay - birthDay + 1

var secFromBdayToToday = february + march + april + may + june + july
secFromBdayToToday += daysInJanFromBday * secsInDay
secFromBdayToToday += today * secsInDay
print("\(secFromBdayToToday) seconds have passed from your Birthday to Today")

// 2. Посчитайте в каком квартале вы родились

print("\n TASK 2")

var totalSeconds = january + february + march + april + may + june + july
totalSeconds += today * secsInDay
print("\(totalSeconds) seconds have passed from the beggining of the Year to Today")

let difference = totalSeconds - secFromBdayToToday

let q1 = january + february + march // seconds from the beggining of the Year til the end of 1st quarter
let q2 = q1 + april + may + june // seconds from the beggining of the Year til the end of 2nd quarter
let q3 = q2 + july + august + september // seconds from the beggining of the Year til the end of 3rd quarter
let q4 = q3 + october + november + december // seconds from the beggining of the Year til the end of 4th quarter

if (difference <= q1) {
    print("You were born in the first quarter")
}
else if (difference > q1 && secFromBdayToToday <= q2) {
    print("You were born in the second quarter")
}
else if (difference > q2 && secFromBdayToToday <= q3) {
    print("You were born in the third quarter")
}
else if (difference > q3 && secFromBdayToToday <= q4) {
    print("You were born in the fourth quarter")
}
else {
    print("ты по-моему перепутал че-то...")
}


// 3. Создайте пять переменных типа Инт и добавьте их в выражения со сложением, вычитанием, умножением и делением. В этих выражениях каждая из переменных должна иметь при себе унарный постфиксный или префиксный оператор. Переменные могут повторяться. Убедитесь что ваши вычисления в голове или на бумаге совпадают с ответом. Обратите внимание на приоритет операций


// 4. Шахматная доска 8х8. Каждое значение в диапазоне 1…8. При заданных двух значениях по вертикали и горизонтали определите цвет поля. Если хотите усложнить задачу, то вместо цифр на горизонтальной оси используйте буквы a,b,c,d,e,f,g,h

print("\n TASK 4")

let figure = (horizontal : "A", vertical: 8)

func printColor(color : Int, figure : (horizontal : String, vertical: Int) ) {
    if color == 0 { print("клетка \(figure.horizontal)\(figure.vertical) - черная") }
    else { print("клетка \(figure.horizontal)\(figure.vertical) - белая") }
}

if ((figure.horizontal == "A") || (figure.horizontal == "C") || (figure.horizontal == "E") || (figure.horizontal == "G")) {
    if !(figure.vertical < 1 || figure.vertical > 8 ) {
        if (figure.vertical % 2 == 0) { printColor(color: 1, figure: figure) }
        else { printColor(color: 0, figure: figure) }
    }
    else { print("ТАКОЙ КЛЕТКИ НЕ СУЩЕСТВУЕТ") }
}
else if ((figure.horizontal == "B") || (figure.horizontal == "D") || (figure.horizontal == "F") || (figure.horizontal == "H")){
    if !(figure.vertical < 1 || figure.vertical > 8 ) {
        if (figure.vertical % 2 == 0) { printColor(color: 0, figure: figure) }
        else { printColor(color: 1, figure: figure) }
    }
    else { print("ТАКОЙ КЛЕТКИ НЕ СУЩЕСТВУЕТ") }
}
else { print("ТАКОЙ КЛЕТКИ НЕ СУЩЕСТВУЕТ") }
