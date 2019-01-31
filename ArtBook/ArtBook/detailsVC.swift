//
//  detailsVC.swift
//  ArtBook
//
//  Created by iamkurtgoz on 12.01.2019.
//  Copyright © 2019 iamkurtgoz. All rights reserved.
//

import UIKit
import CoreData

class detailsVC: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {

    
    @IBOutlet weak var textPaintingYear: UITextField!
    @IBOutlet weak var textPaintingName: UITextField!
    @IBOutlet weak var textArtist: UITextField!
    @IBOutlet weak var imgVieew: UIImageView!
    
    var getterIntentName = "";
    
    override func viewDidLoad() {
        super.viewDidLoad()
        imgVieew.isUserInteractionEnabled = true;
        let gestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(detailsVC.selectImage))
        imgVieew.addGestureRecognizer(gestureRecognizer);
        
        if getterIntentName != "" {
            
            let appDelegate = UIApplication.shared.delegate as! AppDelegate;
            let context = appDelegate.persistentContainer.viewContext;
            
            let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "Paintings");
            fetchRequest.predicate = NSPredicate(format: "name = %@", self.getterIntentName);
            fetchRequest.returnsObjectsAsFaults = false;
            
            do {
                let result = try context.fetch(fetchRequest);
                for row in result as! [NSManagedObject] {
                    if let name = row.value(forKey: "name") as? String {
                        textPaintingName.text = name;
                    }
                    
                    if let artist = row.value(forKey: "artist") as? String {
                        textArtist.text = artist;
                    }
                    
                    if let year = row.value(forKey: "year") as? Int {
                        textPaintingYear.text = String(year);
                    }
                    
                    if let imageData = row.value(forKey: "image") as? Data {
                        let image = UIImage(data: imageData);
                        imgVieew.image = image;
                    }
                }
            } catch {
                
            }
            
        }
    }
    
    @objc func selectImage(){
        let picker = UIImagePickerController();
        picker.delegate = self;
        picker.sourceType = .photoLibrary;
        picker.allowsEditing = true;
        present(picker, animated: true, completion: nil);
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        imgVieew.image = info[.originalImage] as? UIImage;
        self.dismiss(animated: true, completion: nil);
    }
    @IBAction func btnSave(_ sender: Any) {
    
        let appDelegate = UIApplication.shared.delegate as! AppDelegate;
        let context = appDelegate.persistentContainer.viewContext;
        
        let newArt = NSEntityDescription.insertNewObject(forEntityName: "Paintings", into: context);
        
        newArt.setValue(textArtist.text, forKey: "artist");
        newArt.setValue(textPaintingName.text, forKey: "name");
        
        if let year = Int(textPaintingYear.text!){
            newArt.setValue(year, forKey: "year");
        }
        
        let data = imgVieew.image?.jpegData(compressionQuality: 0.5);
        newArt.setValue(data, forKey: "image");
        
        do {
            try context.save();
            print("Success :)");
        } catch {
            print("Error");
        }
        
        NotificationCenter.default.post(name: .init("new"), object: nil);
        self.navigationController?.popViewController(animated: true);
    }
}
