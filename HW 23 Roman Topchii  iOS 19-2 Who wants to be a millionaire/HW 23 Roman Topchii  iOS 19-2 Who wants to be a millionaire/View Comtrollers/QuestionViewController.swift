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
    
    var globalTimer: Timer?
    var counter : Int = 0
    
    @IBOutlet weak var question: UILabel!
    
    @IBOutlet weak var firstAnswer: UIButton!
    @IBOutlet weak var secondAnswer: UIButton!
    @IBOutlet weak var thirdAnswer: UIButton!
    @IBOutlet weak var fourthAnswer: UIButton!
    
    @IBOutlet weak var friendCall: UIButton!
    @IBOutlet weak var audienceHelp: UIButton!
    
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
            let alert = UIAlertController(title: "Ошибка", message: "Что-то пошло не так при загрузке вопросов", preferredStyle: UIAlertController.Style.alert)
            alert.addAction(UIAlertAction(title: "Окей", style: UIAlertAction.Style.default, handler: nil))
            self.present(alert, animated: true, completion: nil)
        }
        
        if game.canGetHelp().friend == true {
            friendCall.isEnabled = false
        }
        
        if game.canGetHelp().audience == true {
            audienceHelp.isEnabled = false
        }
        
        print(game.askForAudienceHelp2()!)
        
    }
    
    @IBAction func callFriendAction(_ sender: UIButton) {
        if let friendHelp = game.callFriend() {
            changeButtonBackgroundColour(buttonNumber: friendHelp, to : .magenta)
            sender.isEnabled = false
        }
    }
    
    @IBAction func audienceHelpAction(_ sender: UIButton) {
        if let audienceHelp = game.askForAudienceHelp() {
            changeButtonBackgroundColour(buttonNumber: audienceHelp, to : .orange)
            sender.isEnabled = false
        }
    }
    
    
    @IBAction func giveTheAnswer(_ sender: UIButton) {
        
        sender.backgroundColor = .orange
        
        self.view.isUserInteractionEnabled = false
        
        let storyBoard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
        
        game.addToHistory(userAnswer: sender.tag-1)
        let result = game.checkAnswer(userAnswerIndex: sender.tag-1)
        
        var deadlineTime =  DispatchTime.now() + 0.5
        
        DispatchQueue.main.asyncAfter(deadline: deadlineTime, execute: {
            sender.backgroundColor = UIColor.red
            self.changeButtonBackgroundColour(buttonNumber: result.correctAnswerIndex, to : .green)
        })
        
        deadlineTime =  DispatchTime.now() + 0.8
        
        DispatchQueue.main.asyncAfter(deadline: deadlineTime, execute: {
            sender.backgroundColor = UIColor.red
            self.changeButtonBackgroundColour(buttonNumber: result.correctAnswerIndex, to : .orange)
        })
        
        deadlineTime =  DispatchTime.now() + 1.1
        
        DispatchQueue.main.asyncAfter(deadline: deadlineTime, execute: {
            sender.backgroundColor = UIColor.red
            self.changeButtonBackgroundColour(buttonNumber: result.correctAnswerIndex, to : .green)
        })
        
        deadlineTime =  DispatchTime.now() + 3
        
        DispatchQueue.main.asyncAfter(deadline: deadlineTime, execute: {
            if result.correctAnswer == true && result.gameOver == false {
                let chooseViewController = storyBoard.instantiateViewController(withIdentifier: "ChooseVC_ID") as! ChooseViewController
                self.navigationController?.pushViewController(chooseViewController, animated: true)
            }
            else  if result.correctAnswer == true && result.gameOver == true {
                let winViewController = storyBoard.instantiateViewController(withIdentifier: "WinVC_ID") as! WinViewController
                self.game.saveResults()
                self.navigationController?.pushViewController(winViewController, animated: true)
            }
            else  if result.correctAnswer == false && result.gameOver == true {
                let looseViewController = storyBoard.instantiateViewController(withIdentifier: "LooseVC_ID")
                self.game.saveResults()
                self.navigationController?.pushViewController(looseViewController, animated: true)
            }
        }
        )
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
    
    
    
    
    /*
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     // Get the new view controller using segue.destination.
     // Pass the selected object to the new view controller.
     
     }
     */
    
}
