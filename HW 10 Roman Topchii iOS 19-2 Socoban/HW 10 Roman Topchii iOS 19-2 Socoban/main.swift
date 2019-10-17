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
    case player, box, wall, destination, space
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
    
    
    func movePlayer(to direction: Direction) {
        switch direction {
            case .left:
                if player.x > 0 {
                    player.x -= 1
                }
            
            case .right:
                if player.x < room.width-1 {
                    player.x += 1
                }
            
            case .up:
                if player.y > 0 {
                    player.y -= 1
                }
            
            case .down:
                if player.y < room.height-1 {
                    player.y += 1
                }
        }
    }
    
    
    func moveBox(to direction: Direction) {
        switch direction {
            case .left:
                if box.x > 0 {
                    box.x -= 1
                }
               
            case .right:
                if box.x < room.width-1 {
                    box.x += 1
                }
               
            case .up:
                if box.y > 0 {
                    box.y -= 1
                }
               
            case .down:
                if box.y < room.height-1 {
                    box.y += 1
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
            if game.player.x-1 == game.box.x && game.player.y == game.box.y {
                if game.canMove(player: game.player, box: game.box) {
                    game.movePlayer(to: Direction.left)
                    game.moveBox(to: Direction.left)
                }
            }
            else {
                game.movePlayer(to: Direction.left)
            }
        case "r":
            if game.player.x+1 == game.box.x  && game.player.y == game.box.y {
                if game.canMove(player: game.player, box: game.box) {
                    game.movePlayer(to: Direction.right)
                    game.moveBox(to: Direction.right)
                }
            }
            else {
                game.movePlayer(to: Direction.right)
            }
        case "d":
            if game.player.y+1 == game.box.y && game.player.x == game.box.x {
                if game.canMove(player: game.player, box: game.box) {
                    game.movePlayer(to: Direction.down)
                    game.moveBox(to: Direction.down)
                }
            }
            else {
                game.movePlayer(to: Direction.down)
            }
        case "u":
            if game.player.y-1 == game.box.y && game.player.x == game.box.x{
                print(game.canMove(player: game.player, box: game.box))
                if game.canMove(player: game.player, box: game.box) {
                    game.movePlayer(to: Direction.up)
                    game.moveBox(to: Direction.up)
                }
                
            }
            else {
                game.movePlayer(to: Direction.up)
            }
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

