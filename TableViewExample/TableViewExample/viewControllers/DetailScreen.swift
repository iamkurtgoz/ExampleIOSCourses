//
//  DetailScreen.swift
//  TableViewExample
//
//  Created by iamkurtgoz on 12.01.2019.
//  Copyright © 2019 iamkurtgoz. All rights reserved.
//

import UIKit

class DetailScreen: UIViewController {

    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var lblDetail: UILabel!
    
    var intentImageView = UIImage();
    var intentTitle = "";
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        imageView.image = intentImageView;
        lblDetail.text = intentTitle;
    }

}
