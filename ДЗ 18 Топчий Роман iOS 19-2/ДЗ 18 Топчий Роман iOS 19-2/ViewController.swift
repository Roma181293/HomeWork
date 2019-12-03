//
//  ViewController.swift
//  ДЗ 18 Топчий Роман iOS 19-2
//
//  Created by Roman Topchii on 02.12.2019.
//  Copyright © 2019 Roman Topchii. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

   
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
        
        let colour : (red : Float, green : Float, blue : Float) = (0.2,0.3,0.5)
        print(colour)
        redSlider.value = colour.red
        greenSlider.value = colour.green
        blueSlider.value = colour.blue
        
        redTextField.text = "\(colour.red)"
        greenTextField.text = "\(colour.green)"
        blueTextField.text = "\(colour.blue)"
        
        redLabel.text = "Red:      \(Double(Int(colour.red*100))/100)"
        greenLabel.text = "Green:  \(Double(Int(colour.green*100))/100)"
        blueLabel.text = "Blue:     \(Double(Int(colour.blue*100))/100)"
        
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
    }
    
    
    
    
    @IBAction func colorIndexTextFieldAction(_ sender: UITextField) {
    
        var colour : (red : Float, green : Float, blue : Float) = (redSlider.value, greenSlider.value, blueSlider.value)

        switch sender.tag {
        case 1:
            guard let text = sender.text else {return}
            guard let number = Float(text) else {return}
            if number >= 0 && number <= 1{
                colour.red = number
                redLabel.text = "Red:      \(Double(Int(number*100))/100)"
            }

        case 2:
           guard let text = sender.text else {return}
            guard let number = Float(text) else {return}
            if number >= 0 && number <= 1{
                colour.green = number
                greenLabel.text = "Green:  \(Double(Int(number*100))/100)"
            }
        case 3:
            guard let text = sender.text else {return}
            guard let number = Float(text) else {return}
            if number >= 0 && number <= 1{
                colour.blue = number
                blueLabel.text = "Blue:     \(Double(Int(number*100))/100)"
            }
        default :
            break
        }
         print(colour)
        coloredView.backgroundColor = #colorLiteral(red: colour.red, green: colour.green, blue: colour.blue, alpha:1)

    }
    
    @IBAction func sliderAction(_ sender: UISlider) {
        var colour : (red : Float, green : Float, blue : Float) = (redSlider.value, greenSlider.value, blueSlider.value)
        
        switch sender.tag {
        case 1:
            colour.red = sender.value
            redTextField.text = "\(Double(Int(sender.value*100))/100)"
            redLabel.text = "Red:      \(Double(Int(sender.value*100))/100)"
        case 2:
            colour.green = sender.value
            greenTextField.text = "\(Double(Int(sender.value*100))/100)"
            greenLabel.text = "Green:  \(Double(Int(sender.value*100))/100)"
        default:
            colour.blue = sender.value
            blueTextField.text = "\(Double(Int(sender.value*100))/100)"
            blueLabel.text = "Blue:     \(Double(Int(sender.value*100))/100)"
        }
         print(colour)
        coloredView.backgroundColor = #colorLiteral(red: colour.red, green: colour.green, blue: colour.blue, alpha:1)
        
    }
    
}

