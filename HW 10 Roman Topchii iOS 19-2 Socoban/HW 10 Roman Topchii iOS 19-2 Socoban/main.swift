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

//enum Object {
//    case player, box, wall, destination, space
//}

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
   
    func roomToString() -> String {
        var area: String = ""
        for y in 0..<room.height {
            for x in 0..<room.width {
                var cell = "⬜️"
                if player.x == x && player.y == y {
                    cell = "🏃‍♂️"
                }
                else if box.x == x && box.y == y {
                    cell = "📦"
                }
                else if destination.x == x && destination.y == y {
                    cell = "❎"
                }
                area.append(cell)
            }
            area.append("\n")
        }
        return area
    }
    
    func canMove(player : Player, box : Box) -> Bool {
        var result : Bool = false
        if box.x > 0 && box.x < room.width - 1 && player.y == box.y || box.y > 0 && box.y < room.height - 1 && player.x == box.x {
            result = true
        }
        return result
    }
    
    
    func move(to direction: Direction) {
        switch direction {
            case .left:
                print(canMove(player: player, box: box))
                if player.x > 0 {
                    if player.x-1 == box.x && player.y == box.y {
                       
                        if canMove(player: player, box: box) {
                            player.x -= 1
                            box.x -= 1
                        }
                    }
                    else {
                        player.x -= 1
                    }
                }
            
            case .right:
                print(canMove(player: player, box: box))
                if player.x < room.width-1 {
                    if player.x+1 == box.x  && player.y == box.y {
                        if canMove(player: player, box: box) {
                            player.x += 1
                            box.x += 1
                        }
                    }
                    else {
                        player.x += 1
                    }
                }
            
            case .up:
                print(canMove(player: player, box: box))
                if player.y > 0 {
                    
                    if player.y-1 == box.y && player.x == box.x{
                        if canMove(player: player, box: box) {
                            player.y -= 1
                            box.y -= 1
                        }
                    }
                    else {
                        player.y -= 1
                    }
                }
            
            case .down:
                print(canMove(player: player, box: box))
                if player.y < room.height-1 {
                    if player.y+1 == box.y && player.x == box.x {
                        if canMove(player: player, box: box) {
                            player.y += 1
                            box.y += 1
                        }
                    }
                    else {
                        player.y += 1
                    }
                }
        }
    }
    
    
 
    
    func gameOver(box : Box, destination : Destination) -> Bool {
        if destination.x == box.x && destination.y == box.y{
            return true
        }
        else {
            return false
        }
    }
}





var game = Game()
print(game.roomToString())
var isGameOver = false

while isGameOver == false {
    
    print("введи направление хода: ", terminator: "")
    
    if let read = readLine() {
        switch read {
        case "l":
                game.move(to: Direction.left)
        case "r":
                game.move(to: Direction.right)
        case "d":
                game.move(to: Direction.down)
        case "u":
                game.move(to: Direction.up)
        default:
            break
        }
        isGameOver = game.gameOver(box: game.box, destination: game.destination)
    }
    print(game.roomToString())
    if isGameOver == true {
        print("Game Over!!!")
    }
}

