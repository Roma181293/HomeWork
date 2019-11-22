//
//  main.swift
//  ДЗ 15 Топчий Роман iOS 19-2
//
//  Created by Roman Topchii on 19.11.2019.
//  Copyright © 2019 Roman Topchii. All rights reserved.
//

import Foundation

print("""
Создать класс Family (семья), который содержит ссылки на маму, папу, массив детей.

В семье создать маму, папу, 2 детей (сильными ссылками). У каждого человека должно быть имя.

У класса мама:
1) создать метод childrenGoToSleep(), который вызывает метод goToSleep() у каждого ребенка;
2) создать метод husbandBuyBoots(), который вызывает метод buyBoots() у папы;

У класса папа:
1) создать метод childrenGoToSleep(), который вызывает метод goToSleep() у каждого ребенка;
2) создать метод wifeCookMeat(), который вызывает метод cookMeat() у мамы;

У класса ребенок:
1) создать метод letsPlayFootbal(), который вызывает метод playFootbal() у каждого ребенка;
2) создать метод momCookMeat(), который вызывает метод cookMeat() у мамы;

Создать семью  (экземпляр класса Family)
Вызвать все эти методы для демонстрации.

Для каждого класса создать счетчик живых объектов и выводить на экран количество живых экземпляров в init и deinit.

После демонстрации удалить экземпляр семья.
После удаления семьи не должно остаться ни одного живого объекта.
""")


class Mother {
    var name : String
    weak var husband : Father?
    var children : [Child] = []
    
    static var objectCounter : Int = 0
    
    init(name : String) {
        self.name = name
        Mother.objectCounter += 1
    }
    
    func childrenGoToSleep() {
        print("-Mom: Children, go to sleep!!!")
        for child in children {
            child.goToSleep()
        }
    }
    func husbandBuyBoots(){
        print("-Mom: Husband, buy me this boots!!!")
        husband?.buyBoots()
    }
    func cookMeat(){
        print("-Mom: I'm cooking the meat")
    }
    
    deinit {
        print("\(name) - deinited")
        Mother.objectCounter -= 1
    }
}

class Father {
    var name : String
    weak var wife : Mother?
    var children : [Child] = []
    
    static var objectCounter : Int = 0
    
    init(name : String) {
        self.name = name
        Father.objectCounter += 1
    }
    func childrenGoToSleep() {
        print("-Father: Children, go to sleep!!!")
        for child in children {
            child.goToSleep()
        }
    }
    func wifeCookMeat() {
        print("-Father: Wife, lets start cook the meat!!!")
        wife?.cookMeat()
    }
    func buyBoots() {
        print("-Father: I'm buying the boots")
    }
    
    deinit {
        print("\(name) - deinited")
        Father.objectCounter -= 1
    }
}

class Child {
    var name : String
    
    weak var mother : Mother?
    weak var father : Father?
    
    static var objectCounter : Int = 0
    
    init(name : String) {
        self.name = name
        Child.objectCounter += 1
    }
    func letsPlayFootbal(){
        print("-\(name): Lets play football")
        if let mom = mother{
            for index in 0..<mom.children.count {
                if !(mom.children[index] === self) {
                    mom.children[index].playFootbal(name: name)
                }
            }
        }
    }
    func goToSleep(){
        print("-\(name): Im going to sleep")
    }
    func playFootbal(name : String){
        print("-\(self.name): Ok, \(name), lets play")
    }
    func momCookMeat(){
        print("-\(name): Mom, please cook a meat")
        mother?.cookMeat()
    }

    deinit {
        print("\(name) - deinited")
        Child.objectCounter -= 1
    }
}



class Family {
    var mother : Mother?
    var father : Father?
    var children : [Child] = []
    
    static var objectCounter : Int = 0
    init(){
        Family.objectCounter += 1
    }
    deinit {
        print("Family - deinited")
        Family.objectCounter -= 1
    }
}



var family : Family! = Family()

print("\nSTART\nMother.objectCounter:\(Mother.objectCounter)")
print("Father.objectCounter:\(Father.objectCounter)")
print("Child.objectCounter:\(Child.objectCounter)")

family.mother = Mother(name: "Anna")
family.father = Father(name: "Alex")
family.children = [Child(name: "Roma"), Child(name : "Kate")]

print("\nMIDDLE\nMother.objectCounter:\(Mother.objectCounter)")
print("Father.objectCounter:\(Father.objectCounter)")
print("Child.objectCounter:\(Child.objectCounter)")

family.mother?.husband = family.father
family.father?.wife = family.mother

family.mother?.children = family.children
family.father?.children = family.children


for i in 0..<family.children.count {
    family.children[i].father = family.father
    family.children[i].mother = family.mother
}

family.mother?.childrenGoToSleep()
family.father?.childrenGoToSleep()

family.father?.wifeCookMeat()
family.mother?.husbandBuyBoots()

family.children[0].momCookMeat()
family.children[1].momCookMeat()

for i in 0..<family.children.count {
    family.children[i].letsPlayFootbal()
}
family = nil


print("\nFINISH\nMother.objectCounter:\(Mother.objectCounter)")
print("Father.objectCounter:\(Father.objectCounter)")
print("Child.objectCounter:\(Child.objectCounter)")
print("Family.objectCounter:\(Child.objectCounter)")







