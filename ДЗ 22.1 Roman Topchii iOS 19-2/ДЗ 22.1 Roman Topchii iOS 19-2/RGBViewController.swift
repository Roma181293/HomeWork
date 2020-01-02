//
//  RGBViewController.swift
//  ДЗ 22.1 Roman Topchii iOS 19-2
//
//  Created by Roman Topchii on 02.01.2020.
//  Copyright © 2020 Roman Topchii. All rights reserved.
//

import UIKit

class RGBViewController: UIViewController {
    
    var color : Color = Color(red: 0.1, green: 0.1, blue: 0.1)
    
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
    
    override func loadView() {
        super.loadView()
        print("  RGB VC ", #function)
        
        loadFromTheUserDefaults()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print("  RGB VC ", #function)
             
        redSlider.value = color.red
        greenSlider.value = color.green
        blueSlider.value = color.blue
        
        fillAllTextFilds()
        
        redLabel.text = "Red:     \(Double(Int(color.red*100))/100)"
        greenLabel.text = "Green: \(Double(Int(color.green*100))/100)"
        blueLabel.text = "Blue:    \(Double(Int(color.blue*100))/100)"
        
        coloredView.backgroundColor = #colorLiteral(red: color.red, green: color.green, blue: color.blue, alpha:1)
        
        //добавление кнопки done на клавиатуру
        let keyboardToolBar = UIToolbar()
        keyboardToolBar.sizeToFit()
        
        let flexibleSpace = UIBarButtonItem(barButtonSystemItem: UIBarButtonItem.SystemItem.flexibleSpace, target: nil, action: nil)
        let doneButton = UIBarButtonItem(barButtonSystemItem: UIBarButtonItem.SystemItem.done, target: self, action: #selector(self.doneClicked))
        
        keyboardToolBar.setItems([flexibleSpace, doneButton], animated: true)
        
        redTextField.inputAccessoryView = keyboardToolBar
        greenTextField.inputAccessoryView = keyboardToolBar
        blueTextField.inputAccessoryView = keyboardToolBar
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        print("  RGB VC ", #function)
        
        fillAllTextFilds()
        
        redLabel.text = "Red:     \(Double(Int(color.red*100))/100)"
        greenLabel.text = "Green: \(Double(Int(color.green*100))/100)"
        blueLabel.text = "Blue:    \(Double(Int(color.blue*100))/100)"
        
        redSlider.value = color.red
        greenSlider.value = color.green
        blueSlider.value = color.blue
        
        coloredView.backgroundColor = UIColor(red: CGFloat(color.red), green: CGFloat(color.green), blue: CGFloat(color.blue), alpha: 1)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(true)
        print("  RGB VC ", #function)
    }
    
  
    
    @objc func doneClicked() { //обработка нажатия на кнопку done на клавиатуре
        view.endEditing(true)
        fillAllTextFilds()
    }
    
    func fillAllTextFilds() {
        print("  RGB VC ", #function)
        redTextField.text = "\(Double(Int(color.red*100))/100)"
        greenTextField.text = "\(Double(Int(color.green*100))/100)"
        blueTextField.text = "\(Double(Int(color.blue*100))/100)"
        saveUserDefaults()
    }
    
    
    func saveUserDefaults() {
        UserDefaults.standard.set(color.red, forKey: "redColor")
        UserDefaults.standard.set(color.green, forKey: "greenColor")
        UserDefaults.standard.set(color.blue, forKey: "blueColor")
        
        print("  RGB VC ", #function)
    }
    
    func loadFromTheUserDefaults() {
        color.red = UserDefaults.standard.object(forKey: "redColor") as? Float ?? 0
        color.green = UserDefaults.standard.object(forKey: "greenColor") as? Float ?? 0
        color.blue = UserDefaults.standard.object(forKey: "blueColor") as? Float ?? 0
        
        print("  RGB VC ", #function, color)
    }
    
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) { //закрытие клавиатуры при нажатии вне области клавиатуры
        view.endEditing(true)
        super.touchesBegan(touches, with: event)
        fillAllTextFilds()
    }
    
    
    
    @IBAction func colorIndexTextFieldAction(_ sender: UITextField) {
        switch sender.tag {
        case 1:
            guard let number = Float(sender.text!) else {return}
            if number >= 0 && number <= 1{
                color.red = number
                redLabel.text = "Red:     \(Double(Int(color.red*100))/100)"
                redSlider.value = color.red
                redTextField.text = "\(Double(Int(color.red*100))/100)"
            }
        case 2:
            guard let number = Float(sender.text!) else {return}
            if number >= 0 && number <= 1{
                color.green = number
                greenLabel.text = "Green: \(Double(Int(color.green*100))/100)"
                greenSlider.value = color.green
                greenTextField.text = "\(Double(Int(color.green*100))/100)"
            }
        case 3:
            guard let number = Float(sender.text!) else {return}
            if number >= 0 && number <= 1{
                color.blue = number
                blueLabel.text = "Blue:    \(Double(Int(color.blue*100))/100)"
                blueSlider.value = color.blue
                blueTextField.text = "\(Double(Int(color.blue*100))/100)"
            }
        default :
            break
        }
        print("  RGB VC ", #function)
        coloredView.backgroundColor = #colorLiteral(red: color.red, green: color.green, blue: color.blue, alpha:1)
        saveUserDefaults()
    }
    
    
    
    @IBAction func sliderAction(_ sender: UISlider) {
        switch sender.tag {
        case 1:
            color.red = sender.value
            redTextField.text = "\(Double(Int(color.red*100))/100)"
            redLabel.text = "Red:     \(Double(Int(color.red*100))/100)"
        case 2:
            color.green = sender.value
            greenTextField.text = "\(Double(Int(color.green*100))/100)"
            greenLabel.text = "Green: \(Double(Int(color.green*100))/100)"
        case 3:
            color.blue = sender.value
            blueTextField.text = "\(Double(Int(color.blue*100))/100)"
            blueLabel.text = "Blue:    \(Double(Int(color.blue*100))/100)"
        default:
            break
        }
        print("  RGB VC ", #function)
        coloredView.backgroundColor = #colorLiteral(red: color.red, green: color.green, blue: color.blue, alpha:1)
        saveUserDefaults()
    }
}


