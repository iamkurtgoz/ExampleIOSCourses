//
//  ViewController.swift
//  AlertProject
//
//  Created by iamkurtgoz on 24.11.2018.
//  Copyright © 2018 iamkurtgoz. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var textUsername: UITextField!
    @IBOutlet weak var textPassword: UITextField!
    @IBOutlet weak var textPasswordAgain: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    @IBAction func btnClick(_ sender: Any) {
        if isEmptyControl(customUiTextField: textUsername) || isEmptyControl(customUiTextField: textPassword) || isEmptyControl(customUiTextField: textPasswordAgain) {
            alertDialogExample(title: "Boş bırakılamaz!", message: "Boş alan bırakıldı. Lütfen doldurun.", buttonTitle: "Ok")
        } else if (textPassword.text?.count)! < 6 || (textPasswordAgain.text?.count)! < 6{
            alertDialogExample(title: "Hata", message: "Şifre 6 karakterden küçük olamaz.", buttonTitle: "Ok")
        } else if textPassword.text != textPasswordAgain.text {
            alertDialogExample(title: "Hata", message: "Şifreler uyuşmamakta! Lütfen şifrelerinizi daha özenli girin!", buttonTitle: "Ok")
        } else{
            alertDialogExample(title: "Başarılı", message: "Üye oldunuz. Tebrikler", buttonTitle: "Ok")
        }
        
        
    
    }
    
    func isEmptyControl(customUiTextField: UITextField) -> Bool{
        if  (customUiTextField.text!) == ""{
            return true;
        }
        return false;
    }
    
    func alertDialogExample(title: String, message: String, buttonTitle: String){
        let alertDialog = UIAlertController(title: title, message: message, preferredStyle: UIAlertController.Style.alert);
        let okButton = UIAlertAction(title: buttonTitle, style: .default, handler: nil);
        alertDialog.addAction(okButton);
        self.present(alertDialog, animated: true, completion: nil);
    }
}

