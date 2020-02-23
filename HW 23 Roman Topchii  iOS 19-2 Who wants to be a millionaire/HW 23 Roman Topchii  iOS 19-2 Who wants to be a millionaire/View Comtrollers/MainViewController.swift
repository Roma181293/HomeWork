//
//  MainViewController.swift
//  HW 23 Roman Topchii  iOS 19-2 Who wants to be a millionaire
//
//  Created by Roman Topchii on 03.01.2020.
//  Copyright © 2020 Roman Topchii. All rights reserved.
//

import UIKit



class MainViewController: UIViewController {
    
    var game : Game! = Game.shared
    var coreDataStack = CoreDataStack.shared
    
    @IBOutlet weak var spiner: UIActivityIndicatorView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationController?.isNavigationBarHidden = true
        
        spiner.isHidden = true
        self.navigationController?.navigationBar.barTintColor = UIColor(displayP3Red: CGFloat(54.0/255.0), green: CGFloat(41.0/255.0), blue: CGFloat(67.0/255.0), alpha: 1.0)
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        
        super.viewWillAppear(true)
        self.navigationController?.isNavigationBarHidden = true
    }
    
    
    
    
    @IBAction func startNewGameLacalOrNetwork() {
        spiner.isHidden = false
        spiner.startAnimating()
        let url = URL(string: "https://raw.githubusercontent.com/Roma181293/MillionaireResouces/master/categoryList.json")!
        
        NetworkService.fetchCategory(url: url) { (categories , error) in
            let storyBoard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
            if error == nil{
                DispatchQueue.main.async {
                    self.spiner.stopAnimating()
                    self.spiner.isHidden = true
                    let vc = storyBoard.instantiateViewController(withIdentifier: "ChooseCategoryVC_ID") as! ChooseCategoryTableViewController
                    vc.categories = categories!
                    self.navigationController?.pushViewController(vc, animated: true)
                    self.coreDataStack.updateCategories2(categories!)
                    self.coreDataStack.printCategory()
                   // print(self.coreDataStack.printCategories())
                }
            }
            else {
                DispatchQueue.main.async {
                    self.spiner.stopAnimating()
                    self.spiner.isHidden = true
                    
                    let alert = UIAlertController(title: "Упс. Не удалось загрузить темы вопросов.", message: nil, preferredStyle: .alert)
                    
                    alert.addAction(UIAlertAction(title: "Вопросы произвольной тематики", style: .default, handler: { action in
                        let questionVC = storyBoard.instantiateViewController(withIdentifier: "QuestionVC_ID") as! QuestionViewController
                        print("Вопросы общей темы")
                        self.game.newLocalGame()
                        self.navigationController?.pushViewController(questionVC, animated: true)
                    }))
                    
                    alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
                    
                    self.present(alert, animated: true, completion: nil)
                }
            }
        }
    }
    
}
