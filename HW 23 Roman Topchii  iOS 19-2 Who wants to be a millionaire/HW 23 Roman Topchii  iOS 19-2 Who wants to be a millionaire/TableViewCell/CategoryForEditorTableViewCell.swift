//
//  CategoryForEditorTableViewCell.swift
//  HW 23 Roman Topchii  iOS 19-2 Who wants to be a millionaire
//
//  Created by Roman Topchii on 24.02.2020.
//  Copyright © 2020 Roman Topchii. All rights reserved.
//

import UIKit

class CategoryForEditorTableViewCell: UITableViewCell {
    
//    var imageURL: URL? {
//        didSet {
//            categoryImg?.image = nil
//            updateUI()
//        }
//    }
    var stringCategoryName: String? {
        didSet {
            categoryName?.text = stringCategoryName
        }
    }
    
    @IBOutlet weak var categoryName: UILabel!
    @IBOutlet weak var categoryImg: UIImageView!
    
    
//    private func updateUI() {
//
//        if let url = imageURL {
//            NetworkService.fetchImage(url: url) { (img, error) in
//                DispatchQueue.main.async {
//                    if url == self.imageURL {
//                        if let img = img {
//                            self.categoryImg?.image = img
//                        }
//                        else {
//                            self.categoryImg?.image = UIImage(named: "placeholderImg")
//                        }
//                    }
//                }
//            }
//        }
//    }
    
    
    
    
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        // Initialization code
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
}
