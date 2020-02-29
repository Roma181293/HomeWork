//
//  LooseViewController.swift
//  HW 23 Roman Topchii  iOS 19-2 Who wants to be a millionaire
//
//  Created by Roman Topchii on 28.02.2020.
//  Copyright © 2020 Roman Topchii. All rights reserved.
//

import UIKit

class LooseViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @IBAction func okAction() {
        self.navigationController?.popToRootViewController(animated: true)
    }
    
    override var preferredStatusBarStyle : UIStatusBarStyle {
        return .lightContent
    }
}
