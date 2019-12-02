//
//  ViewController.swift
//  ДЗ 17.2 Топчий Роман iOS 19-2
//
//  Created by Roman Topchii on 30.11.2019.
//  Copyright © 2019 Roman Topchii. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

 var counter = 1


    @IBOutlet weak var redView: UIView!
    @IBOutlet weak var yellowView: UIView!
    @IBOutlet weak var greenView: UIView!
   
    @IBOutlet weak var button: UIButton!
    
    override func viewDidLoad() {
         super.viewDidLoad()
         // Do any additional setup after loading the view.
        redView.alpha = 0.3
        yellowView.alpha = 0.3
        greenView.alpha = 0.3
        redView.layer.cornerRadius = redView.frame.size.height/2
        yellowView.layer.cornerRadius = yellowView.frame.size.height/2
        greenView.layer.cornerRadius = greenView.frame.size.height/2
     }
    
    
    
    
    @IBAction func buttonPressed() {
        switch counter {
        case 1:
            greenView.alpha = 0.3
            redView.alpha = 1
            counter += 1
            button.setTitle("NEXT", for: .normal)
        case 2:
            redView.alpha = 0.3
            yellowView.alpha = 1
            counter += 1
        case 3:
            yellowView.alpha = 0.3
            greenView.alpha = 1
            counter = 1
        default :
            break
        }
        redView.layer.cornerRadius = redView.frame.size.height/2
        yellowView.layer.cornerRadius = yellowView.frame.size.height/2
        greenView.layer.cornerRadius = greenView.frame.size.height/2
    }
   
}

