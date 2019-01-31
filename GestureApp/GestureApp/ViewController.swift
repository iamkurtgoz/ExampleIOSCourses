//
//  ViewController.swift
//  GestureApp
//
//  Created by iamkurtgoz on 11.12.2018.
//  Copyright © 2018 iamkurtgoz. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var imgView: UIImageView!
    @IBOutlet weak var lblName: UILabel!
    
    var isKirkOn: Bool = true;
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        imgView.isUserInteractionEnabled = true;
        let gestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(ViewController.clickPick));
        imgView.addGestureRecognizer(gestureRecognizer);
    }
    
    @objc func clickPick(){
        if isKirkOn {
            imgView.image = UIImage(named: "muslera.jpeg");
            lblName.text = "Muslera";
            isKirkOn = false;
        } else {
            imgView.image = UIImage(named: "kirk.jpeg");
            lblName.text = "Kirk";
            isKirkOn = true;
        }
    }
}

