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

class Box {
    var x : Int = 1
    var y : Int = 1
}

class Destination {
    var x : Int = 9
    var y : Int = 9
}

class Room {
    var width : Int = 10
    var height : Int = 10
}

class Game {
    var room : Room = Room()
    var player : Player = Player()
    var box : Box = Box()
    var destination = Destination()
    var walls : [(x : Int, y : Int)] = []
    
    var room_2 : [[Object]] = []
    
    


    //   *****************************
    func roomToArray() {
        room_2 = []
        for y in 0..<room.height {
            var row : [Object] = []
            for x in 0..<room.width {
                
                var cell : Object = .emptySpace
                if player.x == x && player.y == y {
                    cell = .player
                }
                else if box.x == x && box.y == y {
                    cell = .box
                }
                else if destination.x == x && destination.y == y {
                    cell = .destination
                }
                else if walls.isEmpty == false {
                    for wall in walls{
                        if wall.x == x && wall.y == y {
                            cell = .wall
                        }
                    }
                }
                row.append(cell)
            }
            room_2.append(row)
        }
        print(room_2)
    }
    
   //**************
    func matrixToString() -> String {
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
        switch direction {
        case .left:
            if room_2[player.y][player.x - 1] == .wall || (room_2[player.y][player.x - 1] == .box && room_2[player.y][player.x - 2] == .wall)  {
                canMove = false
            }
        case .right:
            if room_2[player.y][player.x + 1] == .wall || (room_2[player.y][player.x + 1] == .box && room_2[player.y][player.x + 2] == .wall)  {
                canMove = false
            }
        case .up:
            if room_2[player.y - 1][player.x] == .wall || (room_2[player.y - 1][player.x] == .box && room_2[player.y - 2][player.x] == .wall)  {
                canMove = false
            }
        case .down:
            if room_2[player.y + 1][player.x] == .wall || (room_2[player.y + 1][player.x] == .box && room_2[player.y + 2][player.x] == .wall)  {
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
                    if player.x == box.x && player.y == box.y {
                        box.x -= 1
                    }
                }
                
            case .right:
                if canMove(direction: .right){
                    player.x += 1
                    if player.x == box.x && player.y == box.y {
                        box.x += 1
                    }
                }
            case .up:
                if canMove(direction: .up){
                    player.y -= 1
                    if player.x == box.x && player.y == box.y {
                        box.y -= 1
                    }
                }
            case .down:
                if canMove(direction: .down){
                    player.y += 1
                    if player.x == box.x && player.y == box.y {
                        box.y += 1
                    }
                }
        }
        roomToArray()
        
    }
    
    func gameOver(box : Box, destination : Destination) -> Bool {
        if destination.x == box.x && destination.y == box.y{
            return true
        }
        else {
            return false
        }
    }
    
    func readRoomString() {
        let roomString = "xxxxxxxxxx\nx........x\nxxx......x\nx...*....x\nx......+.x\nx..xxxx..x\nx..$.....x\nx........x\nxxxxxxxxxx"
        print(roomString)
            
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
                destination.x = columnCounter
                destination.y = rowCounter
                columnCounter += 1
                room.width = max(room.width,columnCounter)
            case "*":
                box.x = columnCounter
                box.y = rowCounter
                columnCounter += 1
                room.width = max(room.width,columnCounter)
            case "x":
                walls.append((x: columnCounter, y: rowCounter))
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
//            print("room.width = \(room.width), room.height = \(room.height)")
//
    }
}





var game = Game()
game.readRoomString()
game.roomToArray()

print(game.matrixToString())
var isGameOver = false

while isGameOver == false {

    print("введи направление хода: ", terminator: "")

    if let read = readLine() {
        switch read {
        case "l":
            game.move(to: .left)
        case "r":
            game.move(to: .right)
        case "d":
            game.move(to: .down)
        case "u":
            game.move(to: .up)
        default:
            break
        }
        isGameOver = game.gameOver(box: game.box, destination: game.destination)
    }
    print(game.matrixToString())
    if isGameOver == true {
        print("Game Over!!!")
    }
}

