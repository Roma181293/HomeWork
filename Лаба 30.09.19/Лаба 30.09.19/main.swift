/*Выполнил:     Топчий Роман
Группа:        iOS 19-2
Дата сдачи:    11.10.2019 */


import Foundation

print("Реализовать класс двухсвязаного списка с операциями:\n-init with array \n-isEmpty \n-count \n-insert before \n-append \n-remove \n-removeAll \n-изменить значение найденного узла \n-find by value \n-find by index \n-реализовать протокол Enumerable\n")



class List {
    var head : Node?
    var tail : Node?

    class Node {
        init(_ info: Int) {
            self.info = info
        }
        var info : Int = 0
        var next : Node? = nil
        var prev : Node? = nil
    }

    init() {
        head = nil
        tail = nil
    }
    
    func isEmpty() -> Bool {
        if tail == nil && head == nil {
            return true
        }
        else {
            return false
        }
        
    }
    
    func count() -> Int {
        var pointer = head
        var counter = 0
        while pointer != nil {
            pointer = pointer!.next
            counter += 1
        }
        return counter
    }
    
    func insertBefore(info val : Int, beforeInfo name: Int) {
        
        var currentPointer = head
        while currentPointer?.next != nil && currentPointer?.info != name  {
            currentPointer = currentPointer?.next
        }
        
        let node = Node(val)
        if currentPointer?.info == name && (head === currentPointer) == false {
            node.prev = currentPointer?.prev
            node.next = currentPointer
            currentPointer?.prev?.next = node
            currentPointer?.prev =  node
        }
        else if head === currentPointer {
            head = node
            node.next = currentPointer
            currentPointer?.prev = node
        }
        else {
            print("There is no element with info : \(name)")
        }
    }
    
    func append(_ val: Int) {
        
        if head == nil {
            let node = Node(val)
            node.info = val
            node.next = nil
            node.prev = nil
            head = node
            tail = node
        }
        else {
            let node = Node(val) //1
            node.prev = tail //2
            tail?.next = node //3
            tail = node//4
        }
    }
    
    func remove(info val : Int) {
        
        var currentPointer = head
        while currentPointer?.next != nil && currentPointer?.info != val  {
            currentPointer = currentPointer?.next
        }
        
        if currentPointer?.info == val && (head === currentPointer) == false {
            currentPointer?.next?.prev = currentPointer?.prev
            currentPointer?.prev?.next = currentPointer?.next
        }
         else if head === currentPointer {
            head = currentPointer?.next
            currentPointer?.next = nil
        }
        else {
            print("There is no element with info : \(val)")
        }
    }
    
    func removeAll() {
        head = nil
        tail = nil
    }
    
    func changeValue(of val : Int, to newVal : Int) {
           
           var currentPointer = head
           while currentPointer?.next != nil && currentPointer?.info != val  {
               currentPointer = currentPointer?.next
           }
           
        if currentPointer?.info == val {//&& (head === currentPointer) == false {
             currentPointer?.info = newVal
           }
           else {
               print("There is no element with info : \(val)")
           }
       }
    
    func findByValue(of val : Int) -> Int? {
              
        var currentPointer = head
        var index = 0
        while currentPointer?.next != nil && currentPointer?.info != val  {
            currentPointer = currentPointer?.next
            index += 1
        }
              
        if currentPointer?.info == val {//&& (head === currentPointer) == false {
            return index
        }
        else {
            print("There is no element with info : \(val)")
            return nil
        }
    }
    
    func findByIndex(of findIndex : Int) -> Int? {
              
        var currentPointer = head
        var count = 0
        
        while currentPointer?.next != nil  {
            currentPointer = currentPointer?.next
            count += 1
        }
        
        if findIndex > count || findIndex < 0 {
            return nil
        }
        else {
            var index = 0
            currentPointer = head
            while findIndex != index  {
                currentPointer = currentPointer?.next
                index += 1
            }
            return currentPointer?.info
        }
    }
    
    
    
    
    func printList() {
        var pointer = head
        while pointer != nil {
            print(pointer!.info, terminator: " ")
            pointer = pointer!.next
            
        }
        print()
    }
}

let a = List()
print("Двухсвязный список пуст? - \(a.isEmpty())")
print("Кол-во элементов в списке? - \(a.count())")

a.append(11)
a.printList()

a.append(22)
a.printList()

a.append(33)
a.printList()

a.append(44)
a.printList()

a.append(55)
a.printList()

a.insertBefore(info: 78, beforeInfo: 55)
a.insertBefore(info: 78, beforeInfo: 4353)
a.printList()

a.remove(info: 55)
a.printList()

a.changeValue(of: 44, to: 66)
a.printList()

let val = 78
if let check = a.findByValue(of: val) {
    print("Index on element \(val) - \(check)")
}

let index = 4
if let check = a.findByIndex(of: index) {
    print("Element with index \(index) - \(check)")
}
