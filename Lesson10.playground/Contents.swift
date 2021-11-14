import UIKit

// MARK: - Функции

// функции нужны для того, чтобы переиспользовать один и тот же код несколько раз
// принцип DRY - Don't Repeat Yourself

// у входного параметра может быть 2 имени (1- ярлык аргумента (внешнее), 2- имя параметра(внутри))
// Ярлык можно не писать (тогда он будет равен имени параметра) или игнорировать через "_"
func somefunc(_ message: String, condition: Bool) {
    if condition {
        print(message)
    }
}
somefunc("hello", condition: true)
// входному параметру можно задать дефолтное значение, тогда при вызове функции этот параметр можно не указывать
// в качестве выходного параметра может быть тюпл, что помогает выводить сразу несколько значений

let wallet = [100, 50, 1, 20, 1, 50, 1, 100, 50]

func calculateMoney(inWallet wallet: [Int], type: Int? = nil) -> (total: Int, count: Int) {
    var sum = 0
    var count = 0
    for value in wallet {
        if (type == nil) || (value == type!) {
            sum += value
            count += 1
        }
    }
    return (sum,count)
}

var (money,count) = calculateMoney(inWallet: wallet, type: 100)
money
count
var (money2,count2) = calculateMoney(inWallet: wallet, type: nil)
money2
count2
//так как есть дефолтное значение, мы можем вообще не передавать его
var (money3,count3) = calculateMoney(inWallet: wallet)
money3
count3

// MARK: - Вариативный параметр (их может быть как 0, так и несколько)
// Внутри функции этот параметр доступен в виде обычного массива указанного типа
// У функции может быть только один вариативный параметр

func calculateMoney(inSequence seq: Int...) -> Int {
    var sum = 0
    for value in seq {
        sum += value
    }
    return sum
}

calculateMoney(inSequence: 1,2,5,6,2,1,2,6)

// опциональный тюпл в качестве выходного параметра

func minMax(array: [Int]) -> (min: Int, max: Int)? {
    if array.isEmpty { return nil }
    var currentMin = array[0]
    var currentMax = array[0]
    for value in array[1..<array.count] {
        if value < currentMin {
            currentMin = value
        } else if value > currentMax {
            currentMax = value
        }
    }
    return (currentMin, currentMax)
}

let arr1 = [1,2,3,7,216,212,0]
let arr2 = [Int]()

minMax(array: arr1)
minMax(array: arr2)

// MARK: - Сквозные (inout) параметры
// По умолчанию параметры, получаемые функцией - константы
// Если нужно изменить их внутри функции и получить после выхода из нее, нужно сделать их сквозными (для этого перед объявлением типа параметра нужно написать inout)
// В качестве сквозного параметра может быть только переменная
// При вызове функции сквозной параметр указывается через знак "&" перед переменной
// У них не может быть значений по умолчанию и они не могут быть вариативными (Type...)

func swapTwoInts(_ a: inout Int, _ b: inout Int) {
    let temporaryA = a
    a = b
    b = temporaryA
}
var a = 5
var b = 10
swapTwoInts(&a, &b)
a
b

// MARK: - Рекурсивные функции (функции, которые вызывают внутри сами себя)

func factorial(_ number: Int) -> Int {
    if number <= 1 { return 1 }
    return number * factorial(number - 1)
}

factorial(4)

// MARK: - Тип функции: функции - это точно такой же тип, как и все другие
// Eе явное указание - это входные/выходные параметры

// пример 1
print("\n example 1")
func sayPhrase(phrase: String) -> Int? {
    print(phrase)
    return 0
}
sayPhrase(phrase: " smth")
let ff : (String) -> (Int?) = sayPhrase
ff(" something")

// пример 2
print(" example 2")
func sayHi() { print(" Hi") }
func doSmth(whatToDo: () -> ()) { whatToDo() }
doSmth(whatToDo: sayHi)

// пример 3
print(" example 3")
func whatToDo() -> () -> (){
    func sayHello() { print("Hello") }
    return sayHello
}

let newFunc = whatToDo()

// пример 4
print(" example 4")
func mathPlusFunc(a: Int, b: Int) -> Int { return a + b }

func example4(_ mathFunc: (Int, Int) -> Int, _ a: Int, b: Int) -> Int {
    let sum = mathFunc(a,b)
    return sum
}
print(example4(mathPlusFunc, 2, b: 3))


// MARK: - Домашка

//1. Создайте пару функций с короткими именами, которые возвращают строку с классным символом или символами. Например heart() возвращает сердце и т.п. Вызовите все эти функции внутри принта для вывода строки этих символов путем конкатенации.

print("\n TASK 1")
func rocket() -> String { return "\u{1F680}" }
func heart() -> String { return "\u{1F496}" }
print(rocket() + heart())


//2. Опять шахматные клетки. Реализовать функцию, которая принимает букву и символ и возвращает строку “белая” или “черная”. Строку потом распечатайте в консоль

print("\n TASK 2")

var arrayOfLetters = ["a", "b", "c", "d", "e", "f", "g", "h"]
let arrayOfNumbers = [1, 2, 3, 4, 5, 6, 7, 8]

func checkColor(letterGlobal: String, numberGlobal : Int) -> String? {
    var color : String?
    // если остатки от деления индексов буквы/цифры равны, то клетка черная
    for (indexOfLet,letter) in arrayOfLetters.enumerated() {
        for (indexOfNum,number) in arrayOfNumbers.enumerated() {
            if (letter == letterGlobal && number == numberGlobal) {
                color = ((indexOfLet % 2) == (indexOfNum % 2)) ? "black" : "white"
            }
        }
    }
    return color
}
let cell = ("f",4)
if let someCell = checkColor(letterGlobal: cell.0, numberGlobal: cell.1) {
    print("cell \(cell.0)\(cell.1) is \(someCell)")
} else {
    print("введена некорректная клетка")
}

//3. Создайте функцию, которая принимает массив, а возвращает массив в обратном порядке. Можете создать еще одну, которая принимает последовательность и возвращает массив в обратном порядке. Чтобы не дублировать код, сделайте так, чтобы функция с последовательностью вызывала первую.

print("\n TASK 3")

func reverseArray(forArray array: [String]) -> [String] {
    var newArray = [String]()
    for index in array.indices {
        newArray.append(array[array.count - 1 - index])
    }
    return newArray
}

func reverseSequence(forSequence seq: String...) -> [String] {
    return reverseArray(forArray: seq)
}

let reversedArray = reverseArray(forArray: arrayOfLetters)
let reversedSeq = reverseSequence(forSequence: "s","g","as")

//4. Разберитесь с inout самостоятельно и выполните задание номер 3 так, чтобы функция не возвращала перевернутый массив, но меняла элементы в существующем. Что будет если убрать inout?

print("\n TASK 4")

func reverseCurrentArray(forArray array: inout [String]) {
    array = reverseArray(forArray: array)
}

arrayOfLetters
reverseCurrentArray(forArray: &arrayOfLetters)
arrayOfLetters

//5. Создайте функцию, которая принимает строку, убирает из нее все знаки препинания, делает все гласные большими буквами, согласные маленькими, а цифры меняет на соответствующие слова (9 -> nine и тд)

print("\n TASK 5")

func transformString(forString oldString: String) -> String {
    var newString = ""
    let arrayOfNumbers = ["zero","one","two","three","four","five","six","seven","eight","nine"]
    
    for char in oldString {
        switch char {
        case "0"..."9": newString += arrayOfNumbers[Int(String(char))!]
//        case "0", "1", "2", "3", "4", "5", "6", "7", "8", "9": newString += arrayOfNumbers[Int(String(char))!]
        case "B", "C", "D", "F", "G", "H", "J", "K", "L", "M", "N", "P", "Q", "R", "S", "T", "V", "W", "X", "Z": newString += char.lowercased()
        case "a", "e", "i", "o", "u", "y": newString += char.uppercased()
        case ",",".",";",":","!","?","-": break
        default: newString += String(char)
        }
    }
    return newString
}

let oldString = "One two 3 four, five!"
let newString = transformString(forString: oldString)
print("old string: \(oldString)")
print("trasformed string: \(newString)")
