//
//  SecondViewController.swift
//  Segues
//
//  Created by iamkurtgoz on 8.11.2018.
//  Copyright © 2018 iamkurtgoz. All rights reserved.
//

import UIKit

class SecondViewController: UIViewController {

    @IBOutlet weak var lblUserName: UILabel!
    @IBOutlet weak var lblViewController2: UILabel!
    
    var name: String = "";
    
    override func viewDidLoad() {
        super.viewDidLoad()

        if  name != ""{
            lblUserName.text = "User Name : \(name)";
        } else {
            lblUserName.text = "";
        }
    }
    
    
    @IBAction func backView(_ sender: Any) {
        self.dismiss(animated: true, completion: nil);
    }
}
