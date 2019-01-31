//
//  SecondViewController.swift
//  FirebaseInstaClone
//
//  Created by iamkurtgoz on 31.01.2019.
//  Copyright © 2019 iamkurtgoz. All rights reserved.
//

import UIKit
import Firebase
import FirebaseAuth
import FirebaseStorage
import FirebaseDatabase

class uploadVC: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {

    @IBOutlet weak var imgContent: UIImageView!
    @IBOutlet weak var textComment: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    
        imgContent.isUserInteractionEnabled = true;
        let recognizer = UITapGestureRecognizer(target: self, action: #selector(uploadVC.clickImageView));
        imgContent.addGestureRecognizer(recognizer);
    }

    @objc func clickImageView(){
        let pickerController = UIImagePickerController();
        pickerController.delegate = self;
        pickerController.sourceType = .photoLibrary;
        pickerController.allowsEditing = true;
        present(pickerController, animated: true, completion: nil);
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        imgContent.image = info[.originalImage] as? UIImage;
        self.dismiss(animated: true, completion: nil);
    }
    
    @IBAction func btnUpload(_ sender: Any) {
        
        let storage = Storage.storage();
        let storageRef = storage.reference();
        
        let mediaFolder = storageRef.child("media");
        
        if let data = imgContent.image?.jpegData(compressionQuality: 0.5) {
            let uuid = NSUUID().uuidString + "_" + String(Date().timeIntervalSinceNow);
            let mediaImageRef = mediaFolder.child(uuid + String(Date().timeIntervalSinceNow) + ".png")
            mediaImageRef.putData(data, metadata: nil) { (metaData, error) in
                if error != nil {
                    let alert = UIAlertController(title: "Hata", message: error?.localizedDescription, preferredStyle: UIAlertController.Style.alert);
                    let okButton = UIAlertAction(title: "Ok", style: UIAlertAction.Style.default, handler: nil);
                    alert.addAction(okButton);
                    self.present(alert, animated: true, completion: nil);
                } else {
                    
                    mediaImageRef.downloadURL(completion: { (url, error) in
                        if error == nil {
                            
                            let databaseReferance = Database.database().reference();
                            
                            let imageURL = url?.absoluteString;
                            let postValue = ["image":imageURL!, "postedby":Auth.auth().currentUser!.email!, "posttext":self.textComment.text!, "uuid":uuid] as [String:Any];
                        databaseReferance.child("users").child((Auth.auth().currentUser?.uid)!).child("post").childByAutoId().setValue(postValue);
                            
                            self.imgContent.image = UIImage(named: "selectimage.png");
                            self.textComment.text = "";
                            self.tabBarController?.selectedIndex = 0;
                        }
                    })
                }
            }
        } else {
            print("Error image data.")
        }
        
    }
    
}

