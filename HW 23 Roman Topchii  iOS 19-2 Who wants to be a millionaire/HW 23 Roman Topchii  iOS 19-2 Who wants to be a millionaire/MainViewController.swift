//
//  MainViewController.swift
//  HW 23 Roman Topchii  iOS 19-2 Who wants to be a millionaire
//
//  Created by Roman Topchii on 03.01.2020.
//  Copyright © 2020 Roman Topchii. All rights reserved.
//

import UIKit

class MainViewController: UIViewController {
    
    var game : Game?
    
    @IBOutlet weak var textlabel : UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        
      
    }
    
    
    
    
    
    @IBAction func newGame(_ sender: Any) {
        game = Game (questionList: readFromQuestionsList())
    }
    
    func readFromQuestionsList() -> [Question] {
        //Чтение массива из файлов ресурсов Questions.plist
        var myArray: NSArray?
        
        var questionsArray : [Question] = []
        
        if let path = Bundle.main.path(forResource: "questions", ofType: "plist") {
            myArray = NSArray(contentsOfFile: path)
        }
        
        if let questionsArrayFromPList = myArray {
            for question in questionsArrayFromPList {
                let questionItem  = question as! Dictionary<String, Any> //приведение к типу массива<Any>
                
                let question: String = questionItem["question"] as! String
                
                let answers : [String] = questionItem["arswerArray"] as! [String]
                
                let correctAnswerIndex: Int = questionItem["correctAnswerIndex"] as! Int
                
                questionsArray.append(Question(question: question, answers: answers, correctAnswer: correctAnswerIndex))
            }
            
        }
     //   print(questionsArray)
        
        return questionsArray
    }
    
    
    
    
    
    
    
    
    
    
     // MARK: - Navigation
    
    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
        
        if segue.identifier == "goToQuestionVC" {
            if let vc : QuestionViewController = segue.destination as? QuestionViewController {
                vc.game = game
                
            }
        }
    }
    
    
}
