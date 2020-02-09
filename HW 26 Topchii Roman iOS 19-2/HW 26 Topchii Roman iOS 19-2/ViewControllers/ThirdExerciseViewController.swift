//
//  ThirdExerciseViewController.swift
//  HW 26 Topchii Roman iOS 19-2
//
//  Created by Roman Topchii on 21.01.2020.
//  Copyright © 2020 Roman Topchii. All rights reserved.
//

import UIKit
import CoreLocation

class ThirdExerciseViewController: UIViewController, CLLocationManagerDelegate{
    
    var locationManager = CLLocationManager()
    
    @IBOutlet weak var cityLabel : UILabel!
    @IBOutlet weak var temperatureLabel : UILabel!
    @IBOutlet weak var pressureLabel : UILabel!
    @IBOutlet weak var humidityLabel : UILabel!
    @IBOutlet weak var windSpeedLabel : UILabel!
    @IBOutlet weak var weatherImage : UIImageView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyHundredMeters
        locationManager.requestWhenInUseAuthorization()
        locationManager.startUpdatingLocation()
        
    }
    
//    func fetchImage(iconName: String, completion: @escaping (UIImage?, Error?)-> Void) {
//
//        let finURL = URL(string: "http://openweathermap.org/img/wn/\(iconName)@2x.png")!
//        let task = URLSession.shared.dataTask(with: finURL) { (data, response, error) in
//
//            if let data = data {
//                completion(UIImage(data:data), nil)
//            }
//            else {
//                completion(nil, error)
//            } //if let data = data
//        } //task
//
//        task.resume()
//    }

    
    
    func getWeatherData(latitude : String, longitude : String){
        
        let appid = "98d75809f415032cc06da47ddc41b9fd"
        
        let url = URL(string: "https://api.openweathermap.org/data/2.5/weather?lat=\(latitude)&lon=\(longitude)&appid=\(appid)")! //Основная URL запроса
        
        //формируем запрос
        let task = URLSession.shared.dataTask(with: url) {[weak self] (data, response, error) in
            
            guard let data = data else {
                print("ERROR!!!  data == nil")
                return
            }
            do {
                //create json object from data
                //Получили МАССИВ данных
                if let dictOfJsonObjects = try JSONSerialization.jsonObject(with: data, options: .mutableContainers) as? [String: Any] {
                    print("=======================",dictOfJsonObjects,"=======================")
                    let weather : WeatherData = WeatherData(dict: dictOfJsonObjects)
                    print(weather)
                    
                    DispatchQueue.main.async {
                        
                        
//                        self?.fetchImage(iconName: weather.weatherIcon) { (image, error) in
//                           
//                                if let image = image {
//                                    self?.weatherImage.image = image
//                                }
//                            
//                        }
                        
                        
                        
                        
                        
                        
                        self?.cityLabel.text = weather.cityName
                        self?.temperatureLabel.text = String(weather.temp)+" C"
                        self?.pressureLabel.text = String(weather.pressure)+" mm"
                        self?.humidityLabel.text = String(weather.humidity)+" %"
                        self?.windSpeedLabel.text = String(weather.windSpeed)+" m/c"
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
    
    
    //MARK: - Location Manager Delegate Methods
    /***************************************************************/
    
    
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        let location = locations[locations.count - 1]
        if location.horizontalAccuracy > 0 {
            
            self.locationManager.stopUpdatingLocation()
            
            let latitude = String(location.coordinate.latitude)
            let longitude = String(location.coordinate.longitude)
            getWeatherData(latitude: latitude, longitude: longitude)
        }
    }
    
    
    //Write the didFailWithError method here:
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print(error)
        cityLabel.text = "Location Unavailable"
    }
    
    
}
