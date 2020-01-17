//
//  ArhiveTableViewCell.swift
//  HW 23 Roman Topchii  iOS 19-2 Who wants to be a millionaire
//
//  Created by Roman Topchii on 10.01.2020.
//  Copyright © 2020 Roman Topchii. All rights reserved.
//

import UIKit

class ArchiveTableViewCell: UITableViewCell {
    var date : String?
    var memo : String?
    
    
    
    @IBOutlet weak var resultLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    
    func update(date : String, memo : String) {
        self.date = date
        self.memo = memo
        
        resultLabel.text = memo
        dateLabel.text = date
    }
    
    
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
