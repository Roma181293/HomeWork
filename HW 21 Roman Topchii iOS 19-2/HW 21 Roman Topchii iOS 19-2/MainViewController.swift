//
//  ViewController.swift
//  HW 21 Roman Topchii iOS 19-2
//
//  Created by Roman Topchii on 25.12.2019.
//  Copyright © 2019 Roman Topchii. All rights reserved.
//

import UIKit

class MainViewController: UIViewController {
    
    weak var rgbVC : RGBViewController!
    
    var colour : Colour = Colour(red: 0.2, green: 0.3, blue: 0.9)
    
    
    @IBOutlet weak var redTextField : UITextField!
    @IBOutlet weak var greenTextField : UITextField!
    @IBOutlet weak var blueTextField : UITextField!
    
    
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
        print("Main VC", #function)
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        print("Main VC", #function)
    }
    
    override func loadView() {
        super.loadView()
        print("Main VC", #function)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print("Main VC", #function)
        
        
        fillAllTextFilds()
        
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
        print("Main VC", #function)
        fillAllTextFilds()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(true)
        print("Main VC", #function)
    }
    
    func transferColorToAnotherVC() { // пересылка значения цвета на другой вью и его показ
        print("Main VC", #function)
        rgbVC.colour = colour
        rgbVC.viewWillAppear(true)
    }
    
    
    @objc func doneClicked() { //обработка нажатия на кнопку done на клавиатуре
        view.endEditing(true)
        fillAllTextFilds()
    }
    
    func fillAllTextFilds() {
        print("Main VC", #function)
        redTextField.text = "\(Double(Int(colour.red*100))/100)"
        greenTextField.text = "\(Double(Int(colour.green*100))/100)"
        blueTextField.text = "\(Double(Int(colour.blue*100))/100)"
    }
    
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) { //закрытие клавиатуры при нажатии вне области клавиатуры
        view.endEditing(true)
        super.touchesBegan(touches, with: event)
        fillAllTextFilds()
    }
    
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        print("Main VC", #function)
        if segue.identifier == "rgbSegue" {
            rgbVC = segue.destination as? RGBViewController
            rgbVC.mainVC = self
        }
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
        print("Main VC", #function, colour)
        transferColorToAnotherVC()
       
    }
}

