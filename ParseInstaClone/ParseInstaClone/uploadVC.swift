//
//  SecondViewController.swift
//  ParseInstaClone
//
//  Created by iamkurtgoz on 1.02.2019.
//  Copyright © 2019 iamkurtgoz. All rights reserved.
//

import UIKit
import Parse

class uploadVC: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate{

    @IBOutlet weak var imgHeader: UIImageView!
    @IBOutlet weak var textTitle: UITextField!
    @IBOutlet weak var btnUpload: UIButton!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        imgHeader.isUserInteractionEnabled = true;
        let recognizer = UITapGestureRecognizer(target: self, action: #selector(uploadVC.selectImage));
        imgHeader.addGestureRecognizer(recognizer);
        
        let allRecognizer = UITapGestureRecognizer(target: self, action: #selector(uploadVC.allClickView))
        self.view.addGestureRecognizer(allRecognizer);
        
        btnUpload.isEnabled = false;
    }

    @objc func selectImage(){
        let picker = UIImagePickerController()
        picker.delegate = self;
        picker.sourceType = .photoLibrary;
        picker.allowsEditing = true;
        self.present(picker, animated: true, completion: nil);
        btnUpload.isEnabled = true;
    }
    
    @objc func allClickView(){
        self.view.endEditing(true);
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        imgHeader.image = info[.originalImage] as! UIImage;
        self.dismiss(animated: true, completion: nil);
    }

    @IBAction func btnUpload(_ sender: Any) {
        btnUpload.isEnabled = false;
        
        let data = imgHeader.image?.jpegData(compressionQuality: 0.5);
        let pfFile = PFFileObject(name: "image", data: data!);
        let uuid = NSUUID.init().uuidString;
        
        let object = PFObject(className: "Posts");
        object["postcomment"] = textTitle.text;
        object["postowner"] = PFUser.current()?.username;
        object["image"] = pfFile;
        object["postuuid"] = uuid + "_" + ((PFUser.current()?.username)!);
        
        object.saveInBackground { (isSuccess, error) in
            self.btnUpload.isEnabled = true;
            if error != nil {
                let alert = UIAlertController(title: "Hata", message: error?.localizedDescription, preferredStyle: UIAlertController.Style.alert);
                let action = UIAlertAction(title: "Ok", style: UIAlertAction.Style.cancel, handler: nil);
                alert.addAction(action);
                self.present(alert, animated: true, completion: nil);
            } else {
                self.tabBarController?.selectedIndex = 0;
                self.imgHeader.image = UIImage(named: "indir.png");
                self.textTitle.text = "";
                
                NotificationCenter.default.post(name: NSNotification.Name("new"), object: nil);
            }
        }
    }
}

