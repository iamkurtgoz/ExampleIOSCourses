//
//  ViewController.swift
//  Segues
//
//  Created by iamkurtgoz on 8.11.2018.
//  Copyright © 2018 iamkurtgoz. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var lblViewController1: UILabel!
    @IBOutlet weak var textUserName: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "fromFirstToSecond" {
            let destinationVC = segue.destination as! SecondViewController;
            destinationVC.name = textUserName.text!;
        }
    }
    @IBAction func btnSave(_ sender: Any) {
        performSegue(withIdentifier: "fromFirstToSecond", sender: nil);
    }
}

