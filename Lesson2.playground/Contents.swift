import UIKit


//записи чисел в различных системах счисления
let decimal = 255           // 10
let binary  = 0b1111_1111   // 2
let oct     = 0o377         // 8
let dex     = 0xff          // 16

13.23e2
1e5


let a = 5
let b = 5.9999
let c = a + Int(b)
let d = Double(a) + b

//Домашка
//1. Выведите в консоль минимальные и максимальные значения базовых типов, не ленитесь

print("Int.min = \(Int.min), Int.max = \(Int.max)")
print("UInt.min = \(UInt.min), UInt.max = \(UInt.max)")

print("Int8.min = \(Int8.min), Int8.max = \(Int8.max)")
print("UInt8.min = \(UInt8.min), UInt8.max = \(UInt8.max)")

print("Int16.min = \(Int16.min), Int16.max = \(Int16.max)")
print("UInt16.min = \(UInt16.min), UInt16.max = \(UInt16.max)")

print("Int32.min = \(Int32.min), Int32.max = \(Int32.max)")
print("UInt32.min = \(UInt32.min), UInt32.max = \(UInt32.max)")

print("Int64.min = \(Int64.min), Int64.max = \(Int64.max)")
print("UInt64.min = \(UInt64.min), UInt64.max = \(UInt64.max)")

let minSystem = Int.min
let maxSystem = Int.max
let min32 = Int32.min
let max32 = Int32.max
let min64 = Int64.min
let max64 = Int64.max

if (minSystem == min32 && maxSystem == max32) { print("Разрядность системы - x32") }
    else if (minSystem == min64 && maxSystem == max64) { print("Разрядность системы - x64") }
    else { print("Разрядность системы - НЕИЗВЕСТНО") }

//2. Создайте 3 константы с типами Int, Float и Double
//Создайте другие 3 константы, тех же типов: Int, Float и Double,
//при чем каждая из них это сумма первых трех, но со своим типом

let x = 1 //let x : Int = 1
let y : Float = 1.2
let z = 2.8 //let z : Double = 2.8

let res1 = Int(Double(x) + Double(y) + z) //let res1 = x + Int(y) + Int(z)
let res2 = Float(x) + y + Float(z)
let res3 = Double(x) + Double(y) + z

print("res1 (Int) = \(res1), res2 (Float) = \(res2), res3 (Double) = \(res3)")

//3. Сравните Int результат суммы с Double и выведите отчет в консоль

if Double(res1) < Double(res2) { print("Double точнее, чем Int!") }
else if(Double(res1) == Double(res2)) { print("Int и Double имеют одинаковую точность!") }
else { print("Int точнее, чем Double!") }

if (Float(res1) < Float(res3)) { print("Float точнее, чем Int!") }
else if(Float(res1) == Float(res3)) { print("Float и Int имеют одинаковую точность!") }
else { print("Int точнее, чем Float!") }

if (Float(res1) < Float(res3)) { print("Float точнее, чем Double!") }
else if(Float(res1) == Float(res3)) { print("Double и Float имеют одинаковую точность!") }
else { print("Double точнее, чем Float!") }
