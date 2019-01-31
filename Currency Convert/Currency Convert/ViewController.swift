//
//  ViewController.swift
//  Currency Convert
//
//  Created by iamkurtgoz on 25.01.2019.
//  Copyright © 2019 iamkurtgoz. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var lblUSD: UILabel!
    @IBOutlet weak var lblTRY: UILabel!
    @IBOutlet weak var lblJPY: UILabel!
    @IBOutlet weak var lblGBF: UILabel!
    @IBOutlet weak var lblCAD: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }

    @IBAction func btnGetRaits(_ sender: Any) {
        let url = URL(string: "http://data.fixer.io/api/latest?access_key=dc03684b36ec78e7419f9c974cdb761e&format=1");
        let session = URLSession.shared;
        let task = session.dataTask(with: url!) { (data, response, error) in
            
            if error != nil {
                let alert = UIAlertController(title: "HATA!", message: error?.localizedDescription, preferredStyle: UIAlertController.Style.alert);
                let okButton = UIAlertAction(title: "OK", style: UIAlertAction.Style.cancel, handler: nil);
                alert.addAction(okButton);
                self.present(alert, animated: true, completion: nil);
            } else {
                
                if data != nil {
                    do {
                        let JSONResult = try JSONSerialization.jsonObject(with: data!, options: JSONSerialization.ReadingOptions.mutableContainers) as! Dictionary<String,AnyObject>;
                        
                        DispatchQueue.main.async {
                            //print(JSONResult);
                            let rates = JSONResult["rates"] as! [String:AnyObject];
                            //print(rates);
                            let cad = String(describing: rates["CAD"]!); //Kanada doları
                            let gbp = String(describing: rates["GBP"]!); //paund
                            let jpy = String(describing: rates["JPY"]!); //Japon yeni
                            let usd = String(describing: rates["USD"]!); //dolar
                            let turkish = String(describing: rates["TRY"]!);
                            
                            self.lblCAD.text = "CAD: " + cad;
                            self.lblGBF.text = "GFP: " + gbp;
                            self.lblJPY.text = "JPY: " + jpy;
                            self.lblUSD.text = "USD: " + usd;
                            self.lblTRY.text = "TRY: " + turkish;
                        }
                        
                    } catch {
                        
                    }
                }
                
            }
        }
        task.resume();
    }
    
}

