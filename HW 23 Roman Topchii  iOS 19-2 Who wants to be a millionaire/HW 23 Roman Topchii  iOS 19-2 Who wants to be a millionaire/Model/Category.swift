//
//  Category.swift
//  HW 23 Roman Topchii  iOS 19-2 Who wants to be a millionaire
//
//  Created by Roman Topchii on 01.02.2020.
//  Copyright © 2020 Roman Topchii. All rights reserved.
//

import Foundation


struct Category : Codable {
    let id : Int64
    let categoryName : String
    let imgURL : String
    let questionURL : String
}
