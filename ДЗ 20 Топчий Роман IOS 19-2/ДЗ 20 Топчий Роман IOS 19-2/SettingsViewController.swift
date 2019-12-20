//
//  SettingsViewController.swift
//  ДЗ 20 Топчий Роман IOS 19-2
//
//  Created by Roman Topchii on 16.12.2019.
//  Copyright © 2019 Roman Topchii. All rights reserved.
//

import UIKit

class SettingsViewController: UIViewController{
    
    var colour : Colour = Colour(red: 0.2, green: 0.3, blue: 0.5)
    
    @IBOutlet weak var mainView: UIView!
    @IBOutlet weak var coloredView: UIView!
    
    @IBOutlet weak var redTextField: UITextField!
    @IBOutlet weak var greenTextField: UITextField!
    @IBOutlet weak var blueTextField: UITextField!
    
    
    
    
    
    
    override func loadView() {
        super.loadView()
        print("Settings VC", #function)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print("Settings VC", #function, colour)
        
        
        fillAllTextFilds()
        
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
        print("Settings VC", #function, colour)
        fillAllTextFilds()
        self.tabBarController?.tabBar.items?[1].badgeValue = nil
        coloredView.backgroundColor = #colorLiteral(red: colour.red, green: colour.green, blue: colour.blue, alpha:1)
    }

    func addBadge() {
        if let currentTabBarIndex = self.tabBarController?.viewControllers?.firstIndex(of: self) {
            if let tabItems = self.tabBarController?.tabBar.items
            {
                // In this case we want to modify the badge number of the third tab:
                let tabItem: UITabBarItem = tabItems[currentTabBarIndex+1]
                tabItem.badgeValue = "*"
                
            }
        }
    }
    
    func transferColorToAnotherVC() { // пересылка значения цвета на другой вью
           guard let tabVC = self.tabBarController else {return}
           guard let vcArray = tabVC.viewControllers else {return}
           guard let vc = vcArray[2] as? GradientViewController else {return}
           vc.colour = colour
       }
    
    
    @objc func doneClicked() {  //обработка нажатия на кнопку done на клавиатуре
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
                redTextField.text = "\(Double(Int(colour.red*100))/100)"
            }
        case 2:
            guard let number = Float(sender.text!) else {return}
            if number >= 0 && number <= 1{
                colour.green = number
                greenTextField.text = "\(Double(Int(colour.green*100))/100)"
            }
        case 3:
            guard let number = Float(sender.text!) else {return}
            if number >= 0 && number <= 1{
                colour.blue = number
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
    
}

