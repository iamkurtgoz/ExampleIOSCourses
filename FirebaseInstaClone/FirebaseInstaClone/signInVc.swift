//
//  signInVc.swift
//  FirebaseInstaClone
//
//  Created by iamkurtgoz on 31.01.2019.
//  Copyright © 2019 iamkurtgoz. All rights reserved.
//

import Foundation
import UIKit
import Firebase
import FirebaseAuth

class signInVc: UIViewController {
    
    @IBOutlet weak var textEmail: UITextField!
    @IBOutlet weak var textPassword: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @IBAction func btnSignIn(_ sender: Any) {
        if textEmail.text != "" && textPassword.text != "" {
            Auth.auth().signIn(withEmail: textEmail.text!, password: textPassword.text!) { (userData, error) in
                if error != nil {
                    
                    let alert = UIAlertController(title: "Hata", message: error?.localizedDescription, preferredStyle: UIAlertController.Style.alert);
                    let okButton = UIAlertAction(title: "Ok", style: UIAlertAction.Style.default, handler: nil);
                    alert.addAction(okButton);
                    self.present(alert, animated: true, completion: nil);
                    
                } else {
                    UserDefaults.standard.set(userData!.user.email, forKey: "user");
                    UserDefaults.standard.synchronize();
                    
                    let delegate: AppDelegate = UIApplication.shared.delegate as! AppDelegate;
                    delegate.rememberUser();
                }
            }
        } else {
            let alert = UIAlertController(title: "Hata", message: "Boş alan bırakamazsınız.", preferredStyle: UIAlertController.Style.alert);
            let okButton = UIAlertAction(title: "Ok", style: UIAlertAction.Style.default, handler: nil);
            alert.addAction(okButton);
            self.present(alert, animated: true, completion: nil);
        }
    }
    
    @IBAction func btnSignUp(_ sender: Any) {
        if textEmail.text != "" && textPassword.text != "" {
            Auth.auth().createUser(withEmail: textEmail.text!, password: textPassword.text!) { (userData, error) in
                if error != nil {
                    
                    let alert = UIAlertController(title: "Hata", message: error?.localizedDescription, preferredStyle: UIAlertController.Style.alert);
                    let okButton = UIAlertAction(title: "Ok", style: UIAlertAction.Style.default, handler: nil);
                    alert.addAction(okButton);
                    self.present(alert, animated: true, completion: nil);
                    
                } else {
                    UserDefaults.standard.set(userData!.user.email, forKey: "user");
                    UserDefaults.standard.synchronize();
                    
                    let delegate: AppDelegate = UIApplication.shared.delegate as! AppDelegate;
                    delegate.rememberUser();
                }
            }
        } else {
            let alert = UIAlertController(title: "Hata", message: "Boş alan bırakamazsınız.", preferredStyle: UIAlertController.Style.alert);
            let okButton = UIAlertAction(title: "Ok", style: UIAlertAction.Style.default, handler: nil);
            alert.addAction(okButton);
            self.present(alert, animated: true, completion: nil);
        }
    }
}
