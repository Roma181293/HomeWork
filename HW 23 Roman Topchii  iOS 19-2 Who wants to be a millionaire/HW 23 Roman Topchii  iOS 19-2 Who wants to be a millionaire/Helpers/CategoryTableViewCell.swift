//
//  CategoryTableViewCell.swift
//  HW 23 Roman Topchii  iOS 19-2 Who wants to be a millionaire
//
//  Created by Roman Topchii on 31.01.2020.
//  Copyright © 2020 Roman Topchii. All rights reserved.
//

import UIKit

class CategoryTableViewCell: UITableViewCell {

    
    
    @IBOutlet weak var categoryName: UILabel!
    @IBOutlet weak var categoryImg: UIImageView!
    
    func update(category : Category, img : UIImage) {
        categoryName.text = category.categoryName
        categoryImg.image = img
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
