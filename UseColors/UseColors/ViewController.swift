//
//  ViewController.swift
//  UseColors
//
//  Created by iamkurtgoz on 13.12.2018.
//  Copyright © 2018 iamkurtgoz. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
    }

    @IBAction func btnBlack(_ sender: Any) {
        view.backgroundColor = UIColor.black;
    }
    
    @IBAction func btnPurple(_ sender: Any) {
        view.backgroundColor = UIColor.purple;
    }
    
    @IBAction func btnYellow(_ sender: Any) {
        view.backgroundColor = UIColor.yellow;
    }
    @IBAction func btnGreen(_ sender: Any) {
        view.backgroundColor = UIColor.green;
    }
    
    @IBAction func btnWhite(_ sender: Any) {
        view.backgroundColor = UIColor.white;
    }
    
}

