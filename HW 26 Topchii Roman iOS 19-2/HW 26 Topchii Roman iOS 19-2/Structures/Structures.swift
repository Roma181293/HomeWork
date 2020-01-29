//
//  Structures.swift
//  HW 26 Topchii Roman iOS 19-2
//
//  Created by Roman Topchii on 20.01.2020.
//  Copyright © 2020 Roman Topchii. All rights reserved.
//

import Foundation


struct CurrencyExchange {
    var currency : String = "-"
    var baseCurrency : String = "-"
    var buyPB : String = "-"
    var salePB : String = "-"
    var buyNB : String = "-"
    var saleNB : String = "-"
    
    init (_ dict : [String : Any]) {
        
        if dict["ccy"] != nil && dict["base_ccy"] != nil && dict["buy"] != nil && dict["sale"] != nil {
            self.currency = dict["ccy"] as! String
            self.baseCurrency = dict["base_ccy"] as! String
            self.buyPB = dict["buy"] as! String
            self.salePB = dict["sale"] as! String
        }
        
        
        if dict["currency"] != nil {
            self.currency = dict["currency"] as! String
        }
        if dict["baseCurrency"] != nil {
            self.baseCurrency = dict["baseCurrency"] as! String
        }
        if dict["saleRateNB"] != nil  {
            self.saleNB = String(Double(Int(Double(truncating: dict["saleRateNB"] as! NSNumber)*10000))/10000)
        }
        if dict["purchaseRateNB"] != nil  {
            self.buyNB = String(Double(Int(Double(truncating: dict["purchaseRateNB"] as! NSNumber)*10000))/10000)
        }
        
        if dict["purchaseRate"] != nil {
            self.buyPB = String(Double(Int(Double(truncating: dict["purchaseRate"] as! NSNumber)*10000))/10000)
        }
        if dict["saleRate"] != nil  {
            self.salePB = String(Double(Int(Double(truncating: dict["saleRate"] as! NSNumber)*10000))/10000)
        }
        
    }
}

struct CurrencyExchangeList {
    var list : [CurrencyExchange] = []
    
    init(array : [[String : Any]]) {
        for dict in array{
            self.list.append(CurrencyExchange(dict))
        }
    }
}


struct CurrencyHistoricalData {
    var date : String
    var bank : String
    var baseCurrency : NSValue
    var baseCurrencyLit : String
    var exchangeRate : CurrencyExchangeList
    
    init(dict : [String:Any]) {
        self.date = dict["date"] as! String
        self.bank = dict["bank"] as! String
        self.baseCurrency = dict["baseCurrency"] as! NSValue
        self.baseCurrencyLit = dict["baseCurrencyLit"] as! String
        
        self.exchangeRate = CurrencyExchangeList(array: dict["exchangeRate"] as! [[String:Any]])
        
    }
}
