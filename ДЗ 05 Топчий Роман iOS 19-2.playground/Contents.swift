import UIKit

/*Выполнил:     Топчий Роман
 Группа:        iOS 19-2
 Дата сдачи:    21.09.2019 */


print("5.1. Найти сумму  элементов, находящихся между первым и последним отрицательными элементами.")
var array = [1,-1,1,1,-1,1,-1,1]
print(array)
var leftIndexOfMin : Int?
var rightIndexOfMin : Int?
for (index, value) in array.enumerated() {
    if value < 0 {
        leftIndexOfMin = index
        break
    }
}

for index in 0..<array.count{
    if array[array.count - 1 - index] < 0 {
        rightIndexOfMin = array.count - 1 - index
        break
    }
}

//print(leftIndexOfMin)
//print(rightIndexOfMin)
var sum = 0
if rightIndexOfMin! > leftIndexOfMin! && leftIndexOfMin != nil && rightIndexOfMin != nil {
    for index in leftIndexOfMin! + 1..<rightIndexOfMin! {
        sum += array[index]
    }
    print("сумма  элементов, находящихся между первым и последним отрицательными элементами = \(sum)\n")
}
else if leftIndexOfMin == nil && rightIndexOfMin == nil {
    print("недостаточное кол-во отрицательных чисел. нет либо правого, либо левого или и правого и левого отрицательного значения")
}


print("5.2. Преобразовать массив так, чтобы сначала шли все отрицательные элементы, а потом положительные(0 считать положительным). (не использовать встроенный remove, insert, append)")
array = [2,8,4,-5,1,-6,0,]
print(array)
var negativeCounter = 0
for (index, value) in array.enumerated() {
    if value < 0 {
        let buf = value
        for j in  0..<index - negativeCounter  {
            array[index-j] = array[index-j-1]
        }
        array[negativeCounter] = buf
        negativeCounter += 1
    }
}
print(array)


print("\n 5.3. Написать программу, определяющую сумму/количество положительных/ отрицательных элементов массива.")
print(array)
var sumOfPositivNumbers = 0
var counterOfPositivNumbers = 0
var sumOfNegativeNumbers = 0
var counterOfNegativeNumbers = 0

for element in array {
    if element < 0 {
        sumOfNegativeNumbers += element
        counterOfNegativeNumbers += 1
    }
    else if element > 0 {
        sumOfPositivNumbers += element
        counterOfPositivNumbers += 1
    }
}
print("Количество положительных элементов = \(counterOfPositivNumbers) \nКоличество отрицательных элементов = \(counterOfNegativeNumbers) \nСумма положительных элементов = \(sumOfPositivNumbers) \nСумма отрицательных элементов = \(sumOfNegativeNumbers) \n")


print("5.4. Сжать массив, удалив из него все 0, и заполнить освободившиеся справа элементы значениями -1. (не использовать встроенный remove, insert, append)")
array = [4,0,2,0,3,4,0,3,4,5,0,0,5]
print(array)
var indexesOfNonZeros = [Int]()
var bufferArray = [Int]()
for (index, value) in array.enumerated() {
    if value != 0 {
      indexesOfNonZeros += [index]
    }
}
for i in indexesOfNonZeros{
    bufferArray += [array[i]]
}
//let arrayOfMinusOne = Array(repeating: -1, count: array.count - bufferArray.count)

array = bufferArray + Array(repeating: -1, count: array.count - bufferArray.count)

//print(indexesOfNonZeros)
//print(bufferArray)
print(array)


print("\n5.5.Написать программу, определяющую сумму элементов массива, находящихся в массиве после первого элемента со значением 0.")
array = [1,1,0,0,1,1,1]

print(array)
var indexOfFirstZero : Int?
sum = 0
for (index,value) in array.enumerated() {
    if value == 0 {
        indexOfFirstZero = index
        //print(indexOfFirstZero)
        break
    }
}
if indexOfFirstZero != nil  {
    for index in indexOfFirstZero! + 1..<array.count {
        sum += array[index]
    }
    print("суммa элементов массива, находящихся в массиве после первого элемента со значением 0 = \(sum)\n")
}
else {
    print("В массиве отсутствует нулевое значение\n")
}


print("5.6. Дан массив случайных чисел в диапазоне от -20 до +20. Необходимо найти позиции крайних отрицательных элементов (самого левого отрицательного элемента и самого правого отрицательного элемента) и отсортировать элементы, находящиеся между ними. ")
var array = [20,-1,18,-3,16,-5,14,-7,12,-9,10,-11,8,-13,6,-14,4,-15,2,-17]
print(array)
var bufferArray = [Int]()
var leftIndex : Int?                   //delete var
var rightIndex : Int?                  //delete var
for (index, value) in array.enumerated() {
    if value < 0 {
        leftIndex = index
        break
    }
}
for index in 0..<array.count{
    if array[array.count - 1 - index] < 0 {
        rightIndex = array.count - 1 - index
        break
    }
}
if leftIndex != nil && rightIndex != nil {
    for i in leftIndex! + 1..<rightIndex! {
        var localMinIndex = i
        var localMin = array[i]
       // print("start - \(i) - \(localMinIndex) - \(localMin)")
        //поиск минимума и его индекса

        for (index, value) in array.enumerated() {
            if index > i && index < rightIndex!  && value < localMin {
                localMin = value
                localMinIndex = index
            }
        }
                for k in 0...localMinIndex-i {
            array[localMinIndex-k] = array[localMinIndex-k-1]
        }        
        array[i] = localMin
       
    }
    print(array)
   
}
else {
    print("Не найдено два отрицательных числа в массиве!")
}




print("\n5.7. Дан массив из 20 целых чисел со значениями от 1 до 20. Необходимо: a) создать случайное число из того же диапазона и найти позицию этого случайного числа в массиве; b) отсортировать элементы массива, находящиеся слева от найденной позиции по убыванию, а элементы массива, находящиеся справа от найденной позиции по возрастанию.")
array = []
for i in 1...20{
    array += [i]
}
print(array)

let randomNumber = Int(arc4random_uniform(20)) + 1
print("Random number \(randomNumber)")

var indexOfRandomNumber : Int = -1
var arrayA = [Int]()
var arrayB = [Int]()

for (index, value) in array.enumerated() {
    if value == randomNumber {
        indexOfRandomNumber = index
    }
}

print("Index Of Random Number \(indexOfRandomNumber)")

for i in 0..<indexOfRandomNumber {
    arrayA += [array[i]]
}
arrayA = arrayA.sorted(by: >)

for i in indexOfRandomNumber + 1..<array.count {
    arrayB += [array[i]]
}
arrayB = arrayB.sorted(by: <)
array = arrayA + [randomNumber] + arrayB

print(array)









