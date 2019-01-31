//
//  ViewController.swift
//  Timers
//
//  Created by iamkurtgoz on 11.12.2018.
//  Copyright © 2018 iamkurtgoz. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var lblTime: UILabel!
    var timer = Timer()
    var counter = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        counter = 10
        lblTime.text = String(counter)
        
        timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(ViewController.timeSelector), userInfo: nil, repeats: true)
    }

    @objc func timeSelector(){
        lblTime.text = String(counter)
        counter = counter - 1
        if counter == 0 {
            lblTime.text = "Time is OFF!"
            timer.invalidate()
        }
    }
}

