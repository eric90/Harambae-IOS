//
//  CustomCell.swift
//  bld
//
//  Created by Eric Fakhourian on 11/30/16.
//  Copyright © 2016 Eric Fakhourian. All rights reserved.
//

import UIKit

class CustomCell: UITableViewCell {

    @IBOutlet var ImgCheck: UIImageView!
    @IBOutlet var LblMeal: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
