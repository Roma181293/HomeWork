//
//  main.swift
//  ДЗ 12 Топчий Роман iOS 19-2
//
//  Created by Roman Topchii on 03.11.2019.
//  Copyright © 2019 Roman Topchii. All rights reserved.
//

import Foundation


//MARK: - 12.1
print("""
12.1 (2 балла )
* Создать базовый класс Employer (служащий) со свойством name: String и с функцией getDescription(), которая возвращает String.
* Создайте три дочерних класса: President, Manager, Worker. Переопределите функцию getDescription() для вывода информации, соответствующей каждому типу служащего.
* Создать массив var employers: [Employer]. Заполнить его различными служащими.
Распечатать информацию о всех служащих из массива в одном цикле.\n
""")

class Employer {
    var name : String
    
    init(name : String) {
        self.name = name
    }
    
    func getDiscription() -> String {
        return "getDiscription() was called"
    }
}

class President: Employer {
    override func getDiscription() -> String {
        return "\(name) is president"
    }
}

class Manager: Employer {
    override func getDiscription() -> String {
        return "\(name) is manager"
    }
}

class Worker: Employer {
    override func getDiscription() -> String {
        return "\(name) is worker"
    }
}

var employers: [Employer] = []
employers.append(President(name: "Donald"))
employers.append(Manager(name: "Richard"))
employers.append(Manager(name: "Raychal"))
employers.append(Worker(name: "Bob"))
employers.append(Worker(name: "Jhon"))
employers.append(Worker(name: "Sarah"))

for employer in employers {
    print(employer.getDiscription())
}

//MARK: - 12.2
print("""
\n12.2 (2 балла)
* Создайте класс Passport (паспорт), который будет содержать паспортную информацию о гражданине Украины.
* С помощью механизма наследования, реализуйте класс ForeignPassport (загран. паспорт) производный от Passport. Напомним, что загран.паспорт помимо паспортных данных,  содержит данные о визах.
* Сделать вычисляемое свойство только для чтения description, которое возвращает String с паспортными данными
* Создать массив var passports: [Passport]. Заполнить его различными паспортами.
Распечатать информацию о всех паспортах из массива в одном цикле.\n
""")

class Passport {
    var firstName : String
    var lastName : String
    var passportNumber : Int
    init(firstName : String, lastName : String, passportNumber : Int) {
        self.firstName = firstName
        self.lastName = lastName
        self.passportNumber = passportNumber
    }
    final var description : String {
        return "First name : \(firstName)\nLast name : \(lastName)\nPassport number : \(passportNumber)"
    }
}


class ForeignPassport: Passport {
    var visas : [String] = []
//    override var description: String {
//        return super.description + "\nvisas : \(visas)"
//    }
    init(firstName : String, lastName : String, passportNumber : Int, visas : [String]) {
        super.init(firstName: firstName, lastName: lastName, passportNumber: passportNumber)
        self.visas = visas
    }
}

var passports : [Passport] = []
passports.append(Passport(firstName: "Illia", lastName: "Dongauser", passportNumber: 133245))
passports.append(ForeignPassport(firstName: "Kate", lastName: "Slavska", passportNumber: 234121, visas: ["eu","us"]))
passports.append(Passport(firstName: "Jane", lastName: "Sosna", passportNumber: 748329))
passports.append(ForeignPassport(firstName: "Ulyana", lastName: "Smaliy", passportNumber: 372918, visas: ["uae"]))
for passport in passports {
print("___________")
print(passport.description)
}

//MARK: - 12.3.1
print("""
\n12.3.1 (2 балла). Сделать класс Человек, у этого класса будут проперти Папа, Мама, Братья, Сестры (всё опционально). (братья и сестры сделать одним массивом)
Сделать примерно 20 человек, взять одного из них, поставить ему Папу/Маму.
Папе и Маме поставить Пап/Мам/Братьев/Сестер. Получится большое дерево иерархии.
Посчитать, сколько у этого человека двоюродных Братьев, троюродных Сестёр, Теть, Дядь, итд\n
""")

class Animal {
    var name: String
    
    init(name: String = "") {
        self.name = name
    }
    
    func printNoice() {
        print("--- Animal printNoice() ---")
    }
}

class Cat : Animal {
    override func printNoice() {
        print(name, "Myau-myau")
    }
}

class Dog : Animal {
    override func printNoice() {
        print(name, "Gav-gav")
    }
}

class Human {
    var firstName : String
    var lastName : String
    var mam : Human?
    var dad : Human?
    var brothersAndSisters : [Human]
    var pets : [Animal] = []
    init(firstName : String, lastname : String, mam : Human?, dad : Human?, brothersAndSisters : [Human]) {
        self.firstName = firstName
        self.lastName = lastname
        self.mam = mam
        self.dad = dad
        self.brothersAndSisters = brothersAndSisters
    }
   
}


var family : [Human] = []
let nataliyaPotlova = Human(firstName: "Nataliya", lastname: "Potlova", mam: nil, dad: nil, brothersAndSisters: [
    Human(firstName: "Tatiana", lastname: "Jhugan", mam: nil, dad: nil,brothersAndSisters: []),
    Human(firstName: "Olga", lastname: "Bogdan", mam: nil, dad: nil,brothersAndSisters: [])])
family.append(nataliyaPotlova)
let romanPotlov = Human(firstName: "Roman", lastname: "Potlov", mam: nataliyaPotlova, dad: nil, brothersAndSisters: [])
family.append(romanPotlov)
let tanyaPotlova = Human(firstName: "Tanya", lastname: "Potlova", mam: nil, dad: romanPotlov, brothersAndSisters: [])
family.append(tanyaPotlova)
let annaTopchii = Human(firstName: "Anna", lastname: "Topchii", mam: nataliyaPotlova, dad: nil, brothersAndSisters: [romanPotlov])
family.append(annaTopchii)

let sergyTopchii = Human(firstName: "Sergy", lastname: "Topchii", mam: nil, dad: nil, brothersAndSisters: [])
family.append(sergyTopchii)
let alexanderTopchii = Human(firstName: "Alexander", lastname: "Topchii", mam:  Human(firstName: "Tanya", lastname: "Topchii", mam: nil, dad: nil,brothersAndSisters: []), dad: sergyTopchii, brothersAndSisters:[])
family.append(alexanderTopchii)
let artemTopchii = Human(firstName: "Artem", lastname: "Topchii", mam:  Human(firstName: "Tanya", lastname: "Topchii", mam: nil, dad: nil,brothersAndSisters: []), dad: sergyTopchii, brothersAndSisters:[alexanderTopchii])
family.append(artemTopchii)

let olgaMalaya = Human(firstName: "Olga", lastname: "Malaya", mam: nil, dad: nil, brothersAndSisters: [])
family.append(olgaMalaya)
let sergyMalyu = Human(firstName: "Sergy", lastname: "Malyu", mam: olgaMalaya, dad: Human(firstName: "Alexanger", lastname: "Malyu", mam: nil, dad: nil,brothersAndSisters: []), brothersAndSisters: [])
family.append(sergyMalyu)
let alexTopchii = Human(firstName: "Alex", lastname: "Topchi", mam: nil, dad: nil, brothersAndSisters: [olgaMalaya,sergyTopchii])
family.append(alexTopchii)

let kateTopchii = Human(firstName: "Kate", lastname: "Topchii", mam: annaTopchii, dad: alexTopchii, brothersAndSisters: [])
family.append(kateTopchii)


let romanTopchii = Human(firstName: "Roman", lastname: "Topchii", mam: annaTopchii, dad: alexTopchii, brothersAndSisters: [kateTopchii])
family.append(romanTopchii)
    



if let a = romanTopchii.mam?.brothersAndSisters.count, let b = romanTopchii.dad?.brothersAndSisters.count {
    let untAndUncle = a + b
    print("untAndUncle : \(untAndUncle)")
}


var secondBrosAndSisters = 0
for elem in family {
    if let a = romanTopchii.mam?.brothersAndSisters {
        for item in a {
            if item.firstName == elem.dad?.firstName && item.lastName == elem.dad?.lastName || item.firstName == elem.mam?.firstName && item.lastName == elem.mam?.lastName{
                secondBrosAndSisters += 1
            }
        }
    }
    if let a = romanTopchii.dad?.brothersAndSisters {
        for item in a {
            if item.firstName == elem.dad?.firstName && item.lastName == elem.dad?.lastName || item.firstName == elem.mam?.firstName && item.lastName == elem.mam?.lastName{
                secondBrosAndSisters += 1
            }
        }
        
    }
}
print("second bro and sister : \(secondBrosAndSisters)")

//MARK: - 12.3.2
print("""
\n12.3.2 (2 балла) Все сестры, матери,... должны быть класса Женщина, Папы, братья,... класса Мужчины.
У Мужчин сделать метод Двигать_диван, у Женщин Дать_указание (двигать_диван). Всё должно работать как и ранее.
Всех этих людей положить в массив Семья, пройти по массиву посчитать количество Мужчин и Женщин, для каждого Мужчины вызвать метод Двигать_диван, для каждой женщины Дать_указание.\n
""")



class Men: Human {
    func moveSofa() -> String {
        return "I'm men. I can move sofa"
    }
}

class Women: Human {
    func askMoveSofa() -> String {
        return "I'm women. I can ask men move sofa"
    }
}


var family2 : [Human] = []
let nataliyaPotlova2 = Women(firstName: "Nataliya", lastname: "Potlova", mam: nil, dad: nil, brothersAndSisters: [
    Women(firstName: "Tatiana", lastname: "Jhugan", mam: nil, dad: nil,brothersAndSisters: []),
    Women(firstName: "Olga", lastname: "Bogdan", mam: nil, dad: nil,brothersAndSisters: [])])
family2.append(nataliyaPotlova2)
let romanPotlov2 = Men(firstName: "Roman", lastname: "Potlov", mam: nataliyaPotlova, dad: nil, brothersAndSisters: [])
family2.append(romanPotlov2)
let tanyaPotlova2 = Women(firstName: "Tanya", lastname: "Potlova", mam: nil, dad: romanPotlov, brothersAndSisters: [])
family2.append(tanyaPotlova2)
let annaTopchii2 = Women(firstName: "Anna", lastname: "Topchii", mam: nataliyaPotlova, dad: nil, brothersAndSisters: [romanPotlov])
family2.append(annaTopchii2)

let sergyTopchii2 = Men(firstName: "Sergy", lastname: "Topchii", mam: nil, dad: nil, brothersAndSisters: [])
family2.append(sergyTopchii2)
let alexanderTopchii2 = Men(firstName: "Alexander", lastname: "Topchii", mam:  Women(firstName: "Tanya", lastname: "Topchii", mam: nil, dad: nil,brothersAndSisters: []), dad: sergyTopchii, brothersAndSisters:[])
family2.append(alexanderTopchii2)
let artemTopchii2 = Men(firstName: "Artem", lastname: "Topchii", mam:  Women(firstName: "Tanya", lastname: "Topchii", mam: nil, dad: nil,brothersAndSisters: []), dad: sergyTopchii, brothersAndSisters:[alexanderTopchii2])
family2.append(artemTopchii2)

let olgaMalaya2 = Women(firstName: "Olga", lastname: "Malaya", mam: nil, dad: nil, brothersAndSisters: [])
family2.append(olgaMalaya2)
let sergyMalyu2 = Men(firstName: "Sergy", lastname: "Malyu", mam: olgaMalaya, dad: Men(firstName: "Alexanger", lastname: "Malyu", mam: nil, dad: nil,brothersAndSisters: []), brothersAndSisters: [])
family2.append(sergyMalyu2)
let alexTopchii2 = Men(firstName: "Alex", lastname: "Topchi", mam: nil, dad: nil, brothersAndSisters: [olgaMalaya,sergyTopchii])
family2.append(alexTopchii2)

let kateTopchii2 = Women(firstName: "Kate", lastname: "Topchii", mam: annaTopchii, dad: alexTopchii, brothersAndSisters: [])
family2.append(kateTopchii2)


let romanTopchii2 = Men(firstName: "Roman", lastname: "Topchii", mam: annaTopchii, dad: alexTopchii, brothersAndSisters: [kateTopchii])
family2.append(romanTopchii2)


var menCount = 0
var womenCount = 0
for prsn in family2 {
    if let men = prsn as? Men {
        menCount += 1
        print("\(men.firstName) \(men.lastName) \(men.moveSofa())")
    }
    if let women = prsn as? Women {
        womenCount += 1
        print("\(women.firstName) \(women.lastName) \(women.askMoveSofa())")
    }
}

print("В семье мужчин \(menCount) и женщин \(womenCount)")



//MARK: - 12.3.2
print("""
\n12.3.3 (2 балла). Расширить класс человек, у него будет проперти Домашние_животные.
Животные могут быть разные (попугаи, кошки, собаки...) их может быть несколько, может и не быть вообще.
Раздать некоторым людям домашних животных. Пройти по всему массиву людей.
Проверить каждого человека на наличие питомца, если такой есть - добавлять всех животных в массив животных.
Посчитать сколько каких животных в этом массиве.
Вся эта живность должна быть унаследована от класса Животные. У всех животных должен быть метод Издать_звук(крик) и у каждого дочернего класса этот метод переопределён на свой, т.е. каждое животное издаёт свой звук.
Когда проходим по массиву животных, каждый представитель вида животных должен издать свой звук.\n
""")

kateTopchii.pets = [Dog(name: "Chak")]
annaTopchii.pets = [Dog(name: "Alisa"), Cat(name: "Rude")]
nataliyaPotlova.pets = [Dog(name: "Mukhtar")]


for item in family {
    if item.pets.isEmpty == false {
        for pet in item.pets {
            pet.printNoice()
        }
    }
}














//MARK: - 12.доп
print("""
\n12.доп Создать протокол с обязательной функцией - корни уравнения.
Создать производные классы: класс линейных уравнений и класс квадратных уравнений. Определить функцию вычисления корней уравнений.
Сделать демонстрационный пример, показывающий работу этих функций.
Плюсом будет если проверку работы этих функций сделаете с помощью юнит тестов.
""")

protocol EquationProtocol {
    func solveEquation()
}

class LinearEquatuion : EquationProtocol {
    var a : Double
    var b : Double = 0
    //ax+b=0
    init(a : Double, b : Double){
        self.a = a
        self.b = b
    }
    func solveEquation() {
        var str = "Equation \(a)x+\(b)=0 has "
        if a == 0 && b != 0{
            str += "no solution"
        }
        else if a == 0 && b == 0 {
            str += "infinity number of solution"
        }
        else {
            str += "a solution x=\(-b/a) "
        }
        print(str)
    }
}

class QuadraticEquation : EquationProtocol {
    var a : Double
    var b : Double
    var c : Double
    //ax^2+bx+c=0
    init(a : Double, b : Double, c : Double){
        self.a = a
        self.b = b
        self.c = c
    }
    func solveEquation() {
        var str = "Equation \(a)x^2+\(b)x+\(c)=0 has "

        if a == 0 && b == 0 && c == 0{
            str += "infinity number of solution"
        }
        else if b * b - 4 * a * c < 0 {
            str += "a solution x1=\(-b / (2 * a) + sqrt(-(b * b - 4 * a * c))/(2*a))i, x2=\(-b / (2 * a) - sqrt(-(b * b - 4 * a * c))/(2*a))i"
        }
        else if b * b - 4 * a * c > 0 {
            str += "a solution x1=\(-b / (2 * a) + sqrt(b * b - 4 * a * c)/(2*a)), x2=\(-b / (2 * a) + sqrt(b * b - 4 * a * c)/(2*a))"
        }
        else if b * b - 4 * a * c == 0 {
            str += "a solution x1=\(-b / (2 * a) + sqrt(b * b - 4 * a * c)/(2*a))"
        }
    }
}

