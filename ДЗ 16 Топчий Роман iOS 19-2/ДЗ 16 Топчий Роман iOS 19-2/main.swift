//
//  main.swift
//  ДЗ 16 Топчий Роман iOS 19-2
//
//  Created by Roman Topchii on 25.11.2019.
//  Copyright © 2019 Roman Topchii. All rights reserved.
//

import Foundation

//MARK:- 11.1
print("""
11.1 (3 балла) Создайте класс MyDate, который будет содержать информацию о дате (день, месяц, год).
1. Сделать функцию установки даты setDate(day: Int, month: Int, year: Int).
С помощью механизма перегрузки операторов, определите операции (К каждой
операции сделать демонстрационный пример):
2. Operator “ - “   - разность двух дат (результат в виде количества дней между датами),
    Operator “ + “   - операцию увеличения даты на определенное количество дней.
3. Сравнения ==, !=, >, <\n
""")
class MyDate{
    enum DateError : Error {
        case incorrectDay, incorrectMonth, incorrectYear
    }
    var day : Int = 1
    var month : Int = 1
    var year : Int = 0
    
    
    func setDate(day : Int, month : Int, year : Int) throws {
        if day > 0 && day < 31 && month > 0 && month < 13 && year > 0 {
            self.day = day
            self.month = month
            self.year = year
        }
        else if day < 0 || day > 31{
            throw DateError.incorrectDay
        }
        else if month < 1 || month > 12{
            throw DateError.incorrectMonth
        }
        else if year < 0{
            throw DateError.incorrectYear
        }
    }
    
    func print() {
        Swift.print("\(day)/\(month)/\(year)")
    }
    
    
    static func - (date1 : MyDate, date2 : MyDate) -> Int{
        var days : Int = 0
        var months : Int = 0
        var years : Int = 0
        
        if date1.day - date2.day > 0 {
            days += date1.day - date2.day
        }
        else {
            days += date1.day - date2.day + 30
        }
        //        Swift.print(days)
        if date1.month - date2.month > 1 {
            months += date1.month - date2.month - 1
        }
        else {
            months += date1.month - date2.month + 11
        }
        //        Swift.print(months)
        
        if date1.year - date2.year > 0 {
            years += date1.year - date2.year - 1
        }
        //        Swift.print(years)
        return days + months*30 + years*30*12
    }
    
    static func + (date : MyDate, days : Int) throws -> MyDate{
        
        var daysTmp = days
        let dateTmp : MyDate = MyDate()
        do {
            try dateTmp.setDate(day: date.day, month: date.month, year: date.year)
        }
        catch DateError.incorrectDay{
            throw DateError.incorrectDay
        }
        catch DateError.incorrectMonth{
            throw DateError.incorrectMonth
        }
        catch DateError.incorrectYear{
            throw DateError.incorrectYear
        }
        
        if daysTmp / 360 >= 1  {
            dateTmp.year += daysTmp / 360
            daysTmp -= (daysTmp / 360) * 360
        }
        
        if daysTmp / 30 >= 1  {
            if date.month + daysTmp / 30 > 12 {
                dateTmp.year += 1
                dateTmp.month = daysTmp/30 - (12 - date.month)
                daysTmp -= (daysTmp / 30) * 30
            }
            else {
                dateTmp.month += daysTmp / 30
                daysTmp -= (daysTmp / 30) * 30
            }
        }
        
        if daysTmp < 30   {
            if date.day + daysTmp  > 30 {
                dateTmp.month += 1
                dateTmp.day = daysTmp - (30 - date.day)
                daysTmp -= (daysTmp / 30) * 30
            }
            else {
                dateTmp.day += daysTmp
            }
        }
        
        return dateTmp
    }
    
    static func == (date1 : MyDate, date2 : MyDate) -> Bool {
        if date1.day == date2.day && date1.month == date2.month && date1.year == date2.year {
            return true
        }
        else {
            return false
        }
    }
    
    
    static func != (date1 : MyDate, date2 : MyDate) -> Bool {
        if date1.day != date2.day || date1.month != date2.month || date1.year != date2.year {
            return true
        }
        else {
            return false
        }
    }
    
    static func > (date1 : MyDate, date2 : MyDate) -> Bool {
        if (date1.day > date2.day && date1.month >= date2.month && date1.year >= date2.year) || (date1.month >= date2.month && date1.year >= date2.year) || date1.year > date2.year {
            return true
        }
        else {
            return false
        }
    }
    
    static func < (date1 : MyDate, date2 : MyDate) -> Bool {
        if (date1.day < date2.day && date1.month <= date2.month && date1.year <= date2.year) || (date1.month <= date2.month && date1.year <= date2.year) || date1.year < date2.year {
            return true
        }
        else {
            return false
        }
    }
    
    
}

extension MyDate : CustomStringConvertible{
    var description: String{
        return "\(day)/\(month)/\(year)"
    }
}


func sortGeneric<T>(_ array: inout [T], compareClosure: (T,T)->Bool) -> [T]{
    for _ in 0..<array.count {
        for i in 0..<array.count-1 {
            if compareClosure(array[i], array[i+1]) {
                let tmp = array[i]
                array[i] = array[i+1]
                array[i+1] = tmp
            }
        }
    }
    return array
}



var a1 = MyDate()
do {
    try a1.setDate(day: 1, month: 4, year: 1009)
}
catch {
    print("Error : \(error)")
}

var b = MyDate()
do {
    try b.setDate(day: 1, month: 4, year: 10042)
}
catch {
    print("Error : \(error)")
}

var c = MyDate()
do {
    try c.setDate(day: 1, month: 4, year: 6)
}
catch {
    print("Error : \(error)")
}

var timeArray = [a1,b,c]
for date in timeArray {
    print(date.description)
}

var timeArray2 = sortGeneric(&timeArray, compareClosure : {$0>$1})


print(timeArray2)






//MARK:- 11.2
print("""
11.2 (4 балла) Создать класс для работы с матрицами. Предусмотреть, как
минимум, функции для
сложения матриц, (+)
умножения матриц, (*)
транспонирования матриц, (вычисляемое свойство transposed)
установка и получение произвольного элемента матрицы. (subscript [ ] )
Необходимо определить соответствующие операторы.\n
""")



class Matrix {
    enum MatrixError : Error {
        case matrixesHasDifferentDimensions, numberOfColumnInFirstMatrixNotEqualNumberOfRowsInSecond
    }

    let rows: Int, columns: Int
    var grid: [Double]
    var transposed : Matrix {
        let a : Matrix = Matrix(rows: columns, columns: rows)
        var pointer = 0
        for i in 0..<rows {
            for j in 0..<columns {
                a[j,i] = grid[pointer]
                pointer += 1
            }
        }
        return a
    }
    init(rows: Int, columns: Int) {
        self.rows = rows
        self.columns = columns
        grid = Array(repeating: 0.0, count: rows * columns)
    }
    func indexIsValid(row: Int, column: Int) -> Bool {
        return row >= 0 && row < rows && column >= 0 && column < columns
    }
    subscript(row: Int, column: Int) -> Double {
        get {
            assert(indexIsValid(row: row, column: column), "Index out of range")
            return grid[(row * columns) + column]
        }
        set {
            assert(indexIsValid(row: row, column: column), "Index out of range")
            grid[(row * columns) + column] = newValue
        }
    }
    
    
    static func + (a : Matrix, b : Matrix) throws -> Matrix{
        if a.rows == b.rows && a.columns == b.columns {
            let sum : Matrix = Matrix(rows: a.rows, columns: a.columns)
            for i in 0..<a.rows{
                for j in 0..<a.columns{
                    sum[i,j] = a[i,j] + b[i,j]
                }
            }
            return sum
        }
        throw MatrixError.matrixesHasDifferentDimensions
    }
    
    static func += (a : inout Matrix, b : Matrix) throws{
        if a.rows == b.rows && a.columns == b.columns {
            let sum : Matrix = Matrix(rows: a.rows, columns: a.columns)
            for i in 0..<a.rows{
                for j in 0..<a.columns{
                    sum[i,j] = a[i,j] + b[i,j]
                }
            }
            a = sum
        }
        throw MatrixError.matrixesHasDifferentDimensions
    }
    
    static func - (a : Matrix, b : Matrix) throws -> Matrix{
        if a.rows == b.rows && a.columns == b.columns {
            let res : Matrix = Matrix(rows: a.rows, columns: a.columns)
            for i in 0..<a.rows{
                for j in 0..<a.columns{
                    res[i,j] = a[i,j] - b[i,j]
                }
            }
            return res
        }
        throw MatrixError.matrixesHasDifferentDimensions
    }
    static func -= (a : inout Matrix, b : Matrix) throws{
        if a.rows == b.rows && a.columns == b.columns {
            let res : Matrix = Matrix(rows: a.rows, columns: a.columns)
            for i in 0..<a.rows{
                for j in 0..<a.columns{
                    res[i,j] = a[i,j] - b[i,j]
                }
            }
            a = res
        }
        throw MatrixError.matrixesHasDifferentDimensions
    }
    
    static func * (a : Matrix, b : Matrix) throws -> Matrix{
        if a.rows == b.columns && a.columns == b.rows {
            
            let mult : Matrix = Matrix(rows: a.rows, columns: b.columns)
            for i in 0..<a.rows{
                for j in 0..<b.columns{
                    for k in 0..<a.columns{
                        mult[i,j] += a[i,k] * b[k,j]
                    }
                }
            }
            return mult
        }
        throw MatrixError.numberOfColumnInFirstMatrixNotEqualNumberOfRowsInSecond
    }
}

extension Matrix : CustomStringConvertible{
    var description: String{
        var str = "["
        for (index,value) in grid.enumerated() {
            if index == rows*columns-1{
                str += "\(value)"
            } else if (index+1)%rows == 0 && (index != 0 || index != rows*columns){
                str += "\(value)\n"
            }
            else {
                str += "\(value)  "
            }
        }
        str += "]\n"
        return str
    }
}

var arr1 = Matrix(rows: 2, columns: 2)
arr1[0,0] = 1
arr1[1,0] = 1
arr1[0,1] = 1
arr1[1,1] = 1
print("arr1 = \n\(arr1)")
var arr11 = Matrix(rows: 2, columns: 3)
arr11[0,0] = 1
arr11[1,0] = 1
arr11[0,1] = 1
arr11[1,1] = 1
arr11[0,2] = 1
arr11[1,2] = 1
print("arr11 = \n\(arr11)")
var arr2 = Matrix(rows: 2, columns: 2)
arr2[0,0] = 2
arr2[1,0] = 2
arr2[0,1] = 2
arr2[1,1] = 2
print("arr2 = \n\(arr2)")

var sum : Matrix
var sumErrorr : Matrix
do {
    try sum = arr1+arr2
    print("\nsum =\n\(sum)")
    try sumErrorr = arr1 + arr11
      print("\nsum =\n\(sumErrorr)")
}
catch Matrix.MatrixError.matrixesHasDifferentDimensions {
    print("matrixes has different dimensions")
}
catch {
    print("unknown error \(error)")
}




var res : Matrix
var resErrorr : Matrix
do {
    try res = arr1-arr2
    print("\nres =\n\(res)\n")
    try resErrorr = arr1 - arr11
    print("\nres =\n\(resErrorr)")
}
catch Matrix.MatrixError.matrixesHasDifferentDimensions {
    print("matrixes has different dimensions")
}
catch {
    print("unknown error \(error)")
}




var arr3 = Matrix(rows: 2, columns: 3)
arr3[0,0] = 1
arr3[1,0] = 1
arr3[0,1] = 1
arr3[1,1] = 1
arr3[0,2] = 1
arr3[1,2] = 1
print("arr3 = \n\(arr3)")
var arr4 = Matrix(rows: 3, columns: 2)
arr4[0,0] = 2
arr4[1,0] = 2
arr4[2,0] = 2
arr4[0,1] = 0
arr4[1,1] = 0
arr4[2,1] = 0
print("arr4 = \n\(arr4)")

var mult : Matrix
var multErrorr : Matrix
do {
    try mult = arr3 * arr4
    print("\nmult =\n\(mult)")
    try multErrorr = arr1 * arr4
    print("\nmult =\n\(multErrorr)")
}
catch Matrix.MatrixError.numberOfColumnInFirstMatrixNotEqualNumberOfRowsInSecond {
    print("number Of Column In First Matrix Not Equal Number Of Rows In Second")
}
catch {
    print("unknown error \(error)")
}



var arr5 = Matrix(rows: 3, columns: 2)
arr5[0,0] = 1
arr5[1,0] = 2
arr5[2,0] = 3
arr5[0,1] = 4
arr5[1,1] = 5
arr5[2,1] = 6
print("arr5 = \n\(arr5)")

var transpArr5 = arr5.transposed
print("transp = \n\(transpArr5)")
