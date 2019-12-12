//
//  GradientViewController.swift
//  ДЗ 19 Топчий Роман iOS 19-2
//
//  Created by Roman Topchii on 10.12.2019.
//  Copyright © 2019 Roman Topchii. All rights reserved.
//

import UIKit

class GradientViewController: UIViewController {
    
    var colour : (red : Float, green : Float, blue : Float) = (0.2,0.3,0.5)
    var backParam : TransferProtocol?
    
    
    @IBOutlet weak var mainView: UIView!
    @IBOutlet weak var coloredView: UIView!
    
    @IBOutlet weak var redTextField: UITextField!
    @IBOutlet weak var greenTextField: UITextField!
    @IBOutlet weak var blueTextField: UITextField!
    
    @IBOutlet weak var redSlider: UISlider!
    @IBOutlet weak var greenSlider: UISlider!
    @IBOutlet weak var blueSlider: UISlider!
    
    
    @IBOutlet weak var redLabel: UILabel!
    @IBOutlet weak var greenLabel: UILabel!
    @IBOutlet weak var blueLabel: UILabel!
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
//        let colour : (red : Float, green : Float, blue : Float) = (0.2,0.3,0.5)
        print(colour)
        redSlider.value = colour.red
        greenSlider.value = colour.green
        blueSlider.value = colour.blue
        
        redTextField.text = "\(Double(Int(colour.red*100))/100)"
        greenTextField.text = "\(Double(Int(colour.green*100))/100)"
        blueTextField.text = "\(Double(Int(colour.blue*100))/100)"
        
        redLabel.text = "Red:     \(Double(Int(colour.red*100))/100)"
        greenLabel.text = "Green: \(Double(Int(colour.green*100))/100)"
        blueLabel.text = "Blue:    \(Double(Int(colour.blue*100))/100)"
        
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
    
    @objc func doneClicked() {
        view.endEditing(true)
        fillEmptyTextFilds()
    }
    
    func fillEmptyTextFilds() {
        if redTextField.text == "" {
            redTextField.text = "\(Double(Int(redSlider.value*100))/100)"
        }
        if greenTextField.text == "" {
            greenTextField.text = "\(Double(Int(greenSlider.value*100))/100)"
        }
        if blueTextField.text == "" {
            blueTextField.text = "\(Double(Int(blueSlider.value*100))/100)"
        }
    }
    
    
    
    //закрытие клавиатуры при нажатии вне области клавиатуры
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        view.endEditing(true)
        super.touchesBegan(touches, with: event)
        fillEmptyTextFilds()
    }
    
    
    
    @IBAction func colorIndexTextFieldAction(_ sender: UITextField) {
        
        var colour : (red : Float, green : Float, blue : Float) = (redSlider.value, greenSlider.value, blueSlider.value)
        
        switch sender.tag {
        case 1:
            guard let number = Float(sender.text!) else {return}
            if number >= 0 && number <= 1{
                colour.red = number
                redLabel.text = "Red:     \(Double(Int(number*100))/100)"
                redSlider.value = colour.red
                redTextField.text = "\(Double(Int(number*100))/100)"
            }
        case 2:
            guard let number = Float(sender.text!) else {return}
            if number >= 0 && number <= 1{
                colour.green = number
                greenLabel.text = "Green: \(Double(Int(number*100))/100)"
                greenSlider.value = colour.green
                greenTextField.text = "\(Double(Int(number*100))/100)"
            }
        case 3:
            guard let number = Float(sender.text!) else {return}
            if number >= 0 && number <= 1{
                colour.blue = number
                blueLabel.text = "Blue:    \(Double(Int(number*100))/100)"
                blueSlider.value = colour.blue
                blueTextField.text = "\(Double(Int(number*100))/100)"
            }
        default :
            break
        }
        print(#function, colour)
        coloredView.backgroundColor = #colorLiteral(red: colour.red, green: colour.green, blue: colour.blue, alpha:1)
        
    }
    
    
    @IBAction func sliderAction(_ sender: UISlider) {
        var colour : (red : Float, green : Float, blue : Float) = (redSlider.value, greenSlider.value, blueSlider.value)
        
        switch sender.tag {
        case 1:
            colour.red = sender.value
            redTextField.text = "\(Double(Int(sender.value*100))/100)"
            redLabel.text = "Red:     \(Double(Int(sender.value*100))/100)"
           backParam!.colour.red = colour.red
        case 2:
            colour.green = sender.value
            greenTextField.text = "\(Double(Int(sender.value*100))/100)"
            greenLabel.text = "Green: \(Double(Int(sender.value*100))/100)"
            backParam!.colour.green = colour.green
        case 3:
            colour.blue = sender.value
            blueTextField.text = "\(Double(Int(sender.value*100))/100)"
            blueLabel.text = "Blue:    \(Double(Int(sender.value*100))/100)"
            backParam!.colour.blue = colour.blue
        default:
            break
        }
        print(#function, colour)
        coloredView.backgroundColor = #colorLiteral(red: colour.red, green: colour.green, blue: colour.blue, alpha:1)
    }
}
