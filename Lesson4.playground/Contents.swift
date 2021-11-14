import UIKit

let apples : Int? = 5

// MARK: - Force unwrapping

if apples == nil { print("nil apples") }
else { _ = apples! + 2 }

// optional banding (можно применять как с if, так и с while)
if var numbersOfApples = apples { numbersOfApples += 2 }
else { print("nil apples") } // else уже необязателен


// Вы можете включать столько опциональных привязок и логических условий в единственную инструкцию if,
// сколько вам требуется, разделяя их запятыми. Если какое-то значение в опциональной привязке равно nil,
// или любое логическое условие вычисляется как false, то все условие выражения будет считаться false

if let firstNumber = Int("4"), let secondNumber = Int("42"), firstNumber < secondNumber && secondNumber < 100 {
    print("\(firstNumber) < \(secondNumber) < 100")
}
// Prints "4 < 42 < 100"

if let firstNumber = Int("4") {
    if let secondNumber = Int("42") {
        if firstNumber < secondNumber && secondNumber < 100 {
            print("\(firstNumber) < \(secondNumber) < 100")
}}}
// Выведет "4 < 42 < 100"



// ОТЛАДКА С ПОМОЩЬЮ УТВЕРЖДЕНИЙ

let age = 1
assert(age >= 0, "Возраст человека не может быть меньше нуля")
// это приведет к вызову утверждения, потому что age >= 0, а указанное значение < 0.
// если значение утверждения false, то приложение остановится
// сообщение об ошибке можно не писать: assert(age >= 0)

// Если код уже проверяет условие, то вы используете функцию assertionFailure(_:file:line:)
// для индикации того, что утверждение не выполнилось
if age > 10 {
    print("Ты можешь покататься на американских горках и чертовом колесе.")
} else if age > 0 {
    print("Ты можешь покататься на чертовом колесе.")
} else {
    assertionFailure("Возраст человека не может быть отрицательным.")
}

// ОТЛАДКА С ПОМОЩЬЮ ПРЕДУСЛОВИЙ

// Используйте предусловие везде, где условие потенциально может получить значение false, но для дальнейшего исполнения
// кода, оно определенно должно равняться true. Например, используйте предусловие для проверки того, что значение
// сабскрипта не вышло за границы диапазона или для проверки того, что в функцию было передано корректное значение.

let index = 1
precondition(index > 0, "Индекс должен быть больше нуля.")








//Домашнее задание:

//1. Создать пять строковых констант
//Одни константы это только цифры, другие содержат еще и буквы
//Найти сумму всех этих констант приведя их к Int
//(Используйте и optional binding и forced unwrapping)

let (one, two, three, four, five) = ("-2","51d","351","4a2","42")
var sum = 0
if let x = Int(one) { sum += x }
if let x = Int(two) { sum += x }
if Int(three) != nil { sum += Int(three)! }
if let x = Int(four) { sum += x }
if let x = Int(five) { sum += x }

//2. С сервера к нам приходит тюпл с тремя параметрами:
//statusCode, message, errorMessage (число, строка и строка)
//в этом тюпле statusCode всегда содержит данные, но сама строка приходит только в одном поле
//если statusCode от 200 до 300 исключительно, то выводите message,
//в противном случает выводите errorMessage
//После этого проделайте тоже самое только без участия statusCode

var serverResponde : (statusCode: Int?, message: String?, errorMessage: String?) = (300 , "All Good", "connection failed")

if let code = serverResponde.statusCode {
    if 200..<300 ~= code {
        if let message = serverResponde.message { print("message from server: \(message)") }
        else { print("message from server: ???") }
    }
    else {
        if let errorMessage = serverResponde.errorMessage { print("error-message from server: \(errorMessage)") }
        else { print("error-message: ???") }
    }
}
else {
    print("statusCode is nil")
    if let message = serverResponde.message {
        print("message from server: \(message)")
    }
    else if let errorMessage = serverResponde.errorMessage {
        print("error-message from server: \(errorMessage)")
    }
    else { print("message and error-message are nil :(") }
}

//3. Создайте 5 тюплов с тремя параметрами: имя, номер машины, оценка за контрольную
//при создании этих тюплов не должно быть никаких данных. после создания КАЖДОМУ студенту установите имя, некоторым установите номер машины, некоторым установите результат контрольной
//выведите в консоль:
//- имена студента
//- есть ли у него машина (если да, то какой номер)
//- был ли на контрольной (если да, то какая оценка)

var student1 : (name: String?, carNumber: String?, markForTest: Int?) = (nil, nil, nil)
var student2 : (name: String?, carNumber: String?, markForTest: Int?) = (nil, nil, nil)
var student3 : (name: String?, carNumber: String?, markForTest: Int?) = (nil, nil, nil)
var student4 : (name: String?, carNumber: String?, markForTest: Int?) = (nil, nil, nil)
var student5 : (name: String?, carNumber: String?, markForTest: Int?) = (nil, nil, nil)

student1.name = "Alex"; student2.name = "Tolya"; student3.name = "Anton"; student4.name = "Daniil"; student5.name = "Nikita"
student1.carNumber = "j241js43"; student3.carNumber = "f251ys43"; student2.markForTest = 5; student5.markForTest = 4

func printInfo (student : (name: String?, carNumber: String?, markForTest: Int?)) {
    if student.name == nil { print("Имя студента не указано!!!") }
    else {
        print("\nStudent Name: \(student.name!)")
        if let carNumber = student.carNumber {
            print("\(student.name!)'s car number is \(carNumber)")
        }
        else { print("\(student.name!) has no car") }
        if let markForTest = student.markForTest {
            print("\(student.name!)'s mark for a test is \(markForTest)")
        }
        else { print("\(student.name!) missed a test") }
    }
}

printInfo(student: student1)
printInfo(student: student2)
printInfo(student: student3)
printInfo(student: student4)
printInfo(student: student5)

