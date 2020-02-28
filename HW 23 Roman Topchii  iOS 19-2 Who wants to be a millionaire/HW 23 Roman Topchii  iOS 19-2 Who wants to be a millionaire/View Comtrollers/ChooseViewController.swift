//
//  ChooseViewController.swift
//  HW 23 Roman Topchii  iOS 19-2 Who wants to be a millionaire
//
//  Created by Roman Topchii on 08.01.2020.
//  Copyright © 2020 Roman Topchii. All rights reserved.
//

import UIKit

class ChooseViewController: UIViewController {
    
    weak var previousVC : QuestionViewController?
    weak var game : Game! = Game.shared
    
    @IBOutlet weak var messageLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        self.navigationController?.isNavigationBarHidden = true
        
        if let prize = game?.prize(){
            messageLabel.text = "Вы выиграли \(prize) грн."
        }
    }
    
    @IBAction func takeMoneyAction(_ sender: Any) {
        let storyBoard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
        let vc = storyBoard.instantiateViewController(withIdentifier: "WinVC_ID") as! WinViewController
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    
    @IBAction func nextQuestionAction(_ sender: Any) {
        if game.isGameOver() == false {
            game.nextQuestion()
            previousVC!.viewDidLoad()
        }
        self.navigationController?.popToViewController(previousVC!, animated: true)
    }
    
    
    
    
    
    
    
    // MARK: - Navigation
    
    // In a storyboard-based application, you will often want to do a little preparation before navigation
//    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
//        // Get the new view controller using segue.destination.
//        // Pass the selected object to the new view controller.
//        if segue.identifier == "goToQuestionVC" {
//            if let _ : QuestionViewController = segue.destination as? QuestionViewController {
//                if game.gameStatus() == false {
//                    game.nextQuestion()
//                }
//            }
//        }
//        if segue.identifier == "goToWinVC" {
//            if let _ : WinViewController = segue.destination as? WinViewController {
//                game.saveResults()
//            }
//        }
//    }
//
    
}
