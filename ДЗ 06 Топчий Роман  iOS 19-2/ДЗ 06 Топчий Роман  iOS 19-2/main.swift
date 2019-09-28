import Foundation

/*Выполнил:     Топчий Роман
Группа:        iOS 19-2
Дата сдачи:    28.09.2019 */


print("6.1. Создайте пару функций с короткими именами, которые возвращают строку с классным символом или символами. Например heart() возвращает сердце и т.п. Вызовите все эти функции внутри принта для вывода строки этих символов путем конкатенации.")


func men() -> String {
    return "🧑"
}
func mac() -> String {
    return "💻"
}
func manOnMac() -> String {
    return "👨‍💻"
}
print(men() + mac() + manOnMac())


print("\n6.2. Написать функцию которая: принимает массив целых чисел, возвращает  минимальный положительный элемент массива (Int). Если такого элемента не найдено, то возвращает nil ")

func minPositiveNumberFinder(_ array : [Int]) -> Int? {
    if array.isEmpty {
        return nil
    }
    else {
        var min : Int = array[0]
        var positiveTicker : Bool = false
        for element in array {
            if element <= min && element > 0 {
                min = element
                positiveTicker = true
            }
        }
        if positiveTicker == true {
            return min
        }
        else {
            return nil
        }
    }
    
}
var array : [Int] = [1,-4,2,5,4]
print("in \(array)")

if let a = minPositiveNumberFinder(array) {
    print("Min positive number = \(a)")
}
else{
    print("There is no positive number")
}



print("\n6.3. Написать функцию которая: принимает массив целых чисел, возвращает  опциональный кортеж содержащий минимальный положительный элемент массива и его индекс (index: Int, value: Int)? . Если такого элемента не найдено, то возвращает nil")

func minFinder(_ array : [Int]) -> (index: Int, value: Int)?  {
    var returnValue : (index: Int, value: Int)?

    if array.isEmpty == false {
      
        var positiveTicker : Bool = false
        var min = ((index: 0, value: array[0]))
        
        for (index, value) in array.enumerated() {
            if value <= min.value && value > 0 {
                min.value = value
                min.index = index
                positiveTicker = true
            }
        }
        if positiveTicker == true {
            returnValue = min
        }
    }
    return returnValue
}


print("in \(array)")

if let a = minFinder(array) {
    print("Min positive number = \(a)")
}
else{
    print("There is no positive number")
}



print("\n6.4. Написать функцию которая: принимает массив целых чисел, возвращает  кортеж (tuple) содержащий минимальный положительный элемент массива и его индекс (index: Int?, value: Int?). Если такого элемента не найдено, то возвращает кортеж, значения в котором равны nil.")

func minFinder2(_ array : [Int]) -> (index: Int?, value: Int?)  {
    var returnValue : (index: Int?, value: Int?)

    if array.isEmpty == false {
        for (index, value) in array.enumerated() {
            if value > 0 {
                returnValue.value = value
                returnValue.index = index
                break
            }
        }
        if let _ = returnValue.index, let minValue = returnValue.value {
            for (index, value) in array.enumerated() {
                if value > 0 && value < minValue {
                    returnValue.value = value
                    returnValue.index = index
                }
            }
        }
        
    }
    return returnValue
}

var array12 = [-3, 1, -4, 2, 5, 4]
print("in \(array12)")

if let index = minFinder2(array12).index, let value = minFinder2(array12).value {
    print("Min positive number = (index: \(index), value: \(value))")
}
else{
    print("There is no positive number")
}


print("\n6.5.1. Создайте функцию, которая принимает массив, а возвращает массив в обратном порядке.")

func reverseArray(_ array : [Int]) -> [Int] {
    if array.isEmpty { return array}
    else {
        var arr = [Int]()
        for index in 0...array.count-1 {
            arr.append(array[array.count-1 - index])
        }
        return arr
    }
}
print("in \(array)")
print("revers array \(reverseArray(array))")


print("\n6.5.2. Используя  inout  выполните задание номер 6.4 так, чтобы функция не возвращала перевернутый массив, но меняла элементы в существующем. Что будет если убрать inout?")

func reverseArray2(_ array : inout [Int]) {
    if array.isEmpty { }
    else {
        //var arr = [Int]()
        for index in 0...array.count/2 {
            let buf = array[index]
            array[index] = array[array.count-1-index]
            array[array.count-1-index] = buf
            
        }
    }
}
print("in \(array)")
reverseArray2(&array)
print("revers array \(array)")
print("Что будет если убрать inout?\nwarning:\"Cannot assign through subscript: 'array' is a 'let' constant\"")


print("\n6.6. Создайте функцию, которая принимает два массива ar1 и ar2. Возвращает массив в котором элементы Х[i] состоят из суммы элементов входящих массивов поэлементно. Размер массива Х должен быть равен наибольшему размеру из ar1 и ar2")

func arraySum(_ array1: [Int], _ array2: [Int]) -> [Int] {
    var arr1 = array1
    var arr2 = array2
    var x = [Int]()
    if array1.count > array2.count {
        arr2 = arr2 + Array(repeating: 0, count: array1.count - array2.count)
    }
    else {
        arr1 = arr1 + Array(repeating: 0, count: array2.count - array1.count)
    }
    
    for i in 0..<arr2.count {
        x.append(arr1[i]+arr2[i])
    }
    
    return x
}
let array1 = [1,3,5]
let array2 = [1,4,2,7,4,2]
print("array1 = \(array1)\narray2 = \(array2)\nsum = \(arraySum(array1, array2))")

