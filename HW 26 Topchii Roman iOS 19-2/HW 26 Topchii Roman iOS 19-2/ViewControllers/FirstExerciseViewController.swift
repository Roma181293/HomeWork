//
//  ViewController.swift
//  HW 26 Topchii Roman iOS 19-2
//
//  Created by Roman Topchii on 20.01.2020.
//  Copyright © 2020 Roman Topchii. All rights reserved.
//

import UIKit

class FirstExerciseViewController: UIViewController {
    
    @IBOutlet weak var usdBuy: UILabel!
    @IBOutlet weak var eurBuy: UILabel!
    @IBOutlet weak var rurBuy: UILabel!
    @IBOutlet weak var btcBuy: UILabel!
    
    @IBOutlet weak var usdSale: UILabel!
    @IBOutlet weak var eurSale: UILabel!
    @IBOutlet weak var rurSale: UILabel!
    @IBOutlet weak var btcSale: UILabel!
    
    @IBOutlet weak var dateLabel: UILabel!
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        usdBuy.text = ""
        eurBuy.text = ""
        rurBuy.text = ""
        btcBuy.text = ""
        
        usdSale.text = ""
        eurSale.text = ""
        rurSale.text = ""
        btcSale.text = ""
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd.MM.yyyy"
        
        dateLabel.text = dateFormatter.string(from:Date() as Date)
        
        refreshData()
    }
    
    
    
func refreshData() {
        
        //обращение к url с параметрами
        //Параметры задаются в массиве query
        let baseURL = URL(string: "https://api.privatbank.ua/p24api/pubinfo")! //Основная URL запроса
        let query: [String: String] = [ //параметры
            "json":"",
            "exchange":"",
            "coursid" : "5",
        ]
        let url = baseURL.withQueries(query)!
        
        let task = URLSession.shared.dataTask(with: url) {[weak self] (data, response, error) in
            
            guard let data = data else {
                print("ERROR!!!  data == nil")
                return
            }
            
            do {
                if let arrayOfJsonObjects = try JSONSerialization.jsonObject(with: data, options: .mutableContainers) as? [[String: Any]] {
                    print("=======================",arrayOfJsonObjects,"=======================")
                    let currencyList : CurrencyExchangeList = CurrencyExchangeList(array: arrayOfJsonObjects)
                    
                    DispatchQueue.main.async {
                        for currency in currencyList.list {
                            if currency.currency == "USD"{
                                self?.usdBuy.text = currency.buyPB
                                self?.usdSale.text = currency.salePB
                            }
                            if currency.currency == "EUR"{
                                self?.eurBuy.text = currency.buyPB
                                self?.eurSale.text = currency.salePB
                            }
                            if currency.currency == "RUR"{
                                self?.rurBuy.text = currency.buyPB
                                self?.rurSale.text = currency.salePB
                            }
                            if currency.currency == "BTC"{
                                self?.btcBuy.text = currency.buyPB
                                self?.btcSale.text = currency.salePB
                            }
                        }
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




extension URL {
    func withQueries(_ queries: [String: String]) -> URL? {
        var components = URLComponents(url: self, resolvingAgainstBaseURL: true)
        components?.queryItems = queries.compactMap { URLQueryItem(name: $0.0, value: $0.1) }
        return components?.url
    }
}
