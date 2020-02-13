//
//  ViewController.swift
//  HW GCD Topchii
//
//  Created by Roman Topchii on 07.02.2020.
//  Copyright © 2020 Roman Topchii. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    var log : String = "" {
        didSet {
            print(log)
            logLabel.text = log
        }
    }
    var progress : Float = 0{
        didSet {
            print(progress)
            DispatchQueue.main.async {
                self.progressView.progress = self.progress
            }
        }
    }
    
    
    @IBOutlet weak var spiner: UIActivityIndicatorView!
    @IBOutlet weak var progressView: UIProgressView!
    @IBOutlet weak var logLabel: UILabel!
    @IBOutlet weak var startButtonOutlet: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        log = "Status:\n"
        progress = 0.0
        spiner.isHidden = true
    }
    
    @IBAction func startAction () {
         startButtonOutlet.isUserInteractionEnabled = false
        log = "Status:\n"
        spiner.isHidden = false
        progress = 0.0
        self.test(numberOfIteration : 5)
        
    }
    
    
    func test(numberOfIteration : Int) {
        let group = DispatchGroup()
        let queue = DispatchQueue(label: "dispGroup", attributes: .concurrent)
        
        spiner.startAnimating()
        progressView.progress = 0
        
        for index in 1...numberOfIteration {
            queue.async(group: group, execute: {
                self.task(i: index)
                self.progress += 1.0/Float(numberOfIteration)
            })
        }
        
        group.notify(queue: DispatchQueue.main) {
            self.spiner.stopAnimating()
            self.spiner.isHidden = true
            self.startButtonOutlet.isUserInteractionEnabled = true
            self.log += "=finish all="
        }
    }
    
    
    func task(i: Int) {
        DispatchQueue.main.async {
            self.log += "task \(i) start\n"
        }
        
        sleep(UInt32(6-i))
        
        DispatchQueue.main.async {
            self.log += "task \(i) finish\n"
        }
    }
}

