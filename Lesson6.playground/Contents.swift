import UIKit

let regionalIndicatorForUS: Character = "\u{1F1FA}\u{1F1F8}"

var emptyString = "" // empty string literal
var anotherEmptyString = String() // initializer syntax
// обе строки пусты и эквиваленты друг другу
emptyString.isEmpty

let wiseWords = "\"Imagination is more important than knowledge\" - Einstein"
let dollarSign = "\u{24}"        // $,  Unicode scalar U+0024
let blackHeart = "\u{2665}"      // ♥,  Unicode scalar U+2665
let sparklingHeart = "\u{1F496}" // , Unicode scalar U+1F496»

print(#"Line 1\nLine 2"#)


// MARK: - Расширяемые наборы графем
let eAcute: Character = "\u{E9}" // é
let combinedEAcute: Character = "\u{65}\u{301}" // e с последующим
// eAcute равен é, combinedEAcute равен é

// MARK: - Подсчет символов
let unusualMenagerie = "Коала , Улитка , Пингвин , Верблюд "
print("unusualMenagerie содержит \(unusualMenagerie.count) символов")
// Выведет "unusualMenagerie содержит 39 символов"

var word = "cafe"
print("количество символов в слове \(word) равно \(word.count)")
// Выведет "количество символов в слове cafe равно 4"
word += "\u{301}" // COMBINING ACUTE ACCENT, U+0301
print("количество символов в слове \(word) равно \(word.count)")
// Выведет "количество символов в слове café равно 4"
print("количество символов через метод length у типа NSString равно \((word as NSString).length)")

//Значения типа String могут быть созданы путем передачи массива типа [Character] в инициализатор:
let a : Character = "a"
let b : Character = "b"
let c : Character = "c"
let arrayOfCharacters: [Character] = [a,b,c]
var charactersToString = String(arrayOfCharacters)
print(charactersToString)

// Добавить значение типа Character к переменной типа String:
let exclamationMark: Character = "!"
charactersToString.append(exclamationMark)

// MARK: - Индексы строки
//Каждое String значение имеет связанный тип индекса: String.Index, что соответствует позиции каждого Character в строке.

// Вы можете использовать синтаксис индекса для доступа Character в определенном индексе String.
// startIndex - позиция первого Character в String.
// endIndex — это позиция ПОСЛЕ ПОСЛЕДНЕГО СИМВОЛА в String.
// В результате, endIndex свойство не является допустимым значением для сабскрипта строки.
// Если String пустая, то startIndex и endIndex равны.
let greeting = "Guten Tag!"
greeting[greeting.startIndex] // G
greeting[greeting.index(before: greeting.endIndex)] // !
greeting[greeting.index(after: greeting.startIndex)] // u
let index = greeting.index(greeting.startIndex, offsetBy: 7)
greeting[index] // a

// свойство indices - создание Range всех индексов, используемых для доступа к символам строки
for index in greeting.indices {
    print("\(greeting[index]) ", terminator: " ")
}
// Выведет "G u t e n T a g !





// MARK: - Домашка
//1. Выполните задание 1 урока о базовых операторах: /skuter04
//только вместо forced unwrapping и optional binding используйте оператор ??
//Когда посчитаете сумму, то представьте свое выражение в виде строки
//Например: 5 + nil + 2 + 3 + nil = 10
//но в первом случае используйте интерполяцию строк, а во втором конкатенацию

print("\n TASK 1")

let (one, two, three, four, five) = ("-2","51d","351","4a2","42")

let intOne = Int(one) ?? 0
let intTwo = Int(two) ?? 0
let intThree = Int(three) ?? 0
let intFour = Int(four) ?? 0
let intFive = Int(five) ?? 0

var sum = intOne + intTwo + intThree + intFour + intFive

let strOne = Int(one) == nil ? "nil" : one
let strTwo = Int(two) == nil ? "nil" : two
let strThree = Int(three) == nil ? "nil" : three
let strFour = Int(four) == nil ? "nil" : four
let strFive = Int(five) == nil ? "nil" : five

//интерполяция
var resString1 : String = "\(strOne) + \(strTwo) + \(strThree) + \(strFour) + \(strFive) = \(sum)"
print(resString1)

//контатенация
var resString2 = String()
resString2 += strOne + " + "
resString2 += strTwo + " + "
resString2 += strThree + " + "
resString2 += strFour + " + "
resString2 += strFive + " = "
resString2 += String(sum)
print(resString2)


//2. Поиграйтесь с юникодом и создайте строку из 5 самых классных по вашему мнению символов,
//можно использовать составные символы. Посчитайте длину строки методом SWIFT и Obj-C

print("\n TASK 2")

let charString = "\u{1F680} \u{1F60E} \u{267B} \u{2728} \u{1F496}"
print("Your string: \(charString)")
print("Count of elements (Swift) : \(charString.count)")
print("Count of elements (Obj-C) : \((charString as NSString).length)")

//3. Создайте строку английский алфавит, все буквы малые от a до z
//задайте константу - один из символов этого алфавита
//Используя цикл for определите под каким индексов в строке находится этот символ

print("\n TASK 3")

let alphabet = "abcdefghijklmnopqrstuvwxyz"
let letter : Character = "f"
for (i,item) in alphabet.enumerated() {
    if (letter == item) {
        print("Буква нашлась. ее индекс в массиве - \(i), а порядковый номер - \(i+1)")
    }
}
