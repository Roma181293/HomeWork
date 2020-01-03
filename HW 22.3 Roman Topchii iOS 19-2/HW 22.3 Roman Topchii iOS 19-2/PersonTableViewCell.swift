//
//  PersonTableViewCell.swift
//  HW 22.3 Roman Topchii iOS 19-2
//
//  Created by Roman Topchii on 03.01.2020.
//  Copyright © 2020 Roman Topchii. All rights reserved.
//

import UIKit

class PersonTableViewCell: UITableViewCell {
    
    
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var dynastyLabel: UILabel!
    
    @IBOutlet weak var photoImage: UIImageView!
    @IBOutlet weak var dynastyLogoImage: UIImageView!
    
    
    var person: Person?
    
    func update(with person: Person?) {
        // Задаем параметры для отображения
        if let photo = person?.photo {
            photoImage.image = UIImage(named: photo)
        }
        if let logo = person?.dynastyLogo {
            dynastyLogoImage.image = UIImage(named: logo)
        }
        nameLabel.text = person?.name
        dynastyLabel.text = person?.dynasty
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
