//
//  WeatherStructures.swift
//  HW 26 Topchii Roman iOS 19-2
//
//  Created by Roman Topchii on 24.01.2020.
//  Copyright © 2020 Roman Topchii. All rights reserved.
//

import UIKit

struct WeatherData {
    
    var cityName : String = "Connection Issue"
    var temp : Int = 0
    var pressure : Double = 0
    var humidity : Double = 0
    var windSpeed : Double = 0
    var weatherIcon : String = ""
    
    
    private var rabish = ""
    
    init(dict : [String:Any]){
        self.cityName = dict["name"] as! String
        
        let weather = dict["weather"] as! [[String:Any]]
        self.weatherIcon = weather[0]["icon"] as! String
        
        let main = dict["main"] as! [String:Double]
        self.temp = Int(main["temp"]! - 273.15)
        self.pressure = main["pressure"]!
        self.humidity = main["humidity"]!
        
        let wind = dict["wind"] as! [String:Double]
        self.windSpeed = wind["speed"]!
        print("init - done")
    }
    
}
