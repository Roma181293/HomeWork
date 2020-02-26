//
//  NetworkService.swift
//  HW 23 Roman Topchii  iOS 19-2 Who wants to be a millionaire
//
//  Created by Roman Topchii on 30.01.2020.
//  Copyright © 2020 Roman Topchii. All rights reserved.
//

import UIKit


class NetworkService {
    

    static func fetchQuestions(url: URL, completion: @escaping ([Question]?, Error?)-> Void) {
        let sessionConfig = URLSessionConfiguration.default
        sessionConfig.timeoutIntervalForRequest = 10
        sessionConfig.timeoutIntervalForResource = 30
        let session = URLSession(configuration: sessionConfig)
        //URLSession.shared.configuration = sessionConfig
        let task = session.dataTask(with: url) { (data, response, error) in
            let jsonDecoder = JSONDecoder()
            if let data = data {
                do {
                    let questions = try jsonDecoder.decode([Question].self, from: data)
                    print("questions: \(questions)")
                    completion(questions, nil)
                    
                } catch { //let error as NSError {
                    print("ERROR: \(error.localizedDescription)")
                    completion(nil, error)
                }//do-catch
            } //if let data = data
            else {
                print("ERROR: \(String(describing: error?.localizedDescription))")
                completion(nil, error)
            }
        } //task
        
        task.resume()
    }
    
    
    static func fetchCategory(url: URL, completion: @escaping ([Category]?, Error?)-> Void) {
        
        let sessionConfig = URLSessionConfiguration.default
        sessionConfig.timeoutIntervalForRequest = 10
        sessionConfig.timeoutIntervalForResource = 30
        let session = URLSession(configuration: sessionConfig)
        
        let task = session.dataTask(with: url) { (data, response, error) in
            let jsonDecoder = JSONDecoder()
            if let data = data {
                do {
                    let categories = try jsonDecoder.decode([Category].self, from: data)
                    print("categories: \(categories)")
                    completion(categories, nil)
                    
                } catch { //let error as NSError {
                    print("ERROR: \(error.localizedDescription)")
                    completion(nil, error)
                }//do-catch
            } //if let data = data
            else {
                print("ERROR: \(String(describing: error?.localizedDescription))")
                completion(nil, error)
            }
        } //task
        
        task.resume()
    }
    
    
    static func fetchVersion(url: URL, completion: @escaping (Version?, Error?)-> Void) {
           
           let sessionConfig = URLSessionConfiguration.default
           sessionConfig.timeoutIntervalForRequest = 10
           sessionConfig.timeoutIntervalForResource = 30
           let session = URLSession(configuration: sessionConfig)
           
           let task = session.dataTask(with: url) { (data, response, error) in
               let jsonDecoder = JSONDecoder()
               if let data = data {
                   do {
                       let version = try jsonDecoder.decode(Version.self, from: data)
                       print("version: \(version)")
                       completion(version, nil)
                       
                   } catch { //let error as NSError {
                       print("ERROR: \(error.localizedDescription)")
                       completion(nil, error)
                   }//do-catch
               } //if let data = data
               else {
                print("ERROR: \(String(describing: error?.localizedDescription))")
                   completion(nil, error)
               }
           } //task
           
           task.resume()
       }
    
//    static func fetchImage(url: URL, completion: @escaping (Data?, Error?)-> Void) {
         static func fetchImage(url: URL, completion: @escaping (UIImage?, Error?)-> Void) {
        
        let sessionConfig = URLSessionConfiguration.default
        sessionConfig.timeoutIntervalForRequest = 10
        sessionConfig.timeoutIntervalForResource = 30
        let session = URLSession(configuration: sessionConfig)
        
        let task = session.dataTask(with: url) { (data, response, error) in
            
            if let data = data {
//                completion(data, nil)
                completion(UIImage(data: data), nil)
            }
            else {
                print("ERROR: \(String(describing: error?.localizedDescription))")
                completion(nil, error)
            } //if let data = data
        } //task
        
        task.resume()
    }
    
    
    
    
    
    
}
