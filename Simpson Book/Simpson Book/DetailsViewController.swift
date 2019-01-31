//
//  DetailsViewController.swift
//  Simpson Book
//
//  Created by iamkurtgoz on 12.01.2019.
//  Copyright © 2019 iamkurtgoz. All rights reserved.
//

import UIKit

class DetailsViewController: UIViewController {

    @IBOutlet weak var imgResult: UIImageView!
    
    var getterIntentSimspson = Simpson();
    
    override func viewDidLoad() {
        super.viewDidLoad()

        imgResult.image = getterIntentSimspson.image;
        self.title = getterIntentSimspson.name;
    }
}
