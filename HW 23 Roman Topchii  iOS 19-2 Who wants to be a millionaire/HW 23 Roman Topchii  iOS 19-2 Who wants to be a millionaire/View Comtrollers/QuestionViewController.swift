//
//  QuestionViewController.swift
//  HW 23 Roman Topchii  iOS 19-2 Who wants to be a millionaire
//
//  Created by Roman Topchii on 08.01.2020.
//  Copyright © 2020 Roman Topchii. All rights reserved.
//

import UIKit

class QuestionViewController: UIViewController {
    
    var game : Game! = Game.share
    
    
    @IBOutlet weak var question: UILabel!
    
    @IBOutlet weak var firstAnswer: UIButton!
    @IBOutlet weak var secondAnswer: UIButton!
    @IBOutlet weak var thirdAnswer: UIButton!
    @IBOutlet weak var fourthAnswer: UIButton!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        
        self.navigationController?.isNavigationBarHidden = true
        //        self.modalPresentationStyle = .fullScreen
        
        let levelQuestion = game.askQuestion()
        
        if let levelQuestion = levelQuestion {
            question.text = levelQuestion.question
            firstAnswer.setTitle("a) "+levelQuestion.answers[0], for: .normal)
            secondAnswer.setTitle("b) "+levelQuestion.answers[1], for: .normal)
            thirdAnswer.setTitle("c) "+levelQuestion.answers[2], for: .normal)
            fourthAnswer.setTitle("d) "+levelQuestion.answers[3], for: .normal)
        }
        else {
            question.text = "что-то пошло не так"
        }
        
    }
    
    @IBAction func callFriendAction(_ sender: Any) {
        if let friendHelp = game.callFriend() {
            changeButtonBackgroundColour(buttonNumber: friendHelp, to : .magenta)
        }
        else {
            let alert2 = UIAlertController(title: "Думайте сами!", message: "Вы уже воспользовались помощью друга", preferredStyle: UIAlertController.Style.alert)
            alert2.addAction(UIAlertAction(title: "Хорошо", style: UIAlertAction.Style.default, handler: nil))
            self.present(alert2, animated: true, completion: nil)
        }
    }
    
    @IBAction func audienceHelpAction(_ sender: Any) {
        if let audienceHelp = game.askForAudienceHelp() {
            changeButtonBackgroundColour(buttonNumber: audienceHelp, to : .orange)
        }
        else {
            let alert = UIAlertController(title: "Думайте сами!", message: "Вы уже воспользовались помощью зала", preferredStyle: UIAlertController.Style.alert)
            alert.addAction(UIAlertAction(title: "Хорошо", style: UIAlertAction.Style.default, handler: nil))
            self.present(alert, animated: true, completion: nil)
        }
    }
    
    func changeButtonBackgroundColour(buttonNumber : Int, to color : UIColor) {
        switch buttonNumber {
        case 0:
            firstAnswer.backgroundColor = color
        case 1:
            secondAnswer.backgroundColor = color
        case 2:
            thirdAnswer.backgroundColor = color
        case 3:
            fourthAnswer.backgroundColor = color
        default:
            return
        }
    }
    
    @IBAction func giveTheAnswer(_ sender: UIButton) {
        
        let storyBoard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
        game.addToHistory(userAnswer: sender.tag-1)
        
        let result = game.checkAnswer(userAnswer: sender.tag-1)
        
        
        
        
        
        if result.correctAnswer == true && result.gameOver == false {
            let chooseViewController = storyBoard.instantiateViewController(withIdentifier: "ChooseVC_ID") as! ChooseViewController
            navigationController?.pushViewController(chooseViewController, animated: true)
        }
        else  if result.correctAnswer == true && result.gameOver == true {
            let winViewController = storyBoard.instantiateViewController(withIdentifier: "WinVC_ID") as! WinViewController
            game.saveResults()
            navigationController?.pushViewController(winViewController, animated: true)
        }
        else  if result.correctAnswer == false && result.gameOver == true {
            let looseViewController = storyBoard.instantiateViewController(withIdentifier: "LooseVC_ID")
            game.saveResults()
            navigationController?.pushViewController(looseViewController, animated: true)
        }
        
        
    }
    
    
    
    
    
    /*
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     // Get the new view controller using segue.destination.
     // Pass the selected object to the new view controller.
     
     }
     */
    
}
