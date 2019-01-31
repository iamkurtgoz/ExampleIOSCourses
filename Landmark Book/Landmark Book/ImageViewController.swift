//
//  ImageViewController.swift
//  Landmark Book
//
//  Created by iamkurtgoz on 11.01.2019.
//  Copyright © 2019 iamkurtgoz. All rights reserved.
//

import UIKit

class ImageViewController: UIViewController {

    @IBOutlet weak var imgView: UIImageView!
    @IBOutlet weak var lblResult: UILabel!
    
    var landmarkName = "";
    var image = UIImage();
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        imgView.image = image;
        lblResult.text = landmarkName;
    }

}
