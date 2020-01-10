//
//  ChooseViewController.swift
//  HW 23 Roman Topchii  iOS 19-2 Who wants to be a millionaire
//
//  Created by Roman Topchii on 08.01.2020.
//  Copyright © 2020 Roman Topchii. All rights reserved.
//

import UIKit

class ChooseViewController: UIViewController {
    weak var game : Game?
    
    
    @IBOutlet weak var messageLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        if let currentQuestionIndex = game?.currentQuestionIndex {
            if let prize = game?.prize[currentQuestionIndex]{
                messageLabel.text = "Вы уже выиграли \(prize)грн."
            }
        }
    }
    
    
    
    // MARK: - Navigation
    
    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
        if segue.identifier == "goToQuestionVC" {
            if let questionVC : QuestionViewController = segue.destination as? QuestionViewController {
                if game?.gameOver == false {
                    game?.nextQuestion()
                }
                questionVC.game = game
                
            }
        }
        if segue.identifier == "goToWinVC" {
            if let winVC : WinViewController = segue.destination as? WinViewController {
                game?.saveResults()
                winVC.game = game
                
            }
        }
        
    }
    
    
}
