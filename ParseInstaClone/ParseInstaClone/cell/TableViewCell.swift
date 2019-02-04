//
//  TableViewCell.swift
//  ParseInstaClone
//
//  Created by iamkurtgoz on 3.02.2019.
//  Copyright © 2019 iamkurtgoz. All rights reserved.
//

import UIKit
import Parse

class TableViewCell: UITableViewCell {

    @IBOutlet weak var textUsername: UILabel!
    @IBOutlet weak var textUUID: UILabel!
    @IBOutlet weak var imgHeader: UIImageView!
    @IBOutlet weak var textComment: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
        textUUID.isHidden = true;
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    @IBAction func btnLike(_ sender: UIButton) {
        let likeObject = PFObject(className: "likes");
        likeObject["from"] = PFUser.current()?.username;
        likeObject["to"] = textUUID.text;
        likeObject.saveInBackground { (isSucces, error) in
            if error != nil {
                let alert = UIAlertController(title: "Hata", message: error?.localizedDescription, preferredStyle: UIAlertController.Style.alert);
                let action = UIAlertAction(title: "Ok", style: UIAlertAction.Style.cancel, handler: nil);
                alert.addAction(action);
                UIApplication.shared.keyWindow?.rootViewController!.present(alert, animated: true, completion: nil);
            } else {
                print("save")
            }
        }
    }
    
    @IBAction func btnComment(_ sender: UIButton) {
        let commentObject = PFObject(className: "comments");
        commentObject["from"] = PFUser.current()?.username;
        commentObject["to"] = textUUID.text;
        commentObject.saveInBackground { (isSucces, error) in
            if error != nil {
                let alert = UIAlertController(title: "Hata", message: error?.localizedDescription, preferredStyle: UIAlertController.Style.alert);
                let action = UIAlertAction(title: "Ok", style: UIAlertAction.Style.cancel, handler: nil);
                alert.addAction(action);
                UIApplication.shared.keyWindow?.rootViewController!.present(alert, animated: true, completion: nil);
            } else {
                print("save")
            }
        }
    }
    
    
    
    
}
