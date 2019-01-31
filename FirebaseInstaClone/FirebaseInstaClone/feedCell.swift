//
//  feedCell.swift
//  FirebaseInstaClone
//
//  Created by iamkurtgoz on 1.02.2019.
//  Copyright © 2019 iamkurtgoz. All rights reserved.
//

import UIKit

class feedCell: UITableViewCell {

    @IBOutlet weak var lblUserName: UILabel!
    @IBOutlet weak var imgContent: UIImageView!
    @IBOutlet weak var lblContent: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
