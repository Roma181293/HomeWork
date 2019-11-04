
//
//  main.swift
//  ДЗ 11 Топчий Роман iOS 19-2
//
//  Created by Roman Topchii on 28.10.2019.
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
class MyDate {
    var day : Int = 1{
        willSet {
            if newValue > 0 && newValue < 31 {
                self.day = newValue
            }
        }
    }
    var month : Int = 1{
        willSet {
            if newValue > 0 && newValue < 13 {
                self.month = newValue
            }
        }
    }
    var year : Int = 0{
        willSet {
            if newValue >= 0  {
                self.year = newValue
            }
        }
    }

    func setDate(day : Int, month : Int, year : Int) {
        if day > 0 && day < 31 && month > 0 && month < 13 && year > 0 {
            self.day = day
            self.month = month
            self.year = year
        }
        else {
            Swift.print("Некоректный ввод даты")
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

    static func + (date : MyDate, days : Int) -> MyDate{ // увеличивается дата, так как это ссылочный тип, то больше не существует исходной даты в пяамяти

        var daysTmp = days

        if days / 360 >= 1  {
            date.year += days / 360
            daysTmp -= (days / 360) * 360
        }

        if daysTmp / 30 >= 1  {
            date.month += daysTmp / 30
            daysTmp -= (daysTmp / 30) * 300
        }

        if daysTmp < 30   {
            date.day += daysTmp
        }

        return date
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

var date1 = MyDate()
date1.setDate(day: 1, month: 11, year: 1994)
print("date1:")
date1.print()

var date2 = MyDate()
date2.setDate(day: 1, month: 12, year: 1992)
print("date2:")
date2.print()


var d = date1-date2
print("\nРазница дат \(d)")


print("\nУведичение даты на заданое кол-во дней")
var date3 = date1 + 371

date3.print()


print("\nПроверка на равность дат")
if date1 == date1 {
    date1.print()
    date1.print()
    print("Даты равны")
}
else {
    print("даты не равны")
}

print("\nПроверка на неравность дат")
if date1 != date2 {
    date1.print()
    date2.print()
    print("Даты не равны")
}
else {
    date1.print()
    date2.print()
    print("Даты равны")
}

print("\nПроверка date1 > date2")
if date1 > date2 {
    date1.print()
    date2.print()
    print("date1 > date2")
}
else {
    date1.print()
    date2.print()
    print("date1 < date2")
}

print("\nПроверка date1 < date2")
if date2 < date1 {
    date1.print()
    date2.print()
    print("date1 < date2")
}
else {
    date1.print()
    date2.print()
    print("date1 > date2")
}

//MARK:- 11.2
print("""
11.2 (4 балла) Создать класс для работы с матрицами. Предусмотреть, как
минимум, функции для
сложения матриц, (+)
умножения матриц, (*)
транспонирования матриц, (вычисляемое свойство transposed)
присваивания матриц друг другу, (=) ???????????????????????????????????????????????
установка и получение произвольного элемента матрицы. (subscript [ ] )
Необходимо определить соответствующие операторы.\n
""")

class Matrix {
    let rows: Int, columns: Int
    var grid: [Double]
    var transposed : Matrix {
        var a : Matrix = Matrix(rows: columns, columns: rows)
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
    
    
    static func + (a : Matrix, b : Matrix) -> Matrix?{
        if a.rows == b.rows && a.columns == b.columns {
            var sum : Matrix = Matrix(rows: a.rows, columns: a.columns)
            for i in 0..<a.rows{
                for j in 0..<a.columns{
                    
                    sum[i,j] = a[i,j] + b[i,j]
                }
            }
            return sum
        }
        return nil
    }
    
    static func += (a : inout Matrix, b : Matrix){
        if a.rows == b.rows && a.columns == b.columns {
            var sum : Matrix = Matrix(rows: a.rows, columns: a.columns)
            for i in 0..<a.rows{
                for j in 0..<a.columns{
                    
                    sum[i,j] = a[i,j] + b[i,j]
                }
            }
            a = sum
        }
    }
    
    static func - (a : Matrix, b : Matrix) -> Matrix?{
        if a.rows == b.rows && a.columns == b.columns {
            var res : Matrix = Matrix(rows: a.rows, columns: a.columns)
            for i in 0..<a.rows{
                for j in 0..<a.columns{
                    
                    res[i,j] = a[i,j] - b[i,j]
                }
            }
            return res
        }
        return nil
    }
    static func -= (a : inout Matrix, b : Matrix){
        if a.rows == b.rows && a.columns == b.columns {
            var res : Matrix = Matrix(rows: a.rows, columns: a.columns)
            for i in 0..<a.rows{
                for j in 0..<a.columns{
                    
                    res[i,j] = a[i,j] - b[i,j]
                }
            }
            a = res
        }
    }
    
    static func * (a : Matrix, b : Matrix) -> Matrix?{
        if a.rows == b.columns && a.columns == b.rows {
            
            var mult : Matrix = Matrix(rows: a.rows, columns: b.columns)
            for i in 0..<a.rows{
                for j in 0..<b.columns{
                    for k in 0..<a.columns{
                            mult[i,j] += a[i,k] * b[k,j]
                    }
                }
            }
            return mult
        }
        return nil
    }
}



var arr1 = Matrix(rows: 2, columns: 2)
arr1[0,0] = 1
arr1[1,0] = 1
arr1[0,1] = 1
arr1[1,1] = 1
print(arr1.grid)
var arr2 = Matrix(rows: 2, columns: 2)
arr2[0,0] = 2
arr2[1,0] = 2
arr2[0,1] = 2
arr2[1,1] = 2
print(arr2.grid)
var sum = arr1+arr2
var res = arr1-arr2
print("\nsum = \(sum?.grid)")
print("\nres = \(res?.grid)\n")


var arr3 = Matrix(rows: 2, columns: 3)
arr3[0,0] = 1
arr3[1,0] = 1
arr3[0,1] = 1
arr3[1,1] = 1
arr3[0,2] = 1
arr3[1,2] = 1
print(arr3.grid)
var arr4 = Matrix(rows: 3, columns: 2)
arr4[0,0] = 2
arr4[1,0] = 2
arr4[2,0] = 2
arr4[0,1] = 0
arr4[1,1] = 0
arr4[2,1] = 0
print(arr4.grid)

var mult = arr3 * arr4
print("\nmult = \(mult?.grid)")


var arr5 = Matrix(rows: 3, columns: 2)
arr5[0,0] = 1
arr5[1,0] = 2
arr5[2,0] = 3
arr5[0,1] = 4
arr5[1,1] = 5
arr5[2,1] = 6
print(arr5.grid)

var transpArr5 = arr5.transposed
print("\ntransp = \(transpArr5.grid)")

print(transpArr5[1,1])

transpArr5[1,1] = 12345

print(transpArr5[1,1])

var a = arr5

//MARK:- 11.3
print("""
11.3 (4 балла ) Создать класс Point2D, с переменными x,y типа Double.
Создать класс Point3D, который наследуется от Point2D и имеет дополнительную переменную z типа Double.
 
Создать класс Shape c методом myPrint(), который ничего не выводит
 
Создать класс (отрезок) Segment, который наследуется от Shape,
Содержит в себе две точки a,b типа Point2D
Объявить метод length(), который возвращает длину отрезка.
Перегрузить метод myPrint(), Так, чтобы он выводил координаты точек и расстояние между ними.
 
Создать класс Circle, который наследуется от Shape,
Содержит в себе точку center : Point2D, radius: Double.
 
Объявить метод area(), который возвращает площадь круга.
Перегрузить метод myPrint(), Так, чтобы он выводил координаты центра, радиус и площадь.
 
Аналогично классу Segment сделать класс Segment3D, который использует Point3D.
""")

class Point2D {
    var x : Double = 0
    var y : Double = 0
}

class Point3D: Point2D {
    var z : Double = 0
}

class Shape {
    func myPrint() {
        
    }
}

class Segment: Shape {
    var a = Point2D()
    var b = Point2D()
    func length() -> Double {
        return pow((a.x - b.x)*(a.x - b.x)+(a.y - b.y)*(a.y - b.y),1/2)
    }
    override func myPrint() {
        print("A(\(a.x),\(a.y))")
        print("B(\(b.x),\(b.y))")
        print("|AB| = \(length())")
    }
}

class Circle: Shape {
    var center : Point2D = Point2D()
    var radius : Double = 0
    
    func area() -> Double {
        return 3.14 * radius * radius
    }
    
    override func myPrint() {
        print("O(\(center.x),\(center.y))")
        print("R = \(radius)")
        print("Area = \(area())")
    }
}

class Segment3D: Shape {
    var a = Point3D()
    var b = Point3D()
    func length() -> Double {
        return pow((a.x - b.x)*(a.x - b.x) + (a.y - b.y)*(a.y - b.y) + (a.z - b.z)*(a.z - b.z),1/2)
    }
    override func myPrint() {
        print("A(\(a.x),\(a.y),\(a.z))")
        print("B(\(b.x),\(b.y),\(b.z)")
        print("|AB| = \(length())")
    }
}
