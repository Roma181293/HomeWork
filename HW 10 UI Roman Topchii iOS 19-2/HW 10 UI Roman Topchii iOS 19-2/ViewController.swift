//
//  ViewController.swift
//  HW 10 UI Roman Topchii iOS 19-2
//
//  Created by Roman Topchii on 21.10.2019.
//  Copyright © 2019 Roman Topchii. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var areaLabel: UILabel!
    @IBOutlet weak var gameOverLabel: UILabel!
    
    var game = Game()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        gameOverLabel.text = ""
        game.readRoomString(level: 1)
        game.roomToArray()
        areaLabel.numberOfLines = 0
        areaLabel.text = game.roomToString()
        //print(game.roomToString())
    }
    
    @IBAction func moveAction(_ sender: UIButton) {
        var direction : Direction
        
        switch sender.tag {
        case 1:
            direction = .up
        case 2:
            direction = .down
        case 3:
            direction = .left
        default: // = 4
            direction = .right
        }
        
        game.move(to: direction)
        areaLabel.text = game.roomToString()
            
        if game.gameOver(box: game.boxes, destination: game.destinations) {
            gameOverLabel.text = "GAME OVER!!!"
        }
    }
    
    
    @IBAction func changeLevelAction(_ sender: UIButton) {
        game.restart()
        gameOverLabel.text = ""
        game.readRoomString(level: sender.tag)
        game.roomToArray()
        areaLabel.text = game.roomToString()
        //print(game.roomToString())
        
    }
    
    


}

