//
//  ViewController.swift
//  Bubble Popper
//
//  Created by Roman Topchii on 13.12.2019.
//  Copyright © 2019 Roman Topchii. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

   override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    
    @IBAction func startGame() {
        let size = CGFloat.random(in: 20...100)
        let button = UIButton(frame: CGRect(x: CGFloat.random(in: 0...view.frame.width), y: CGFloat.random(in: 0...view.frame.height), width: size, height: size))
        button.backgroundColor = .green
        
        button.layer.cornerRadius = size/2
        
        button.addTarget(self, action: #selector(ViewController.buttonAction(_:)), for: .touchUpInside)
               
        self.view.addSubview(button)
       
        
        
        
        
        UIView.animate(withDuration: 1 , animations: {
            button.frame.origin.x += CGFloat.random(in: -100...100)
            button.frame.origin.y += CGFloat.random(in: -100...100)
        })
      
        
    }
    
    
    @objc  func buttonAction(_ sender:UIButton!)
    {
        sender.removeFromSuperview()
    }
}

