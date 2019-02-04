//
//  signInVC.swift
//  ParseInstaClone
//
//  Created by iamkurtgoz on 1.02.2019.
//  Copyright © 2019 iamkurtgoz. All rights reserved.
//

import Foundation
import UIKit
import Parse

class signInVC: UIViewController {
    
    @IBOutlet weak var textUsername: UITextField!
    @IBOutlet weak var textPassword: UITextField!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        /*
        let parseObject = PFObject(className: "Fruits")
        parseObject["name"] = "Banana";
        parseObject["calories"] = 150;
        parseObject.saveInBackground { (isSuccess, error) in
            if error != nil {
                print(error?.localizedDescription);
            } else {
                print("Success.")
            }
        }
        
        let query = PFQuery(className: "Fruits");
        query.whereKey("calories", greaterThan: 100)
        query.findObjectsInBackground { (objects, error) in
            if error != nil {
                print(error?.localizedDescription);
            } else {
                print(objects)
            }
        }*/
    }
    
    @IBAction func btnSignIn(_ sender: Any) {
        if textUsername.text != "" && textPassword.text != "" {
            
            PFUser.logInWithUsername(inBackground: textUsername.text!, password: textPassword.text!) { (user, error) in
                if error != nil {
                    let alert = UIAlertController(title: "Hata", message: error?.localizedDescription, preferredStyle: UIAlertController.Style.alert);
                    let action = UIAlertAction(title: "Ok", style: UIAlertAction.Style.cancel, handler: nil);
                    alert.addAction(action);
                    self.present(alert, animated: true, completion: nil);
                } else {
                    UserDefaults.standard.set(self.textUsername.text, forKey: "username");
                    UserDefaults.standard.synchronize();
                    (UIApplication.shared.delegate as! AppDelegate).rememberUser()
                }
            }
            
        } else {
            let alert = UIAlertController(title: "Hata", message: "Boş alan bırakma.", preferredStyle: UIAlertController.Style.alert);
            let action = UIAlertAction(title: "Ok", style: UIAlertAction.Style.cancel, handler: nil);
            alert.addAction(action);
            self.present(alert, animated: true, completion: nil);
        }
    }
    
    @IBAction func btnSignUp(_ sender: Any) {
        
        if textUsername.text != "" && textPassword.text != "" {
            let user = PFUser()
            user.username = textUsername.text;
            user.password = textPassword.text;
            
            user.signUpInBackground { (isSuccess, error) in
                if error != nil {
                    let alert = UIAlertController(title: "Hata", message: error?.localizedDescription, preferredStyle: UIAlertController.Style.alert);
                    let action = UIAlertAction(title: "Ok", style: UIAlertAction.Style.cancel, handler: nil);
                    alert.addAction(action);
                    self.present(alert, animated: true, completion: nil);
                } else {
                    UserDefaults.standard.set(self.textUsername.text, forKey: "username");
                    UserDefaults.standard.synchronize();
                    (UIApplication.shared.delegate as! AppDelegate).rememberUser()
                }
            }
            
        } else {
            let alert = UIAlertController(title: "Hata", message: "Boş alan bırakma.", preferredStyle: UIAlertController.Style.alert);
            let action = UIAlertAction(title: "Ok", style: UIAlertAction.Style.cancel, handler: nil);
            alert.addAction(action);
            self.present(alert, animated: true, completion: nil);
        }
    }
    
    
    
}
