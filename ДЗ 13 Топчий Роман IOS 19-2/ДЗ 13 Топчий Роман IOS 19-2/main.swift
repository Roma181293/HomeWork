//
//  main.swift
//  ДЗ 13 Топчий Роман IOS 19-2
//
//  Created by Roman Topchii on 11.11.2019.
//  Copyright © 2019 Roman Topchii. All rights reserved.
//

import Foundation

print("""
Создать протоколы:
CarProtocol
Содержит свойство model: String
Содержит свойство readonly maxCountOfPassengers: Int
Содержит свойство  currentCountOfPassengers: Int

AmbulanceCarProtocol: CarProtocol
Содержит свойство readonly maxCountOfPatients: Int


PersonProtocol
Содержит свойство name: String
Содержит свойство age: Int

DriverProtocol
Содержит функцию drive(from: String,   to: String, onCar: CarProtocol)
Содержит свойство категория (A,B,C,...)  driveCategory: String

DoctorProtocol
Содержит функцию givePill(patient: PersonProtocol)
Содержит свойство специализация specialization: String

OrderProtocol
Содержит свойство readonly tripDescription: String

—-  Создать классы:
Person: PersonProtocol

TaxiCar: CarProtocol

AmbulanceCar : AmbulanceCarProtocol

Doctor: PersonProtocol, DoctorProtocol

Driver: PersonProtocol, DriverProtocol

—————————--

class TaxiOrder: OrderProtocol
Содержит свойство car: CarProtocol
Содержит свойство driver: DriverProtocol
Содержит свойство passengers: [PersonProtocol]

Содержит проваливающийся инициализатор init?(car, driver, passengers, from, to)
Создавать поездку (TaxiOrder)  в том случае, если количество пассажиров не превышает максимально допустимое для конкретного автомобиля.
Иначе возвращать nil


class AmbulanceOrder: OrderProtocol
Содержит свойство car: AmbulanceCarProtocol
Содержит свойство driver: DriverProtocol
Содержит свойство doctor: DoctorProtocol
Содержит свойство (сопровождающие) passengers: [PersonProtocol]
Содержит свойство patients: [PersonProtocol]


Содержит проваливающийся инициализатор
init?(car, driver, patients, doctor, passengers, from, to)
Создавать поездку (AmbulanceOrder)  в том случае, если:
- количество пассажиров не превышает максимально допустимое для конкретного автомобиля.
- количество пациентов не превышает максимально допустимое для конкретного автомобиля.
- есть хотя бы один пациент

Иначе возвращать nil

——————————————
Создать автомобиль для такси
Попытаться создать три различных поездки на такси.
Причем по одной должны получить отказ из-за большого количества пассажиров.

Создать автомобиль скорой помощи.
Попытаться Создать три различных поездки на скорой помощи.
По одной должны получить отказ из-за большого количества пассажиров.
По одной должны получить отказ из-за того, что нет пациентов.
В этом случае создать TaxiOrder и отправить всех пассажиров с доктором в машине скорой помощи. (Т.е. Создать не срочный вызов, а просто поездку, как на такси используя автомобиль скорой помощи)

Все получившиеся поездки записать в список поездок orderList: [OrderProtocol].
Рсапечатать список поездок на экран используя свойство tripDescription
""")





protocol CarProtocol {
    var model: String {get set}
    var maxCountOfPassengers: Int {get}
    var currentCountOfPassengers: Int {get set}
}
protocol AmbulanceCarProtocol: CarProtocol {
    var maxCountOfPatients: Int {get}
}
protocol PersonProtocol {
    var name: String {get set}
    var age: Int {get set}
}
protocol DriverProtocol {
    func drive(from: String,   to: String, onCar: CarProtocol)
    var driveCategory: String {get set}
}
protocol DoctorProtocol {
    func givePill(patient: PersonProtocol)
    var specialization: String {get set}
}
protocol OrderProtocol{
    var tripDescription: String {get}
}




class Person: PersonProtocol{
    var name: String
    var age: Int
    init(name : String, age : Int) {
        self.name = name
        self.age = age
    }
    
}

class TaxiCar: CarProtocol{
    var model: String
    var maxCountOfPassengers: Int
    var currentCountOfPassengers: Int
    init(model: String, maxCountOfPassengers: Int, currentCountOfPassengers: Int) {
        self.model = model
        self.maxCountOfPassengers = maxCountOfPassengers
        self.currentCountOfPassengers = currentCountOfPassengers
    }
    
}

class AmbulanceCar : AmbulanceCarProtocol{
    var maxCountOfPatients: Int
    var model: String
    var maxCountOfPassengers: Int
    var currentCountOfPassengers: Int
    init(maxCountOfPatients: Int, model: String, maxCountOfPassengers: Int, currentCountOfPassengers: Int) {
        self.maxCountOfPatients = maxCountOfPatients
        self.model = model
        self.maxCountOfPassengers = maxCountOfPassengers
        self.currentCountOfPassengers = currentCountOfPassengers
    }
    
}

class Doctor: PersonProtocol, DoctorProtocol{
    var name: String
    var age: Int
    func givePill(patient: PersonProtocol) {
        
    }
    var specialization: String
    init(name : String, age : Int, specialization : String) {
        self.name = name
        self.age = age
        self.specialization = specialization
    }
    
}

class Driver: PersonProtocol, DriverProtocol{
    var name: String
    var age: Int
    func drive(from: String, to: String, onCar: CarProtocol) {
        print("I can drive car")
    }
    var driveCategory: String
    init(name : String, age : Int, driveCategory : String) {
        self.name = name
        self.age = age
        self.driveCategory = driveCategory
    }
    
}


print("""
class TaxiOrder: OrderProtocol
Содержит свойство car: CarProtocol
Содержит свойство driver: DriverProtocol
Содержит свойство passengers: [PersonProtocol]

Содержит проваливающийся инициализатор init?(car, driver, passengers, from, to)
Создавать поездку (TaxiOrder)  в том случае, если количество пассажиров не превышает максимально допустимое для конкретного автомобиля.
Иначе возвращать nil
""")

class TaxiOrder: OrderProtocol {
    var car: CarProtocol
    var driver: DriverProtocol
    var passengers: [PersonProtocol]
    var tripDescription: String
    
    init? (car : CarProtocol, driver : DriverProtocol, passengers : [PersonProtocol], from : String, to: String){
        if passengers.count < car.maxCountOfPassengers {
            self.car = car
            self.driver = driver
            self.passengers = passengers
            tripDescription = "From \(from) to \(to)"
        }
        else {
            return nil
        }
    }
}


var orderList = [TaxiOrder(car: TaxiCar(model: "BMW X5", maxCountOfPassengers: 4, currentCountOfPassengers: 0), driver: Driver(name: "Alex", age: 25, driveCategory: "B"), passengers: [Person(name: "Anna", age: 23), Person(name: "Hanna", age: 25)], from: "Korolenko", to: "Haharina"),
                 
 TaxiOrder(car: TaxiCar(model: "BMW X5", maxCountOfPassengers: 4, currentCountOfPassengers: 0), driver: Driver(name: "Alex", age: 25, driveCategory: "B"), passengers: [Person(name: "Anna", age: 23), Person(name: "Tina", age: 23),Person(name: "Kate", age: 23), Person(name: "Hanna", age: 25)], from: "Korolenko", to: "Haharina")
]

for order in orderList {
    if let tmp = order {
        print(tmp.driver.driveCategory)
    }
    else {
        print("Oops")
    }
}


print("""
class AmbulanceOrder: OrderProtocol
Содержит свойство car: AmbulanceCarProtocol
Содержит свойство driver: DriverProtocol
Содержит свойство doctor: DoctorProtocol
Содержит свойство (сопровождающие) passengers: [PersonProtocol]
Содержит свойство patients: [PersonProtocol]


Содержит проваливающийся инициализатор
init?(car, driver, patients, doctor, passengers, from, to)
Создавать поездку (AmbulanceOrder)  в том случае, если:
- количество пассажиров не превышает максимально допустимое для конкретного автомобиля.
- количество пациентов не превышает максимально допустимое для конкретного автомобиля.
- есть хотя бы один пациент

Иначе возвращать nil
""")

class AmbulanceOrder: OrderProtocol {
    
    
    var car: AmbulanceCarProtocol
    var driver: DriverProtocol
    var doctor: DoctorProtocol
    var passengers: [PersonProtocol] = []
    var patients: [PersonProtocol] = []
    var tripDescription: String
    init?(car : AmbulanceCarProtocol, driver : DriverProtocol, patients : [PersonProtocol], doctor : DoctorProtocol, passengers : [PersonProtocol], from : String, to : String) {
        if passengers.count < car.maxCountOfPassengers - 1 &&
            patients.count > 0 &&
            patients.count < car.maxCountOfPatients {
            self.car = car
            self.driver = driver
            self.patients = patients
            self.doctor = doctor
            self.passengers = passengers
            tripDescription = "From " + from + " to " + to
        }
        else {
            return nil
        }
    }

}
