import UIKit

// Кортежи (Tuples, тюплы)

let sampleTuple : (Int, Double, String, Bool) = (1, 2.2, "hello", true)

let (number1, number2, word, boolean) = sampleTuple
number1
number2
word
boolean

let (_, _, word2, _) = sampleTuple
word2

sampleTuple.0
sampleTuple.1
sampleTuple.2
sampleTuple.3

var sampleTuple2 = (height: 170, weight: 70, name: "Alex", isMale:true)
sampleTuple2.0
sampleTuple2.height

sampleTuple2.height = 171
sampleTuple2.height

// Упрощение записи объявления переменных
let x1 = 1
let y1 = 2
let z1 = 3
let (x2,y2,z2) = (1,2,3)
x2
y2
z2


//Домашка:

//1. Создать тюпл с тремя параметрами: максимальное количество отжиманий, подтягиваний, приседаний
//Заполните его своими достижениями. Распечатайте его через print()

var homeworkTuple = (maxPushUps: 20, maxPullUps: 3, maxSquats: 25)
print(homeworkTuple)

//2. Также сделайте три отдельных вывода в консоль для каждого параметра
//При том одни значения доставайте по индексу, а другие по параметру

print("Максимальное количество отжиманий: \(homeworkTuple.0)")
print("Максимальное количество подтягиваний: \(homeworkTuple.maxPullUps)")
print("Максимальное количество приседаний: \(homeworkTuple.maxSquats)")

//3. Создайте такой же тюпл для другого человека (супруги или друга)
//с такими же параметрами, но с другими значениями
//Используйте промежуточную переменную чтобы поменять соответствующие значения первого тюпла на значения второго

var homeworkTuple2 = (maxPushUps: 10, maxPullUps: 5, maxSquats: 30)
var tempTuple = homeworkTuple2
homeworkTuple2 = homeworkTuple
homeworkTuple = tempTuple

//4. Создайте третий тюпл с теми же параметрами, но значения это разница
//между соответствующими значениями первого и второго тюплов
//Результат выведите в консоль

let differenceTuple = (maxPushUps: homeworkTuple.0-homeworkTuple2.0,
                       maxPullUps: homeworkTuple.1-homeworkTuple2.1,
                       maxSquats: homeworkTuple.2-homeworkTuple2.2)
print(differenceTuple)
