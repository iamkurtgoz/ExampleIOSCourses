//
//  ViewController.swift
//  ObjecjWithCode
//
//  Created by iamkurtgoz on 29.10.2018.
//  Copyright © 2018 iamkurtgoz. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    let myLabel = UILabel();
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let width = view.frame.width;
        let height = view.frame.height;
        
        myLabel.text = "My label";
        myLabel.textAlignment = NSTextAlignment.center;
        myLabel.frame = CGRect(x: 0, y: height * 0.5, width: width, height: 50);
        view.addSubview(myLabel);
        
        let myButton = UIButton();
        myButton.frame = CGRect(x: 0, y: height * 0.7, width: width, height: 50);
        myButton.setTitle("Click and Look Result!", for: UIControl.State.normal);
        myButton.setTitleColor(UIColor.blue, for: UIControl.State.normal);
        view.addSubview(myButton);
        
        myButton.addTarget(self, action: #selector(ViewController.changeText),for: .touchUpInside)
    }

    var i = 0;
    @objc func changeText(){
        i = i + 1
        myLabel.text = "Click this button. Click count : " + String(i);
    }

}

