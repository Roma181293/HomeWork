//
//  QuestionEditorViewController.swift
//  HW 23 Roman Topchii  iOS 19-2 Who wants to be a millionaire
//
//  Created by Roman Topchii on 24.02.2020.
//  Copyright © 2020 Roman Topchii. All rights reserved.
//

import UIKit
import CoreData

class QuestionEditorViewController: UIViewController {
    
    var inputQuestion : Question?
    var categoryId : Int64?
    
    @IBOutlet weak var questionTextField: UITextView!
    
    @IBOutlet weak var firstAnswerSwitch: UISwitch!
    @IBOutlet weak var secondAnswerSwitch: UISwitch!
    @IBOutlet weak var thirdAnswerSwitch: UISwitch!
    @IBOutlet weak var fourthAnswerSwitch: UISwitch!
    
    @IBOutlet weak var firstAnswerLabel: UITextField!
    @IBOutlet weak var secondAnswerLabel: UITextField!
    @IBOutlet weak var thirdAnswerLabel: UITextField!
    @IBOutlet weak var fourthAnswerLabel: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        
        if let inputQuestion = inputQuestion {
            switchSwitcherAtIndexToOnAndOtherSwitcherToOff(index: Int(inputQuestion.correctAnswer))  //включение свитча с правильным ответом в положение ON
            
            questionTextField.text = inputQuestion.question
            
            firstAnswerLabel.text = inputQuestion.answers[0]
            secondAnswerLabel.text = inputQuestion.answers[1]
            thirdAnswerLabel.text = inputQuestion.answers[2]
            fourthAnswerLabel.text = inputQuestion.answers[3]
        }
        else {
            switchSwitcherAtIndexToOnAndOtherSwitcherToOff(index: nil)
        }
    }
    
    
    
    
    
    @IBAction func switchCorrectAnswerAction(_ sender: UISwitch) {
        switchSwitcherAtIndexToOnAndOtherSwitcherToOff(index: sender.tag)
    }
    
    @IBAction func saveAction() {
        if let inputQuestion = inputQuestion {
        let context = CoreDataStack.shared.persistentContainer.viewContext
        let fetchRequest : NSFetchRequest<DataCategory> = DataCategory.fetchRequest()
        fetchRequest.predicate = NSPredicate(format: "id = %@", "\(categoryId!)")
            fetchRequest.predicate = NSPredicate(format: "type = %@", "User")
        do {
            let category = try context.fetch(fetchRequest)
            if category.isEmpty == false {
                if let questions = category[0].questions {
                    for question in questions{
                        if inputQuestion.question == (question as! DataQuestion).question!{
                            
                            (question as! DataQuestion).question = questionTextField.text!
                            
                            ((question as! DataQuestion).answers![0] as! DataAnswer).answer = self.firstAnswerLabel.text!
                            ((question as! DataQuestion).answers![1] as! DataAnswer).answer = self.secondAnswerLabel.text!
                            ((question as! DataQuestion).answers![2] as! DataAnswer).answer = self.thirdAnswerLabel.text!
                            ((question as! DataQuestion).answers![3] as! DataAnswer).answer = self.fourthAnswerLabel.text!
                            
                            if firstAnswerSwitch.isOn {
                                (question as! DataQuestion).correctAnswer = 0
                            }
                            if secondAnswerSwitch.isOn {
                                (question as! DataQuestion).correctAnswer = 1
                            }
                            if thirdAnswerSwitch.isOn {
                                (question as! DataQuestion).correctAnswer = 2
                            }
                            if fourthAnswerSwitch.isOn {
                                (question as! DataQuestion).correctAnswer = 3
                            }
                            
                        }
                    }
                }
            }
            
            
            
            
           
            
            try context.save()
        }
        catch {
            print("Error", error)
        }
        
        let storyBoard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
        let vc = storyBoard.instantiateViewController(withIdentifier: "QuestionsEditorVC_ID") as! QuestionsEditorTableViewController
       // vc.category= categoryId!
        //               print("vc.categoryId", vc.id!)
        self.navigationController?.popViewController(animated: true)
        }
    }
    
    
    
//     @IBAction func saveAction() {
//            if let inputQuestion = inputQuestion {
//            let context = CoreDataStack.shared.persistentContainer.viewContext
//            let fetchRequest : NSFetchRequest<DataQuestion> = DataQuestion.fetchRequest()
//            fetchRequest.predicate = NSPredicate(format: "question = %@", "\(inputQuestion.question)")
//    //        fetchRequest.sortDescriptors = [NSSortDescriptor(key: "question", ascending: true)]
//    //
//            //fetchRequest.predicate = NSPredicate(format: "category.id = %@", "\(categoryId!)")
//            do {
//                let question = try context.fetch(fetchRequest)
//                print("questionTextField.text!", questionTextField.text!)
//                question[0].question = questionTextField.text!
//
//                (question[0].answers![0] as! DataAnswer).answer = self.firstAnswerLabel.text!
//                (question[0].answers![1] as! DataAnswer).answer = self.secondAnswerLabel.text!
//                (question[0].answers![2] as! DataAnswer).answer = self.thirdAnswerLabel.text!
//                (question[0].answers![3] as! DataAnswer).answer = self.fourthAnswerLabel.text!
//
//                if firstAnswerSwitch.isOn {
//                    question[0].correctAnswer = 0
//                }
//                if secondAnswerSwitch.isOn {
//                    question[0].correctAnswer = 1
//                }
//                if thirdAnswerSwitch.isOn {
//                    question[0].correctAnswer = 2
//                }
//                if fourthAnswerSwitch.isOn {
//                    question[0].correctAnswer = 3
//                }
//                try context.save()
//            }
//            catch {
//                print("Error", error)
//            }
//
//            let storyBoard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
//            let vc = storyBoard.instantiateViewController(withIdentifier: "QuestionsEditorVC_ID") as! QuestionsEditorTableViewController
//            vc.categoryId = categoryId!
//            //               print("vc.categoryId", vc.id!)
//            self.navigationController?.popViewController(animated: true)
//            }
//        }
    
    
    
    
    func switchSwitcherAtIndexToOnAndOtherSwitcherToOff(index : Int?) {
        switch index {
        case 0:
            firstAnswerSwitch.setOn(true, animated: true)
            secondAnswerSwitch.setOn(false, animated: true)
            thirdAnswerSwitch.setOn(false, animated: true)
            fourthAnswerSwitch.setOn(false, animated: true)
        case 1:
            firstAnswerSwitch.setOn(false, animated: true)
            secondAnswerSwitch.setOn(true, animated: true)
            thirdAnswerSwitch.setOn(false, animated: true)
            fourthAnswerSwitch.setOn(false, animated: true)
        case 2:
            firstAnswerSwitch.setOn(false, animated: true)
            secondAnswerSwitch.setOn(false, animated: true)
            thirdAnswerSwitch.setOn(true, animated: true)
            fourthAnswerSwitch.setOn(false, animated: true)
        case 3:
            firstAnswerSwitch.setOn(false, animated: true)
            secondAnswerSwitch.setOn(false, animated: true)
            thirdAnswerSwitch.setOn(false, animated: true)
            fourthAnswerSwitch.setOn(true, animated: true)
        default:
            firstAnswerSwitch.setOn(false, animated: true)
            secondAnswerSwitch.setOn(false, animated: true)
            thirdAnswerSwitch.setOn(false, animated: true)
            fourthAnswerSwitch.setOn(false, animated: true)
        }
    }
    
    
    
    // MARK: - Navigation
    
    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
        //        let vc = segue.destination as! QuestionsEditorTableViewController
        //        vc.id = categoryId!
    }
    
    
}
