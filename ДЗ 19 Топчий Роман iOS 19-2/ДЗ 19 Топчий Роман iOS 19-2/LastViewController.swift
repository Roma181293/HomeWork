//
//  LastViewController.swift
//  ДЗ 19 Топчий Роман iOS 19-2
//
//  Created by Roman Topchii on 12.12.2019.
//  Copyright © 2019 Roman Topchii. All rights reserved.
//

import UIKit

class LastViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    

  
    @IBAction func goToPreviousVC() {
        self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func goToRootVC() {
        self.navigationController?.popToRootViewController(animated: true)
    }
    
    

}
