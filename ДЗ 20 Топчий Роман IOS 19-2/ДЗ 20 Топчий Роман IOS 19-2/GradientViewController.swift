//
//  GradientViewController.swift
//  ДЗ 19 Топчий Роман iOS 19-2
//
//  Created by Roman Topchii on 10.12.2019.
//  Copyright © 2019 Roman Topchii. All rights reserved.
//

import UIKit

class GradientViewController: UIViewController {
    
    var colour : Colour = Colour(red: 0.2, green: 0.3, blue: 0.5)
    
    
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
    
    override func loadView() {
        super.loadView()
        print("RGB VC", #function, colour)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print("RGB VC", #function, colour)
        redSlider.value = colour.red
        greenSlider.value = colour.green
        blueSlider.value = colour.blue
        
        fillAllTextFilds()
        
        redLabel.text = "Red:     \(Double(Int(colour.red*100))/100)"
        greenLabel.text = "Green: \(Double(Int(colour.green*100))/100)"
        blueLabel.text = "Blue:    \(Double(Int(colour.blue*100))/100)"
        
        coloredView.backgroundColor = #colorLiteral(red: colour.red, green: colour.green, blue: colour.blue, alpha:1)
        
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
        print("RGB VC", #function)
        
        self.tabBarController?.tabBar.items?[2].badgeValue = nil
        
        fillAllTextFilds()
        
        redLabel.text = "Red:     \(Double(Int(colour.red*100))/100)"
        greenLabel.text = "Green: \(Double(Int(colour.green*100))/100)"
        blueLabel.text = "Blue:    \(Double(Int(colour.blue*100))/100)"
        
        redSlider.value = colour.red
        greenSlider.value = colour.green
        blueSlider.value = colour.blue
        coloredView.backgroundColor = #colorLiteral(red: colour.red, green: colour.green, blue: colour.blue, alpha:1)
    }
    
    func transferColorToAnotherVC() { // пересылка значения цвета на другой вью
        guard let tabVC = self.tabBarController else {return}
        guard let vcArray = tabVC.viewControllers else {return}
        guard let vc = vcArray[1] as? SettingsViewController else {return}
        vc.colour = colour
    }
    
    func addBadge() {
        if let currentTabBarIndex = self.tabBarController?.viewControllers?.firstIndex(of: self) {
            if let tabItems = self.tabBarController?.tabBar.items
            {
                // In this case we want to modify the badge number of the third tab:
                let tabItem: UITabBarItem = tabItems[currentTabBarIndex-1]
                tabItem.badgeValue = "*"
                
            }
        }
    }
    
    @objc func doneClicked() { //обработка нажатия на кнопку done на клавиатуре
        view.endEditing(true)
        fillAllTextFilds()
    }
    
    func fillAllTextFilds() {
        print(#function, colour)
        redTextField.text = "\(Double(Int(colour.red*100))/100)"
        greenTextField.text = "\(Double(Int(colour.green*100))/100)"
        blueTextField.text = "\(Double(Int(colour.blue*100))/100)"
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
                colour.red = number
                redLabel.text = "Red:     \(Double(Int(colour.red*100))/100)"
                redSlider.value = colour.red
                redTextField.text = "\(Double(Int(colour.red*100))/100)"
            }
        case 2:
            guard let number = Float(sender.text!) else {return}
            if number >= 0 && number <= 1{
                colour.green = number
                greenLabel.text = "Green: \(Double(Int(colour.green*100))/100)"
                greenSlider.value = colour.green
                greenTextField.text = "\(Double(Int(colour.green*100))/100)"
            }
        case 3:
            guard let number = Float(sender.text!) else {return}
            if number >= 0 && number <= 1{
                colour.blue = number
                blueLabel.text = "Blue:    \(Double(Int(colour.blue*100))/100)"
                blueSlider.value = colour.blue
                blueTextField.text = "\(Double(Int(colour.blue*100))/100)"
            }
        default :
            break
        }
        print(#function, colour)
        coloredView.backgroundColor = #colorLiteral(red: colour.red, green: colour.green, blue: colour.blue, alpha:1)
        transferColorToAnotherVC()
        addBadge()
    }
    
    
    
    @IBAction func sliderAction(_ sender: UISlider) {
        switch sender.tag {
        case 1:
            colour.red = sender.value
            redTextField.text = "\(Double(Int(colour.red*100))/100)"
            redLabel.text = "Red:     \(Double(Int(colour.red*100))/100)"
        case 2:
            colour.green = sender.value
            greenTextField.text = "\(Double(Int(colour.green*100))/100)"
            greenLabel.text = "Green: \(Double(Int(colour.green*100))/100)"
        case 3:
            colour.blue = sender.value
            blueTextField.text = "\(Double(Int(colour.blue*100))/100)"
            blueLabel.text = "Blue:    \(Double(Int(colour.blue*100))/100)"
        default:
            break
        }
        print(#function, colour)
        coloredView.backgroundColor = #colorLiteral(red: colour.red, green: colour.green, blue: colour.blue, alpha:1)
        transferColorToAnotherVC()
        addBadge()
    }
}
