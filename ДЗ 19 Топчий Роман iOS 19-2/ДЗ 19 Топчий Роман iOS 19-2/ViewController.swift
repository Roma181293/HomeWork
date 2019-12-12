//
//  ViewController.swift
//  ДЗ 19 Топчий Роман iOS 19-2
//
//  Created by Roman Topchii on 10.12.2019.
//  Copyright © 2019 Roman Topchii. All rights reserved.
//

import UIKit

protocol TransferProtocol {
    var colour : (red : Float, green : Float, blue : Float) {set get}
}


class ViewController: UIViewController, TransferProtocol {
    
    
    var colour : (red : Float, green : Float, blue : Float) = (0.2,0.3,0.7)
    
    @IBOutlet weak var redTextField: UITextField!
    @IBOutlet weak var greenTextField: UITextField!
    @IBOutlet weak var blueTextField: UITextField!
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        redTextField.text = "\(Double(Int(colour.red*100))/100)"
        greenTextField.text = "\(Double(Int(colour.green*100))/100)"
        blueTextField.text = "\(Double(Int(colour.blue*100))/100)"
        
        let keyboardToolBar = UIToolbar()
        keyboardToolBar.sizeToFit()
        
        let flexibleSpace = UIBarButtonItem(barButtonSystemItem: UIBarButtonItem.SystemItem.flexibleSpace, target: nil, action: nil)
        let doneButton = UIBarButtonItem(barButtonSystemItem: UIBarButtonItem.SystemItem.done, target: self, action: #selector(self.doneClicked))
        
        keyboardToolBar.setItems([flexibleSpace, doneButton], animated: true)
        
        redTextField.inputAccessoryView = keyboardToolBar
        greenTextField.inputAccessoryView = keyboardToolBar
        blueTextField.inputAccessoryView = keyboardToolBar
    }
    
    @objc func doneClicked() {
        view.endEditing(true)
        fillEmptyTextFilds()
    }
    
    func fillEmptyTextFilds() {
        if redTextField.text == "" {
            redTextField.text = "\(Double(Int(colour.red*100))/100)"
        }
        if greenTextField.text == "" {
            greenTextField.text = "\(Double(Int(colour.green*100))/100)"
        }
        if blueTextField.text == "" {
            blueTextField.text = "\(Double(Int(colour.blue*100))/100)"
        }
    }
    
    //закрытие клавиатуры при нажатии вне области клавиатуры
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        view.endEditing(true)
        super.touchesBegan(touches, with: event)
        fillEmptyTextFilds()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        //if let red = colour.red, let green = colour.green, let blue = colour.blue {
        redTextField.text = "\(Double(Int(colour.red*100))/100)"
        greenTextField.text = "\(Double(Int(colour.green*100))/100)"
        blueTextField.text = "\(Double(Int(colour.blue*100))/100)"
        
        // }
    }
    
    
    @IBAction func goToGradientViewController() {
        let storyBoard: UIStoryboard = UIStoryboard(name: "Gradient", bundle: nil) //получаем ссылку на сториборд по его имени
        //создаем ViewController используя storyboardID = "viewController2_ID"
        //заранее приводя его к типу ViewController2. тогда можно использовать методы ViewController2
        let newViewController = storyBoard.instantiateViewController(withIdentifier: "GradientViewController_ID") as! GradientViewController
        
        newViewController.backParam = self
        
        //пеердаем параметр в property, а не в Label
        
        newViewController.colour = (colour.red, colour.green, colour.blue)
        
        //отображаем newViewController
        self.navigationController?.pushViewController(newViewController, animated: true)
    }
    
    
    
    @IBAction func colorTextFieldAction(_ sender: UITextField) {
        
        switch sender.tag {
        case 1:
            guard let number = Float(sender.text!) else {return}
            if number >= 0 && number <= 1{
                colour.red = number
                redTextField.text = "\(Double(Int(number*100))/100)"
            }
        case 2:
            guard let number = Float(sender.text!) else {return}
            if number >= 0 && number <= 1{
                colour.green = number
                greenTextField.text = "\(Double(Int(number*100))/100)"
            }
        case 3:
            guard let number = Float(sender.text!) else {return}
            if number >= 0 && number <= 1{
                colour.blue = number
                blueTextField.text = "\(Double(Int(number*100))/100)"
            }
        default :
            break
        }
    }
    
    
}

