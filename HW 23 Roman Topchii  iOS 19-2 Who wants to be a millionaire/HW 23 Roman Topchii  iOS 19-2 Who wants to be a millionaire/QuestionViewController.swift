//
//  QuestionViewController.swift
//  HW 23 Roman Topchii  iOS 19-2 Who wants to be a millionaire
//
//  Created by Roman Topchii on 08.01.2020.
//  Copyright © 2020 Roman Topchii. All rights reserved.
//

import UIKit

class QuestionViewController: UIViewController {
    
    weak var  game : Game?
    
    
    @IBOutlet weak var question: UILabel!
    
    @IBOutlet weak var firstAnswer: UIButton!
    @IBOutlet weak var secondAnswer: UIButton!
    @IBOutlet weak var thirdAnswer: UIButton!
    @IBOutlet weak var fourthAnswer: UIButton!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        
        let levelQuestion = game?.askQuestion()
        
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
    
    
    
    @IBAction func giveTheAnswer(_ sender: UIButton) {
        
        let storyBoard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
        
        if (game?.checkAnswer(userAnswer: sender.tag-1))! == (true,false) {
            let chooseViewController = storyBoard.instantiateViewController(withIdentifier: "ChooseVC_ID") as! ChooseViewController
            chooseViewController.game = game
            self.present(chooseViewController, animated:true, completion:nil)
        }
            else  if (game?.checkAnswer(userAnswer: sender.tag-1))! == (true,true) {
                let winViewController = storyBoard.instantiateViewController(withIdentifier: "WinVC_ID") as! WinViewController
            winViewController.game = game
                self.present(winViewController, animated:true, completion:nil)
            }
        else  if (game?.checkAnswer(userAnswer: sender.tag-1))! == (false,true) {
            let looseViewController = storyBoard.instantiateViewController(withIdentifier: "LooseVC_ID")
            game = nil
            self.present(looseViewController, animated:true, completion:nil)
            
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
