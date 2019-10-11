/*Выполнил:     Топчий Роман
Группа:        iOS 19-2
Дата сдачи:    11.10.2019 */

import Foundation

// MARK: - 8.1
print("8.1.  (2 балла) Написать функцию mySort, которая принимает в качестве параметров:\n1) массив целых чисел\n2) замыкание, которое определяет, направление сортировки.\nВозвращает отсортированный массив.\n")

func mySorted(array: [Int], by compare: (Int, Int) -> Bool)-> [Int] {
    var arr = array
    for _ in 0..<arr.count {
      for i in 0..<arr.count-1 {
        if compare(arr[i], arr[i+1]) {
          let tmp = arr[i]
          arr[i] = arr[i+1]
          arr[i+1] = tmp
        }
      }
    }
    return arr
}

var array = [61,44,81,4,277,50,101,51,8]
print("array        : \(array)")

let sortedArray1 = mySorted(array: array, by: { (first: Int, second: Int) -> Bool in
    return first < second
})
print("sortedArray_1: \(sortedArray1)")


let sortedArray2 = mySorted(array: array, by: { $0 > $1 })
print("sortedArray_2: \(sortedArray2)")




// MARK: - 8.2
print("\n8.2.  (2 балла) Написать функцию myMap, которая принимает в качестве параметров:\n1) массив целых чисел\n2) замыкание, которое определяет, как изменить каждый элемент массива.\nВозвращает массив в котором все элементы изменены согласно замыканию.\n")

func myMap(_ array: [Int], _ condition: (Int) -> Int) -> [Int] {
    var arr : [Int] = []
    for value in array {
        arr.append(condition(value))
    }
    return arr
}

var myArray = [2, 4, 5, 7]
//Вернуть квадраты элементов
var newArray3 = myMap(myArray){ $0*$0 }
print("newArray^2: \(newArray3)")




// MARK: - 8.3
print("\n8.3 (2 балла)  Используя стандартный map() преобразовать массив строк, добавив в конец символ “!” \n[“a”, “asd”, “r”, ”kk”] -> [“a!”, “asd!”, “r!”, ”kk!”]\n")

let a = ["a","asd","r","kk"]
var b = a.map{"\($0)!"}
print("\(a) -> \(b)")


// MARK: - 8.4
print("\n8.4. (2 балла) Пользуясь только функциями filter, map и reduce \nНайдите кол-во элементов целочисленного  массива, которые больше 5 и меньше 20.")
var arrIn = [1,4,6,7,9,23,33]
print("arrIn: \(arrIn)")
var arrOut = arrIn.filter{item in return (item>5 && item<20)}

print("arrOut: \(arrOut)")


// MARK: - 8.5
print("\n8.5 (2 балла) Пользуясь только функциями filter, map и reduce. Найдите сумму нечетных элементов массива и произведение четных элементов массива")
arrIn = [1,-4,6,7]
print("arrIn: \(arrIn)")
let mult = arrIn.filter{$0 % 2 == 0}.reduce(1, {(mult: Int, item: Int) in return mult * item})
print("mult: \(mult)")
let sum = arrIn.filter{$0 % 2 != 0}.reduce(0, {(sum: Int, item: Int) in return sum + item})
print("mult: \(sum)")
