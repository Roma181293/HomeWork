//
//  SecondExerciseViewController.swift
//  HW 26 Topchii Roman iOS 19-2
//
//  Created by Roman Topchii on 20.01.2020.
//  Copyright © 2020 Roman Topchii. All rights reserved.
//

import UIKit
import PKHUD

class SecondExerciseViewController: UIViewController {
    
    var date = Date()
    
    @IBOutlet weak var cur: UILabel!
    @IBOutlet weak var buyNB: UILabel!
    @IBOutlet weak var saleNB: UILabel!
    @IBOutlet weak var buyPB: UILabel!
    @IBOutlet weak var salePB: UILabel!
    
    @IBOutlet weak var datePicker: UIDatePicker!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        datePicker.maximumDate = date
        
        loadData(date : date)
    }
    
    
    @IBAction func changeDate(_ sender: UIDatePicker) {
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd.MM.yyyy"
        
        let datePickerFormatedDate = dateFormatter.string(from:datePicker.date as Date)
        let dateFormated = dateFormatter.string(from:date as Date)
        
        if dateFormated != datePickerFormatedDate {
            date = datePicker.date
            datePicker.isUserInteractionEnabled = false
            loadData(date : datePicker.date)
            
            HUD.flash(.progress, delay: .infinity)
        }
    }
    
    func loadData(date : Date){
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd.MM.yyyy"
        let dateString = dateFormatter.string(from:date as Date)
        
        
        let url = URL(string: "https://api.privatbank.ua/p24api/exchange_rates?json&date=\(dateString)")!
        
        let task = URLSession.shared.dataTask(with: url) {[weak self] (data, response, error) in
            
            guard let data = data else {
                print("ERROR!!!  data == nil")
                return
            }
            
            do {
                
                if let dictOfJsonObjects = try JSONSerialization.jsonObject(with: data, options: .mutableContainers) as? [String: Any] {
                    
                    let currencyHistoricalData : CurrencyHistoricalData = CurrencyHistoricalData(dict: dictOfJsonObjects)
                    
                    DispatchQueue.main.async {
                        var cur = "\(currencyHistoricalData.baseCurrencyLit) to"
                        var buyNB = "Buy NB"
                        var saleNB = "Sale NB"
                        var buyPB = "Buy PB"
                        var salePB = "Sale PB"
            
                        for item in currencyHistoricalData.exchangeRate.list {
                            cur += "\n"+item.currency
                            buyNB += "\n"+item.buyNB
                            saleNB += "\n"+item.saleNB
                            buyPB += "\n"+item.buyPB
                            salePB += "\n"+item.salePB
                        }
                        self?.cur.text = cur
                        self?.buyNB.text = buyNB
                        self?.saleNB.text = saleNB
                        self?.buyPB.text = buyPB
                        self?.salePB.text = salePB
                        self?.datePicker.isUserInteractionEnabled = true
                        HUD.hide()
                    }
                }
                else
                {
                    print("json == nil")
                }
            } catch let error {
                print(error.localizedDescription)
            }
        }
        task.resume()
    }
}
