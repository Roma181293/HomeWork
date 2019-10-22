//
//  main.swift
//  HW 10 Roman Topchii iOS 19-2 Socoban
//
//  Created by Roman Topchii on 17.10.2019.
//  Copyright © 2019 Roman Topchii. All rights reserved.
//

import Foundation

enum Direction {
    case left, right, up, down
}

enum Object {
    case player, box, wall, destination, emptySpace
}

class Player {
    var x : Int = 1
    var y : Int = 2
}

//class Box {
//    var x : Int = 1
//    var y : Int = 1
//}
//
//class Destination {
//    var x : Int = 9
//    var y : Int = 9
//}

class Room {
    var width : Int = 10
    var height : Int = 10
}

class Game {
    var room : Room = Room()
    var player : Player = Player()
    var boxes : Set<[Int]> = []
    var destinations : Set<[Int]> = []
    var walls : Set<[Int]> = []
    var room_2 : [[Object]] = []
    
    

    func roomToArray() {
        room_2 = []
        for y in 0..<room.height {
            var row : [Object] = []
            for x in 0..<room.width {
                
                var cell : Object = .emptySpace
                
                if destinations.isEmpty == false{
                    for destination in destinations{
                        if destination[0] == x && destination[1] == y {
                            cell = .destination
                        }
                    }
                }
                if boxes.isEmpty == false{
                    for box in boxes{
                        if box[0] == x && box[1] == y {
                            cell = .box
                        }
                    }
                }
                if walls.isEmpty == false {
                    for wall in walls{
                        if wall[0] == x && wall[1] == y {
                            cell = .wall
                        }
                    }
                }
                if player.x == x && player.y == y {
                    cell = .player
                }
                row.append(cell)
            }
            room_2.append(row)
        }
        //print(room_2)
    }
    
    
    func roomToString() -> String {
         var area: String = ""
               for row in room_2 {
                    for cell in row {
                    switch cell {
                    case .box:
                        area.append("📦")
                    case .player:
                        area.append("🏃‍♂️")
                    case .wall:
                        area.append("🚧")
                    case .destination:
                        area.append("❎")
                    case .emptySpace:
                        area.append("⬜️")
                    }
                   }
                   area.append("\n")
               }
               return area
    }
    
    
    
    func canMove(direction : Direction) -> Bool {
        var canMove = true
        if gameOver(box: boxes, destination: destinations) {
            canMove = false
        }
        switch direction {
        case .left:
            if room_2[player.y][player.x - 1] == .wall || (room_2[player.y][player.x - 1] == .box && room_2[player.y][player.x - 2] == .wall) || (room_2[player.y][player.x - 1] == .box && room_2[player.y][player.x - 2] == .box)  {
                canMove = false
            }
        case .right:
            if room_2[player.y][player.x + 1] == .wall || (room_2[player.y][player.x + 1] == .box && room_2[player.y][player.x + 2] == .wall)  || (room_2[player.y][player.x + 1] == .box && room_2[player.y][player.x + 2] == .box) {
                canMove = false
            }
        case .up:
            if room_2[player.y - 1][player.x] == .wall || (room_2[player.y - 1][player.x] == .box && room_2[player.y - 2][player.x] == .wall) || (room_2[player.y - 1][player.x] == .box && room_2[player.y - 2][player.x] == .box)  {
                canMove = false
            }
        case .down:
            if room_2[player.y + 1][player.x] == .wall || (room_2[player.y + 1][player.x] == .box && room_2[player.y + 2][player.x] == .wall) || (room_2[player.y + 1][player.x] == .box && room_2[player.y + 2][player.x] == .box)  {
                canMove = false
            }
        }
        return canMove
    }
    
    
    func move(to direction: Direction) {
        switch direction {
            case .left:
                if canMove(direction: .left){
                    player.x -= 1
                    if boxes.contains([player.x, player.y]){//player.x == box.x && player.y == box.y {
                        boxes.remove([player.x, player.y])
                        let tmp : [Int] = [player.x-1, player.y]
                        boxes = boxes.union([tmp])
                        //print(boxes)
                    }
                }
                
            case .right:
                if canMove(direction: .right){
                    player.x += 1
                    if boxes.contains([player.x, player.y]){
                        boxes.remove([player.x, player.y])
                        let tmp : [Int] = [player.x+1, player.y]
                        boxes = boxes.union([tmp])
                        //print(boxes)
                    }
                }
            case .up:
                if canMove(direction: .up){
                    player.y -= 1
                    if boxes.contains([player.x, player.y]){
                        boxes.remove([player.x, player.y])
                        let tmp : [Int] = [player.x, player.y-1]
                        boxes = boxes.union([tmp])
                        //print(boxes)
                    }
                }
            case .down:
                if canMove(direction: .down){
                    player.y += 1
                 if boxes.contains([player.x, player.y]){
                        boxes.remove([player.x, player.y])
                        let tmp : [Int] = [player.x, player.y+1]
                        boxes = boxes.union([tmp])
                        //print(boxes)
                    }
                }
        }
        roomToArray()
        
    }
    
    func gameOver(box : Set<[Int]>, destination : Set<[Int]>) ->  Bool {
        if destination == box {
            return  true
        }
        else {
            return false
        }
    }
    
    func restart()  {
        boxes = []
        destinations = []
        walls = []
        room_2 = []
    }
    
    
    func readRoomString(level : Int) {
        var roomString = ""
        switch level {
        case 1:
            roomString = "xxxxxxxxxx\nx........x\nxxx...+..x\nx...*....x\nx..*...+.x\nx..xxxx..x\nx..$.....x\nx........x\nxxxxxxxxxx"
        case 2:
            roomString = "..xxxxxx\n..x.++.x\n..x..*.x\n..xx.xxx\n...x.x..\n...x.x..\nxxxx.x..\nx...$xx.\nx.x.*.x.\nx...x.x.\nxxx...x.\n..xxxxx."
        case 3:
            roomString = "xxxxxxxx...\nx..x...x...\nx...*..x...\nx.*xx.xxxxx\nxx.x+.xx..x\n.x.x+...*.x\n.x.x+.xx..x\n.x.x+xxx.xx\n.x$...xx..x\n.xx.*.....x\n..xxxxxx..x\n.......xxxx"
        default:
            roomString = "xxxxxxxxxx\nx........x\nxxx...+..x\nx...*....x\nx..*...+.x\nx..xxxx..x\nx..$.....x\nx........x\nxxxxxxxxxx"
        }
       
        //print(roomString)
            
        var rowCounter = 0
        var columnCounter = 0
        room.height = 0
        room.width = 0
    
        for char in roomString {
            switch char {
            case "$":
                player.x = columnCounter
                player.y = rowCounter
                columnCounter += 1
                room.width = max(room.width,columnCounter)
            case "+":
                let tmp = [columnCounter,rowCounter]
                destinations = destinations.union([tmp])
                columnCounter += 1
                room.width = max(room.width,columnCounter)
            case "*":
                let tmp = [columnCounter,rowCounter]
                boxes = boxes.union([tmp])
                columnCounter += 1
                room.width = max(room.width,columnCounter)
            case "x":
                let tmp = [columnCounter,rowCounter]
                walls = walls.union([tmp])
                columnCounter += 1
                room.width = max(room.width,columnCounter)
            case "\n":
                rowCounter += 1
                room.height = max(room.height,rowCounter)+1
                columnCounter = 0
            default:
                columnCounter += 1
            }
        }
//            print(player.x, player.y)
//            print(box.x, box.y)
//            print(destination.x, destination.y)
//            print(walls)
//         print("room.width = \(room.width), room.height = \(room.height)")
//
    }
}


