//
//  CreateNewCategoryViewController.swift
//  HW 23 Roman Topchii  iOS 19-2 Who wants to be a millionaire
//
//  Created by Roman Topchii on 25.02.2020.
//  Copyright © 2020 Roman Topchii. All rights reserved.
//

import UIKit
import CoreData

class CreateNewCategoryViewController: UIViewController {
    
    let coreDataStack = CoreDataStack.shared
    
    
    @IBOutlet weak var categoryNameTextField: UITextField!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
    }
    
    
    
    
    @IBAction func addNewCategoryAction(_ sender: Any) {
        if let name = categoryNameTextField.text, name != "", let category = self.coreDataStack.addLocalCategory(categoryName: name, categoryType: "User") {
            
            let storyBoard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
            let vc = storyBoard.instantiateViewController(withIdentifier: "QuestionEditorVC_ID") as! QuestionEditorViewController
            vc.categoryId = category.id
            vc.inputQuestion = Question(dataQuestion : category.questions?[0] as! DataQuestion)
            navigationController?.pushViewController(vc, animated: true)
            
            
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
