import UIKit

// MARK: - Клоужеры (Замыкания)

/*

Замыкания - это анонимные функции, которые можно передавать в качестве аргументов другим функциям

 { (параметр) -> Возвращаемый_тип in
    операторы
 }

*/


// MARK: - Захват значений
func greeting(greetingMessage: String) -> (String) -> (String) {
    return { (name: String) -> String in
        return "\(greetingMessage), \(name)!"
    }
}
let englishGreeting = greeting(greetingMessage: "Hello")
englishGreeting("Alex")
let russianGreeting = greeting(greetingMessage: "Привет")
russianGreeting("Александр")



// MARK: - Примеры использования замыканий на примере функции sorted

let numbersArray = [1,2,7,1,6,3]
// сортировка через отдельную полноценную функцию
func backward(_ a: Int, _ b: Int) -> Bool {
    return a > b
}
var sortedNumbers = numbersArray.sorted(by: backward)

// сортировка через замыкающее выражение
var sortedNumbersByClouser = numbersArray.sorted { (a: Int, b: Int) -> Bool in
    return a > b
}
var x = numbersArray.sorted()

// MARK: - Метод sorted, описанный вручную
func filterArray(array: [Int], f: (Int) -> Bool) -> [Int] {
    var filteredArray = [Int]()
    for i in array {
        if f(i) {
            filteredArray.append(i)
        }
    }
    return filteredArray
}

func compare(i: Int) -> Bool {
    return i % 2 == 0 //вернуть только четные
}
filterArray(array: numbersArray, f: compare)
filterArray(array: numbersArray, f: { (i: Int) -> Bool in
    return i % 2 == 0
})

// MARK: - Получение типа данных из контекста
// (в данном примере не нужно передавать array2, замыкание понимает, что это такое)
var count = 0
let array2 = [1,2,3]
let result4 =
    filterArray(array: numbersArray, f: { value in
        for include in array2 {
            count += 1
            if value == include {
                return true
            }
        }
        return false
    })
count
// на этот способ сортировки двух массивов по совпадению не очень хорош
// лучше создать словарь(сет) для выборки, а потом прогнать проверяемый массив по нему

count = 0
var dict = [Int: Bool]()
for value in array2 {
    count += 1
    dict[value] = true
}

let result5 =
    filterArray(array: numbersArray, f: { value in
        count += 1
        return dict[value] != nil
    })
count

// MARK: - Упрощение записи
// можно не указывать типы входа/выхода, компилятор поймет это из контекста
filterArray(array: numbersArray, f: { value in
    return value % 2 == 1
} )
// если замыкание однострочное, то можно даже не писать return
let result = filterArray(array: numbersArray, f: { i in i % 3 == 0 })
// еще более сокращенная запись: $n (n-ый входной параметр)
let result2 = filterArray(array: numbersArray, f: { $0 % 3 == 0 })
// если клоужер должен выполняться в конце выполнения функции, то его можно записать после круглых скобок
let result3 = filterArray(array: numbersArray) { $0 % 3 == 0 }
// Самая короткая запись метода sorted
let result6 = numbersArray.sorted(by: <)
    


// MARK: - Пример использования последующий замыканий на примере метода map
// После применения замыкания к каждому элементу массива, метод map(_:) возвращает новый массив, содержащий новые преобразованные величины, в том же порядке, что и в исходном массиве

let newNumbersArray = [15, 24, 67, 43]
let numbersGlossary : [Int: String] = [
    0 : "Zero", 1 : "One",  2 : "Two",  3 : "Three", 4 : "Four",
    5 : "Five", 6 : "Six", 7 : "Seven", 8 : "Eight", 9 : "Nine"
]

let stringNumbers = newNumbersArray.map { (number) -> String in
    var stringValue = ""
    var number = number
    
    repeat {
        if let x = numbersGlossary[number % 10] {
            stringValue = x + stringValue
        } else {
            print("Cимвола \(number) нет в словаре")
            stringValue = "?" + stringValue
        }
        number /= 10
    } while number > 0
    return stringValue
}


// MARK: - Замыкания - ссылочный тип

func makeIncrement(forIncrement amount: Int) -> () -> Int {
    var runningTotal = 0
    func incrementor() -> Int {
        runningTotal += amount
        return runningTotal
    }
    return incrementor
}

let incrByTen = makeIncrement(forIncrement: 10)
incrByTen() // 10 // хоть значение и было объявлено константой, оно изменяется, потому что ССЫЛАЕТСЯ на замыкание
incrByTen() // 20
let incrBySeven = makeIncrement(forIncrement: 7)
incrBySeven() // 7
incrBySeven() // 14

incrByTen() // 30
incrBySeven() // 21

let alsoIncrByTen = incrByTen
alsoIncrByTen() // хоть мы и объявили эту константу только что, она уже возвращает 40, т.к. ссылается на предыдущее значени


// MARK: - Сбегающие замыкание

//Добавляя к любому аргументу замыкания префикс @escaping, вы передаете сообщение вызывающему функцию, что это замыкание может «избежать» область вызова функции. Без префикса @escaping замыкание по умолчанию не является сбегающим, и его жизненный цикл заканчивается вместе с областью действия функции.
//Несбегающее замыкание заканчивается вместе с выполнением самой функции
//@escaping - это способ сообщить тем, кто использует нашу функцию, что параметр закрытия где-то хранится и может пережить область действия функции. Если вы видите какой-либо префикс @escaping, вы должны быть осторожны с тем, что вы передали в него замыкание, поскольку это может вызвать цикл сильных ссылок.

var completionHandlers: [() -> Void] = []

func someFunctionWithEscapingClosure(completionHandler: @escaping () -> Void) {
    completionHandlers.append(completionHandler) // (1.2) добавили в completionHandlers полученную инструкию
}

func someFunctionWithNonescapingClosure(closure: () -> Void) {
    closure()
}

class SomeClass {
    var x = 10
    func doSomething() {
        someFunctionWithEscapingClosure { self.x = 100 } // (1.1) передали в сбегающее замыкание эту инструкцию
        someFunctionWithNonescapingClosure { x = 200 } // (2) установили для x значение 200, после выхода из метода оно будет таким
    }
}

let instance = SomeClass()
instance.doSomething() // (2)
print(instance.x) // Выведет "200"

completionHandlers.first?() // (1.3) вызываем замыкание, в котором указано "self.x = 100", и теперь свойство x класса будет 100
print(instance.x) // Выведет "100"

// MARK: - Автозамыкания

// Автозамыкания - замыкания, которые автоматически создаются для заключения выражения, которое было передано в качестве аргумента функции. Такие замыкания не принимают никаких аргументов при вызове и возвращают значение выражения, которое заключено внутри нее. Синтаксически вы можете опустить круглые скобки функции вокруг параметров функции, просто записав обычное выражение вместо явного замыкания

var customersInLine = ["Chris", "Alex", "Ewa", "Barry", "Daniella"]
print(customersInLine.count)
// Выведет "5"
 
let customerProvider = { customersInLine.remove(at: 0) } // мы создали замыкание, котороме сможем использовать, когда захотим
print(customersInLine.count) // пока что массив все еще состоит из 5 элементов
// Выведет "5"
 
print("Now serving \(customerProvider())!") // теперь мы вызываем замыкание
// Выведет "Now serving Chris!"
print(customersInLine.count) // теперь в массиве 4 элемента
// Выведет "4"

// тот же самый код в виде функции
// customersInLine равен ["Alex", "Ewa", "Barry", "Daniella"]
func serve(customer customerProvider: () -> String) {
    print("Now serving \(customerProvider())!")
}
serve(customer: { customersInLine.remove(at: 0) } )
// Выведет "Now serving Alex!»

func serve(customer customerProvider: @autoclosure () -> String) {
    print("Now serving \(customerProvider())!")
}
serve(customer: customersInLine.remove(at: 0) ) // теперь для вызова мы можем опустить фигурные скобки и сразу передать замыкание

// MARK: - Автозамыкания + Сбегающие замыкание

// customersInLine равен ["Barry", "Daniella"]
var customerProviders: [() -> String] = []
func collectCustomerProviders(_ customerProvider: @autoclosure @escaping () -> String) {
    customerProviders.append(customerProvider)
}
collectCustomerProviders(customersInLine.remove(at: 0))
collectCustomerProviders(customersInLine.remove(at: 0))

print("Collected \(customerProviders.count) closures.")
// Выведет "Collected 2 closures."
for customerProvider in customerProviders {
    print("Now serving \(customerProvider())!")
}
// Выведет "Now serving Barry!"
// Выведет "Now serving Daniella!"
    


// MARK: - Домашка

//1. Написать функцию, которая ничего не возвращает и принимает только один клоужер, который ничего не принимает и ничего не возвращает . Функция должна просто посчитать от 1 до 10 в цикле и после этого вызвать клоужер. Добавьте println в каждый виток цикла и в клоужер и проследите за очередностью выполнения команд.

print(" task 1")
func task1(_ closure : () -> Void) {
    print("", terminator: " ")
    for i in 1...10 {
        print(i, terminator: " ")
    }
    closure()
}

task1 { print("\n clouser is called") }

//2. Используя метод массивов sorted, отсортируйте массив интов по возрастанию и убыванию. Пример показан в методичке.
print("\n task 2")
let someArray = [1,6,12,6,2,1,6,8,2]
print(" array: \(someArray)")
print(" forward: ", terminator: " ")
print(someArray.sorted { (a: Int, b: Int) -> Bool in return a < b})
print(" backward: ", terminator: " ")
print(someArray.sorted { $0 > $1 })

//3. Напишите функцию, которая принимает массив интов и клоужер и возвращает инт. Клоужер должен принимать 2 инта (один опшинал) и возвращать да или нет. В самой функции создайте опшинал переменную. Вы должны пройтись в цикле по массиву интов и сравнивать элементы с переменной используя клоужер. Если клоужер возвращает да, то вы записываете значение массива в переменную. в конце функции возвращайте переменную. используя этот метод и этот клоужер найдите максимальный и минимальный элементы массива.

print("\n task 3")
func task3(_ array: [Int], _ clouser: (Int?, Int) -> Bool) -> Int {
    var currentInt : Int?
    for value in array {
        if clouser(currentInt, value) {
            currentInt = value
        }
    }
    return currentInt ?? 0
}

/* логика следующая:
1 итерация: сравниваем nil и первый элемент -> в любом случае берем первый элемент
2 итерация: сравниваем первый элемент и второй элемент -> (если условие верно), то меняем current на второй
 ищем минимальный: первый больше второго? значит теперь минимальным будет второй
 ищем максимальный: первый меньше второго? значит теперь максимальным будет второй
...
*/

let nilValue = task3([])        { $0 == nil || $0! > $1 } // nil
let minValue = task3(someArray) { $0 == nil || $0! > $1 }
let maxValue = task3(someArray) { $0 == nil || $0! < $1 }
print(" array: \(someArray) \n minValue: \(minValue) \n maxValue: \(maxValue)")

//4. Проделайте задание №3 но для нахождения минимальной и максимальной буквы из массива букв (соответственно скалярному значению)

print("\n task 4")

let randStr = "abcdefgxyz"
let lettersArray = Array(randStr)
lettersArray

func task4(_ array: [Character], _ clouser: (Character?, Character) -> Bool) -> Character {
    var currentChar : Character?
    for value in array {
        if clouser(currentChar, value) {
            currentChar = value
        }
    }
    return currentChar ?? " "
}

let nilValue2 = task4([])        { $0 == nil || $0! > $1 } // nil
let minLetter = task4(lettersArray) { $0 == nil || $0! > $1 }
print("")
let maxLetter = task4(lettersArray) { $0 == nil || $0! < $1 }

print(" array: \(lettersArray ) \n minLetterStr: \"\(String(minLetter))\" \n maxLetterStr: \"\(String(maxLetter))\"")

//5. Создайте произвольную строку. Преобразуйте ее в массив букв. Используя метод массивов sorted отсортируйте строку так, чтобы вначале шли гласные в алфавитном порядке, потом согласные, потом цифры, а потом символы

print("\n task 5")

let randStr2 = "one two 3 four V"
var lettersArray2 = [Character]()
for letter in randStr2 {
    lettersArray2.append(letter)
}

func checkPriority(_ letter: Character) -> Int {
    switch letter.lowercased() {
        case "a", "e", "i", "o", "u", "y": return 0
        case "b"..."z": return 1
        case "0"..."9": return 2
        default: return 3
    }
}

let sortedArray = lettersArray2.sorted {
    switch (checkPriority($0), checkPriority($1)) {
        case let(x,y) where x < y: return true
        case let(x,y) where x > y: return false
        default: return $0.lowercased() < $1.lowercased()
    }
}
print(" array: \(lettersArray2)")
print(" sorted array: \(sortedArray)")
