//
//  SettingsViewController.swift
//  ДЗ 20 Топчий Роман IOS 19-2
//
//  Created by Roman Topchii on 16.12.2019.
//  Copyright © 2019 Roman Topchii. All rights reserved.
//

import UIKit

class SettingsViewController: UIViewController{
    
    var colour : (red : Float, green : Float, blue : Float) = (0.2,0.3,0.5)
    var backParam : TransferProtocol?
    
    
    @IBOutlet weak var mainView: UIView!
    @IBOutlet weak var coloredView: UIView!
    
    @IBOutlet weak var redTextField: UITextField!
    @IBOutlet weak var greenTextField: UITextField!
    @IBOutlet weak var blueTextField: UITextField!
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print(colour)
      
        
        redTextField.text = "\(Double(Int(colour.red*100))/100)"
        greenTextField.text = "\(Double(Int(colour.green*100))/100)"
        blueTextField.text = "\(Double(Int(colour.blue*100))/100)"
        
        coloredView.backgroundColor = #colorLiteral(red: colour.red, green: colour.green, blue: colour.blue, alpha:1)
        
        
        let keyboardToolBar = UIToolbar()
        keyboardToolBar.sizeToFit()
        
        let flexibleSpace = UIBarButtonItem(barButtonSystemItem: UIBarButtonItem.SystemItem.flexibleSpace, target: nil, action: nil)
        let doneButton = UIBarButtonItem(barButtonSystemItem: UIBarButtonItem.SystemItem.done, target: self, action: #selector(self.doneClicked))
        
        keyboardToolBar.setItems([flexibleSpace, doneButton], animated: true)
        
        redTextField.inputAccessoryView = keyboardToolBar
        greenTextField.inputAccessoryView = keyboardToolBar
        blueTextField.inputAccessoryView = keyboardToolBar
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(true)
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
    
    
    
    @IBAction func colorIndexTextFieldAction(_ sender: UITextField) {
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
        print(#function, colour)
        coloredView.backgroundColor = #colorLiteral(red: colour.red, green: colour.green, blue: colour.blue, alpha:1)
        
    }
    
    
   
}

