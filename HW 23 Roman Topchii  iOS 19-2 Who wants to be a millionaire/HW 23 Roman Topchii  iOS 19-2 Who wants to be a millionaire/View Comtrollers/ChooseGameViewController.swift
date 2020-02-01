//
//  ChooseGameViewController.swift
//  HW 23 Roman Topchii  iOS 19-2 Who wants to be a millionaire
//
//  Created by Roman Topchii on 31.01.2020.
//  Copyright © 2020 Roman Topchii. All rights reserved.
//

import UIKit

class ChooseGameViewController: UIViewController {
    
    var game : Game! = Game.share
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
    }
    
    
    
    @IBAction func serverGame() {
        let url = URL(string: "https://raw.githubusercontent.com/Roma181293/MillionaireResouces/master/categoryList.json")!
        
        NetworkService.fetchCategory(url: url) { (categories , error) in
            DispatchQueue.main.async {
                
                let storyBoard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
                let vc = storyBoard.instantiateViewController(withIdentifier: "ChooseCategoryVC_ID") as! ChooseCategoryTableViewController
                vc.categories = categories!
                 self.navigationController?.pushViewController(vc, animated: true)
                
            }
        }
    }
    
    
    @IBAction func localGame() {
        game.newLocalGame()
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
