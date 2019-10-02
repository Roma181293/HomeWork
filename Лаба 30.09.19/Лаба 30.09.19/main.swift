//
//  main.swift
//  Лаба 30.09.19
//
//  Created by Roman on 9/30/19.
//  Copyright © 2019 RomanTopchii. All rights reserved.
//

import Foundation

print("Hello, World!")





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
    
    func isEmpty() -> Bool {
        if tail == nil && head == nil {
            return true
        }
        else {
            return false
        }
        
    }
    
    func removeAll() {
        head = nil
        tail = nil
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
        var prevPointer = head
        while currentPointer?.next != nil && currentPointer?.info != name  {
            prevPointer = currentPointer
            currentPointer = currentPointer?.next
           
        }
        let node = Node(val)
        if currentPointer?.info == name {
                       
//                       currentPointer?.prev =  node
//                       prevPointer?.next = node
//                       node.prev = prevPointer
//                       node.next = currentPointer
            
            node.prev = currentPointer?.prev
            node.next = currentPointer
            currentPointer?.prev?.next = node
            currentPointer?.prev =  node
            
        }
        else if currentPointer?.info == name && currentPointer?.prev == nil{
            node.next = currentPointer
            currentPointer?.prev = node
            head = node
        }
        else {
            print("There is no element with info:\(name)")
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
print(a.isEmpty())
a.append(11)
a.append(22)
a.append(33)
a.append(44)
a.append(55)



a.insertBefore(info: 3456, beforeInfo: 11)
a.printList()
