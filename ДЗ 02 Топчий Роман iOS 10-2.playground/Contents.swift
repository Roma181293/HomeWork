import UIKit

/*Выполнил:     Топчий Роман
 Группа:        iOS 19-2
 Дата сдачи:    07.09.2019 */

/*2.1 Создать пять строковых констант
Одни константы это только цифры, другие содержат еще и буквы
Найти сумму всех этих констант приведя их к Int
(Используйте и optional binding  и forced unwrapping)*/

let a = 1
let b = 2
let c = "2a"
let d = 6
let e = "a"

var sum : Int = 0
// Опциональное связивание (optional binding)
if let k : Int = Int(a){
    sum += k
}
if let k : Int = Int(b){
    sum += k
}
if let k : Int = Int(c){
    sum += k
}
if let k : Int = Int(d){
    sum += k
}
if let k : Int = Int(e){
    sum += k
}
print("optional binding \(sum)")
sum = 0
//принудительное извлечение (forced unwraping)
 // in process


//Альтернатива 1
let arr : [Any] = [1, 2, "2a", 3.1, "a"]

for element in arr{
    if element is Int {
        
        let new = element as! Int
        sum += new
    }
}
print(sum)
//Альтернатива 2
sum = 0
for case let a as Int in arr {
    sum += a
}
print(sum)








/*2.2. С сервера к нам приходит тюпл с тремя параметрами:
statusCode, message, errorMessage (число, строка и строка)
в этом тюпле statusCode всегда содержит данные, но сама строка приходит только в одном поле
если statusCode от 200 до 300 исключительно, то выводите message,
в противном случает выводите errorMessage
После этого проделайте тоже самое только без участия statusCode */

let result200 = (statusCode : 200, message : "OK", errorMessage : "")
let result404 = (statusCode : 404, message : "", errorMessage : "Not Found")
let resultsArray = [result200, result404]

for result in resultsArray {
    if result.statusCode >= 200 && result.statusCode < 300 {
        print("\(result.statusCode) - \(result.message)")
    }
    else {
        print("\(result.statusCode) - \(result.errorMessage)")
    }
}

for result in resultsArray {
    if result.message != "" {
        print("\(result.statusCode) - \(result.message)")
    }
    else if result.errorMessage != "" {
        print("\(result.statusCode) - \(result.errorMessage)")
    }
}


/*2.3. Создайте 5 тюплов с тремя параметрами:
 имя, номер машины, оценка за контрольную
 при создании этих тюплов не должно быть никаких данных
 после создания каждому студенту установите имя
 некоторым установите номер машины
 некоторым установите результат контрольной
 выведите в консоль:
 - имена студента
 - есть ли у него машина
 - если да, то какой номер
 - был ли на контрольной
 - если да, то какая оценка */

var student1 : (String, Int?, Int?)
var student2 : (String, Int?, Int?)
var student3 : (String, Int?, Int?)
var student4 : (String, Int?, Int?)
var student5 : (String, Int?, Int?)

student1 = ("Nick", 1, 5)
student2 = ("Ann", 6, 2)
student3 = ("Stue", nil, 5)
student4 = ("John", 5, nil)
student5 = ("Robert", nil, nil)

let studentsArray = [student1, student2, student3, student4, student5]
var haveCar : String
var passExam : String
var result : String
for student in studentsArray {
    if student.1 != nil{
        result = "\(student.0) have car № \(student.1!). "
    }
    else{
        result = "\(student.0) dont have car. "
    }
    
    if student.2 != nil{
        result = result + "Took an exam with mark \(student.2!)."
    }
    else{
        result = result + "Dont took an exam."
    }
    print(result)
}


/*2.4 Создайте псевдоним типа String с именем Text .
 Создайте псевдоним для типа (numberOne: Text?, numberTwo: Text?)? с именем TupleType .
 Данный тип является опциональным и также содержит в себе опциональные значения .
 Создайте три переменные типа TupleType, содержащие следующие значения: ("190", "67"), ("100", nil), ("-65", "70").
 Выведите значения элементов тех тюплов, в которых ни один из элементов не инициализирован как nil .
 */


typealias Text = String
typealias TupleType = (numberOne: Text?, numberTwo: Text?)?
var firstVariable : TupleType = ("190", "67")
var secondVariable : TupleType = ("100", nil)
var thirdVariable : TupleType = ("-65", "70")

let array1 = [firstVariable, secondVariable, thirdVariable]
for element in array1 {
    if element!.numberOne != nil && element!.numberTwo != nil {
        print(element!)
    }
}

/*2.5. Выполните задание 2.1.
только вместо forced unwrapping и optional binding используйте оператор ??
Когда посчитаете сумму, то представьте свое выражение в виде строки
Например: 5 + nil + 2 + 3 + nil = 10 */

sum = 0
let optA : Int = Int(a) ?? 0
let optB : Int = Int(b) ?? 0
let optC : Int = Int(c) ?? 0
let optD : Int = Int(d) ?? 0
let optE : Int = Int(e) ?? 0
sum = optA + optB + optC + optD + optE

print("\( a is Int ? "\(a)" : "nil") + \( b is Int ? "\(b)" : "nil") + \( c is Int ? "\(c)" : "nil") + \( d is Int ? "\(d)" : "nil") + \( e is Int ? "\(e)" : "nil") = \(sum)")

print("\( a is Int ? "\(a)" : "nil") + " + "\( b is Int ? "\(b)" : "nil") + " + "\( c is Int ? "\(c)" : "nil") + " + "\( d is Int ? "\(d)" : "nil") + " + "\( e is Int ? "\(e)" : "nil") = " + "\(sum)")


/*2.6. Поиграйтесь с юникодом и создайте строку из 5 самых классных по вашему мнению символов, можно использовать составные символы. Посчитайте длину строки */

let str = "\u{2b14}\u{23f1}\u{2297}\u{e213}\u{2341}"
print(str.count)

/*2.7. Создайте строку английский алфавит, все буквы малые от a до z
задайте константу - один из символов этого алфавита
Используя цикл for определите под каким индексов в строке находится этот символ */

let abc = "abcdefghijklmnopqrtsuvwxyz"
let u : Character = "u"
var index = 0
for character in abc {
    index += 1
    if character == u {
        print("u undex = \(index)")
    }
}
