//
//  TableViewCell.swift
//  Simpson Book
//
//  Created by iamkurtgoz on 12.01.2019.
//  Copyright © 2019 iamkurtgoz. All rights reserved.
//

import UIKit

class TableViewCell: UITableViewCell {

    @IBOutlet weak var lblSubTitle: UILabel!
    @IBOutlet weak var imgHeader: UIImageView!
    @IBOutlet weak var lblName: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func commonInit(simpsonValue: Simpson){
        imgHeader.image = simpsonValue.image;
        lblName.text = simpsonValue.name;
        lblSubTitle.text = simpsonValue.occupation;
    }
}
