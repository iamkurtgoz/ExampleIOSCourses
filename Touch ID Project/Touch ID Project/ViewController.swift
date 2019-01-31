//
//  ViewController.swift
//  Touch ID Project
//
//  Created by iamkurtgoz on 24.01.2019.
//  Copyright © 2019 iamkurtgoz. All rights reserved.
//

import UIKit
import LocalAuthentication

class ViewController: UIViewController {

    @IBOutlet weak var lblStatus: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    
        let autoContext = LAContext();
        var error: NSError?;
        
        if autoContext.canEvaluatePolicy(LAPolicy.deviceOwnerAuthenticationWithBiometrics, error: &error){
            autoContext.evaluatePolicy(LAPolicy.deviceOwnerAuthenticationWithBiometrics, localizedReason: "Gerçekten siz misiniz?") { (isSuccess, isError) in
                if isSuccess {
                    self.lblStatus.text = "Success!";
                } else {
                    self.lblStatus.text = "Error.";
                }
            }
        }
    }

    
}

