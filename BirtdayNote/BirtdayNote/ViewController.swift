//
//  ViewController.swift
//  BirtdayNote
//
//  Created by iamkurtgoz on 3.11.2018.
//  Copyright © 2018 iamkurtgoz. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    private var NAME: String = "NAME";
    private var BIRTHDAY: String = "BIRTHDAY";
    
    @IBOutlet weak var textBirthday: UITextField!
    @IBOutlet weak var textName: UITextField!
    @IBOutlet weak var lblName: UILabel!
    @IBOutlet weak var lblBirthday: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let name = UserDefaults.standard.object(forKey: NAME);
        let birthday = UserDefaults.standard.object(forKey: BIRTHDAY);
        
        if let newName = name as? String {
            if let newBirthday = birthday as? String{
                lblName.text = "Name: \(newName)";
                lblBirthday.text = "Birthday: \(newBirthday)";
            }
        }
    }

    @IBAction func btnSave(_ sender: Any) {
        let name = String(textName.text!);
        let birthday = String(textBirthday.text!);
        
        lblName.text = "Name : " + name;
        lblBirthday.text = "Birthday : " + birthday;
        
        UserDefaults.standard.set(name, forKey: NAME);
        UserDefaults.standard.set(birthday, forKey: BIRTHDAY);
        UserDefaults.standard.synchronize();
    }
    
    @IBAction func btnDelete(_ sender: Any) {
        let name = UserDefaults.standard.object(forKey: NAME);
        let birthday = UserDefaults.standard.object(forKey: BIRTHDAY);
        
        if (name as? String) != nil {
            if (birthday as? String) != nil{
                UserDefaults.standard.removeObject(forKey: NAME);
                UserDefaults.standard.removeObject(forKey: BIRTHDAY);
                UserDefaults.standard.synchronize();
                lblName.text = "Name: ";
                lblBirthday.text = "Birthday: ";
            }
        }
    }
}

