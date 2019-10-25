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
struct Point2D {
    var x,y : Int
}

class Game {
    
    var width : Int = 0
    var height : Int = 0
    
    var player : Player = Player()
    
    var room : [[Object]] = []
    
    
     //заполняет массив комната и координаты положения играка
    func readRoomString(level : Int) {
        var roomString = ""
            switch level {
        case 1:
            roomString = """
            xxxxxxxxxx
            x........x
            xxx......x
            x...*....x
            x......+.x
            x..xx....x
            x..$.....x
            x........x
            xxxxxxxxxx
            """
        case 2:
            roomString = """
            ..xxxxxx
            ..x.++.x
            ..x..*.x
            ..xx.xxx
            ...x.x..
            ...x.x..
            xxxx.x..
            x...$xx.
            x.x.*.x.
            x...x.x.
            xxx...x.
            ..xxxxx.
            """
        case 3:
            roomString = """
            xxxxxxxx...
            x..x...x...
            x...*..x...
            x.*xx.xxxxx
            xx.x+.xx..x
            .x.x+...*.x
            .x.x+.xx..x
            .x.x+xxx.xx
            .x$...xx..x
            .xx.*.....x
            ..xxxxxx..x
            .......xxxx
            """
        default:
            roomString = """
            xxxxxxxxxx
            x........x
            xxx......x
            x...*....x
            x......+.x
            x..xx....x
            x..$.....x
            x........x
            xxxxxxxxxx
            """
        }
        var rowCounter = 0
        var columnCounter = 0
        height = 0
        width = 0
        var row : [Object] = []
    
        for char in roomString {
            switch char {
            case "$":
                player.x = columnCounter
                player.y = rowCounter
                row.append(.emptySpace)
                columnCounter += 1
                width = max(width,columnCounter)
            case "+":
                row.append(.destination)
                columnCounter += 1
                width = max(width,columnCounter)
            case "*":
                row.append(.box)
                columnCounter += 1
                width = max(width,columnCounter)
            case "x":
                row.append(.wall)
                columnCounter += 1
                width = max(width,columnCounter)
            case ".":
                row.append(.emptySpace)
                columnCounter += 1
                width = max(width,columnCounter)
            case "\n":
                room.append(row)
                row = []
                rowCounter += 1
                height = max(height,rowCounter)+1
                columnCounter = 0
            default:
                columnCounter += 1
            }
        }
        room.append(row)
        row = []
    }
  
    
    func roomToString() -> String {
       
        var tempRoom = room
        tempRoom[player.y].remove(at: player.x)
        tempRoom[player.y].insert(.player, at: player.x)
         var area: String = ""
               for row in tempRoom {
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
        
//        if gameOver(box: boxes, destination: destinations) {
//            canMove = false
//        }
        
        switch direction {
        case .left:
            if room[player.y][player.x - 1] == .wall || (room[player.y][player.x - 1] == .box && room[player.y][player.x - 2] == .wall) || (room[player.y][player.x - 1] == .box && room[player.y][player.x - 2] == .box)  {
                canMove = false
            }
        case .right:
            if room[player.y][player.x + 1] == .wall || (room[player.y][player.x + 1] == .box && room[player.y][player.x + 2] == .wall)  || (room[player.y][player.x + 1] == .box && room[player.y][player.x + 2] == .box) {
                canMove = false
            }
        case .up:
            if room[player.y - 1][player.x] == .wall || (room[player.y - 1][player.x] == .box && room[player.y - 2][player.x] == .wall) || (room[player.y - 1][player.x] == .box && room[player.y - 2][player.x] == .box)  {
                canMove = false
            }
        case .down:
            if room[player.y + 1][player.x] == .wall || (room[player.y + 1][player.x] == .box && room[player.y + 2][player.x] == .wall) || (room[player.y + 1][player.x] == .box && room[player.y + 2][player.x] == .box)  {
                canMove = false
            }
        }
        print(canMove)
        return canMove
    }
    
    
    func move(to direction: Direction) {
        switch direction {
            case .left:
                if canMove(direction: .left){
                    player.x -= 1
                    if room[player.y][player.x] == .box && room[player.y][player.x-1] != .destination {
                        room[player.y][player.x] = .emptySpace
                        room[player.y][player.x-1] = .box
                    }
                    else if room[player.y][player.x] == .box && room[player.y][player.x-1] == .destination {
                        room[player.y][player.x-1] = .destination
                    }
                }
                
            case .right:
                if canMove(direction: .right){
                    player.x += 1
                    if room[player.y][player.x] == .box  && room[player.y][player.x+1] != .destination{
                        room[player.y][player.x] = .emptySpace
                        room[player.y][player.x+1] = .box
                    }
                    else if room[player.y][player.x] == .box && room[player.y][player.x+1] == .destination {
                        room[player.y][player.x+1] = .destination
                    }
                }
            case .up:
                if canMove(direction: .up){
                    player.y -= 1
                    if room[player.y][player.x] == .box {
                        room[player.y][player.x] = .emptySpace
                        room[player.y-1][player.x] = .box
                    }
                }
            case .down:
                if canMove(direction: .down){
                    player.y += 1
                    if room[player.y][player.x] == .box {
                        room[player.y][player.x] = .emptySpace
                        room[player.y+1][player.x] = .box
                    }
                }
        }
        
        
    }
    
//    func gameOver(box : Set<[Int]>, destination : Set<[Int]>) ->  Bool {
//        if destination == box {
//            return  true
//        }
//        else {
//            return false
//        }
//    }
    
    func restart()  {
        room = []
    }
    
   
}


