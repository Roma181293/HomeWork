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


var a = date1-date2
print("\nРазница дат \(a)")


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
