//
//  CategoryTableViewCell.swift
//  HW 23 Roman Topchii  iOS 19-2 Who wants to be a millionaire
//
//  Created by Roman Topchii on 31.01.2020.
//  Copyright © 2020 Roman Topchii. All rights reserved.
//

import UIKit

class CategoryTableViewCell: UITableViewCell {
    
    @IBOutlet weak var imageSpiner: UIActivityIndicatorView!
    @IBOutlet weak var loadSpiner: UIActivityIndicatorView!
    
    
    @IBOutlet weak var categoryName: UILabel!
    @IBOutlet weak var categoryImg: UIImageView!
    
    func updateCategory(_ category : Category) {
        categoryName.text = category.categoryName
      
    }
    
    func updateAll(category : Category, img : UIImage) {
         categoryName.text = category.categoryName
         categoryImg.image = img
     }
    
    func startAnimatingSpiner(_ spiner : UIActivityIndicatorView) {
        spiner.isHidden = false
        spiner.startAnimating()
    }
    
    func stopAnimatingSpiner(_ spiner : UIActivityIndicatorView) {
        spiner.stopAnimating()
        spiner.isHidden = true
    }
    
    
    
    
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        loadSpiner.isHidden = true
        imageSpiner.startAnimating()
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
}
