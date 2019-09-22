import UIKit


/*Выполнил:     Топчий Роман
 Группа:        iOS 19-2
 Дата сдачи:    21.09.2019 */

//4.1 Вывести на экран таблицу Пифагора. (без использования массивов, только с помощью вложенных циклов. Можно использовать временную переменную типа String)

print("4.1. Вывести на экран таблицу Пифагора. (без использования массивов, только с помощью вложенных циклов. Можно использовать временную переменную типа String)")
for i  in 1...10 {
    var column = ""
    for j  in 1...10 {
            column += String(format: "%4zd",i*j)
    }
    print(column)
}


//4.2 Найдите сумму нечетных элементов массива и произведение четных элементов массива

print("\n4.2. Найдите сумму нечетных элементов массива и произведение четных элементов массива")
//var array1 = [Int]()
//for _ in 0...9{
//    array1.append(Int(arc4random()/1000000))
//}

var array1 = [-1, 0,-2,-3,4,5,6,7,8,90]
print(array1)

var sum = 0
var mult = 1
for (_, value) in array1.enumerated(){
    
    if value%2 == 0{
        sum += value
    }
    else{
        mult *= value
    }
}
print("Сумма нечетных элементов массива = \(sum)")
print("Произведение четных элементов массива = \(mult)\n")

//4.3 Поменяйте местами элементы массива (первый с последним, второй с предпоследним и т.д.)
print("\n4.3. Поменяйте местами элементы массива (первый с последним, второй с предпоследним и т.д.)")
print(array1)
for i in 0...((array1.count - 1) / 2) {
    let buffer = array1[i]
    array1[i] = array1[array1.count - i - 1]
    array1[array1.count - i - 1] = buffer
}
print(array1)
print("")

//4.4 Найдите минимальный положительный элемент массива
print("\n4.4. Найдите минимальный положительный элемент массива")
var array3 = [-3,-5,-3,2,6]
print(array3)
var indexOfMinValue = 0
var positiveTicker = false
var minValue = array1[indexOfMinValue]
for (index, value) in array3.enumerated() {
    if value > 0 && value < minValue {
        minValue = value
        indexOfMinValue = index
        positiveTicker = true
    }
}
if positiveTicker == true {
print("Index of min value = \(indexOfMinValue), min value = \(minValue) \n")
} else {
    print("There is no positive number")
}

//4.5 Найдите кол-во элементов массива, которые больше 5 и меньше 20. Выведите их на экран.
print("\n4.5. Найдите кол-во элементов массива, которые больше 5 и меньше 20. Выведите их на экран.")
print(array1)
var counter = 0
for (index, value) in array1.enumerated() {
    if value > 5 && value < 20 {
        counter += 1
        print("\(index) - \(value)")
    }
}
print("Кол-во элементов массива, которые больше 5 и меньше 20 = \(counter)")


//4.Доп.1. Если в данном массиве действительных чисел а1,...,аn есть хотя бы один член, меньший чем -2,то все отрицательные члены заменить их квадратами.

print("\n4.Доп.1. Если в данном массиве действительных чисел а1,...,аn есть хотя бы один член, меньший чем -2,то все отрицательные члены заменить их квадратами.")
print(array1)
var min = array1[0]
for (_, value) in array1.enumerated(){
    if value < min {
        min = value
    }
}


if min < -2 {
    for (index, value) in array1.enumerated(){
        if value < 0 {
            array1[index] = value*value
        }
    }
}
print(array1)
print("")


//4.Доп.2. Дан массив целых чисел a1,...,an. Найти количество и сумму тех членов массива а1,..,аn,которые делятся на 5 и не делятся на 7. Выдать эти члены массива на экран.
print("\n4.Доп.2. Дан массив целых чисел a1,...,an. Найти количество и сумму тех членов массива а1,..,аn,которые делятся на 5 и не делятся на 7. Выдать эти члены массива на экран.")
var array2 = [3, 2, 5, 15, 25, 45, 35, 70, 14]
print(array2)
counter = 0
sum = 0
for (index, value) in array2.enumerated() {
    if value%5 == 0 && value%7 != 0 {
        print("\(index) - \(value)")
        counter += 1
        sum += value
    }
}
print("количество членов массива а1,..,аn,которые делятся на 5 и не делятся на 7  = \(counter)")
print("сумму тех членов массива а1,..,аn,которые делятся на 5 и не делятся на 7 = \(sum)")
