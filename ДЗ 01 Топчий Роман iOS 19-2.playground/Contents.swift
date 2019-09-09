import UIKit
/*Выполнил:     Топчий Роман
 Группа:        iOS 19-2
 Дата сдачи:    07.09.2019
 
 1.1.1 .  Объявите две пустые целочисленные переменные типов Int8 и Uint8.*/
var firstEmptyInteger : Int8
var secondEmptyInteger : UInt8

//1.1.2 .  В одну из них запишите максимальное значение, которое может принять параметр типа Uint8, в другую — минимальное значение, которое может принять параметр типа Int8. Обратите внимание на то, какое значение в какую переменную может быть записано .
firstEmptyInteger = Int8.min
secondEmptyInteger = UInt8.max

//1.1.3 .  Выведите полученные значения на консоль .
print("Min value of Int8 = \(firstEmptyInteger)")
print("Max value of Uint8 = \(secondEmptyInteger)")

//1.1.4 .  Объявите две целочисленные однотипные переменные, при этом тип данных первой должен быть задан неявно, а второй — явно . Обеим переменным должны быть присвоены значения .
var firstVariable = 4
var secondVariable : Int = 6

//1.1.5 .  Поменяйте значения переменных местами .Для этого вам придется использовать еще одну переменную, которая будет служить буфером .
var thirdVariable = firstVariable
firstVariable = secondVariable
secondVariable = thirdVariable

//1.1.6 .  Выведите получившиеся значения на консоль . При этом в каждом варианте выводимых данных текстом напишите, какую переменную вы выводите .
print("неявно заданая переменная = \(firstVariable)")
print("явно заданая переменная = \(secondVariable)")


//1.2.1 .  Объявите переменные a и b целочисленного типа данных и присвойте им значения 2 и 3.
var a : Int = 2
var b : Int = 3
//1.2.2 .  Вычислите значение выражения (a+4b)(a-3b) +a2 и выведите результат на консоль .
print("(a+4b)(a-3b)+a^2 = \((a + 4 * b)*(a - 3 * b) + a * 2)")
print("(a+4b)(a-3b)+a^2 = \((a + 4 * b)*(a - 3 * b) + a ^ 2)")
//print("(a+4b)(a-3b)+a^2 = \((a + 4 * b)*(a - 3 * b) + Int(pow(Decimal(a),2)))")
print("(a+4b)(a-3b)+a^2 = \((a + 4 * b)*(a - 3 * b))")


//1.3.1 .  Объявите переменную типа String и запишите в нее произвольный строковый литерал .
var stringVariable : String = "My level is "

//1.3.2 .  Объявите константу типа Character, содержащую произвольный символ латинского алфавита .
let chatacterVariable : Character = "A"

//1.3.3 .  Объявите две переменные типа Int и запишите в них произвольные значения .
var firstIntVariable : Int = 0
var secondIntVariable : Int = 1

//1.3.4 .  Одним выражением объедините в строковый литерал переменную типа String, константу типа Character и сумму пере- менных типа Int, а результат запишите в новую константу .
let result : String = "\(stringVariable)\(chatacterVariable)\(firstIntVariable+secondIntVariable)"

//1.3.5 .  Выведите данную константу на консоль .
print(result)


//1.4.1 .  Создайте кортеж с тремя параметрами: ваш любимый фильм, ваше любимое число и ваше любимое блюдо . Все элементы кортежа должны быть именованы .
var firstTuple = (favoritFilm: "Forrest Gump", favoritNumber : 18, favoritDish : "pizza")

//1.4.2 .  Одним выражением запишите каждый элемент кортежа в три константы .
let (firstFilm, firstFavoritNumber, firstFavoritDish) = firstTuple

//1.4.3 .  Создайте второй кортеж, аналогичный первому по параметрам, но описывающий другого человека (с другими значе- ниями) .
var secondTuple = ("Matrix",28,"pasta")

//1.4.4 .  Обменяйте значения в кортежах между собой (с использованием дополнительного промежуточного кортежа) .
let thirdTuple = firstTuple
firstTuple = secondTuple
secondTuple = thirdTuple

//1.4.5 .  Создайте новый кортеж, элементами которого будут любимое число из первого кортежа, любимое число из второго кортежа и разница любимых чисел первого и второго кортежей .
let fourthTuple = (firstTuple.1, secondTuple.1, firstTuple.1 - secondTuple.1)
//print(fourthTuple)



let const : Decimal = 2
let const2 = pow(const,2)
    
