//
//  DetailViewController.swift
//  ДЗ 22 Roman Topchii iOS 19-2
//
//  Created by Roman Topchii on 25.12.2019.
//  Copyright © 2019 Roman Topchii. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController {
    
    var emoji : Emoji?
    

    @IBOutlet weak var symbolLabel : UILabel!
    @IBOutlet weak var nameLabel : UILabel!
    @IBOutlet weak var descriptionLabel : UILabel!
    @IBOutlet weak var usageLabel : UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        if let emoji = emoji {
            symbolLabel.text = emoji.symbol
            nameLabel.text = emoji.name
            descriptionLabel.text = emoji.description
            usageLabel.text = emoji.usage
        }
    }

  

}
