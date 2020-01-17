//
//  MainViewController.swift
//  HW 23 Roman Topchii  iOS 19-2 Who wants to be a millionaire
//
//  Created by Roman Topchii on 03.01.2020.
//  Copyright © 2020 Roman Topchii. All rights reserved.
//

import UIKit

class MainViewController: UIViewController {
    
    var game : Game!
    
    @IBOutlet weak var textlabel : UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        game = Game.share
        
    }

    @IBAction func newGame(_ sender: Any) {
        game.newGame()
    }
}
