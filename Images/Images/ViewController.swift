//
//  ViewController.swift
//  Images
//
//  Created by iamkurtgoz on 27.11.2018.
//  Copyright © 2018 iamkurtgoz. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
 
    @IBOutlet weak var imgView: UIImageView!
    private var imgName : String!;
    override func viewDidLoad() {
        super.viewDidLoad()
        imgName = "muslera.jpeg";
        imgView.image = UIImage(named: imgName);
    }

    @IBAction func btnChanges(_ sender: Any) {
        if imgName == "muslera.jpeg"{
            imgName = "kirk.jpeg";
        } else if imgName == "kirk.jpeg"{
            imgName = "muslera.jpeg";
        }
        imgView.image = UIImage(named: imgName);
    }
    
}

