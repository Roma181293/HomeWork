//
//  WinViewController.swift
//  HW 23 Roman Topchii  iOS 19-2 Who wants to be a millionaire
//
//  Created by Roman Topchii on 09.01.2020.
//  Copyright © 2020 Roman Topchii. All rights reserved.
//

import UIKit

class WinViewController: UIViewController {
    var game : Game! = Game.shared
    
    @IBOutlet weak var winLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        self.navigationController?.isNavigationBarHidden = true

            if let prize  = game?.prize() {
                winLabel.text = "Поздравляем! Вы выиграли \(prize) грн. Введите номер вашей карты ниже и мы перешлем их Вам!"
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
