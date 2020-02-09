//
//  DetailViewController.swift
//  HW 23 Roman Topchii  iOS 19-2 Who wants to be a millionaire
//
//  Created by Roman Topchii on 13.01.2020.
//  Copyright © 2020 Roman Topchii. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController {
    
    var gameResults : (memo : String, prize : String, description : String)?
    
    @IBOutlet weak var prizeLable: UILabel!
    @IBOutlet weak var questionsAndAnswersLabel: UILabel!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let gameResults = gameResults{
            
            prizeLable.text = gameResults.prize
            questionsAndAnswersLabel.text = gameResults.description
            self.navigationItem.title = gameResults.memo
            
        }
    }
    
    
}

