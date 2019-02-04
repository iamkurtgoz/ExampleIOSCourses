//
//  ViewController.swift
//  Inteligatent Image
//
//  Created by iamkurtgoz on 4.02.2019.
//  Copyright © 2019 iamkurtgoz. All rights reserved.
//

import UIKit
import CoreML
import Vision

class ViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {

    @IBOutlet weak var imgPicture: UIImageView!
    @IBOutlet weak var lblResult: UILabel!
    var choosenImage = CIImage();
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    @IBAction func btnChangePicture(_ sender: Any) {
        let picture = UIImagePickerController();
        picture.delegate = self;
        picture.allowsEditing = true;
        picture.sourceType = .photoLibrary;
        self.present(picture, animated: true, completion: nil);
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        var dataImage = info[.originalImage] as! UIImage;
        imgPicture.image = dataImage;
        self.dismiss(animated: true, completion: nil);
        
        if let ciImage = CIImage(image: dataImage) {
            self.choosenImage = ciImage;
        }
        selectedImageResult(image: choosenImage);
    }
    
    func selectedImageResult(image: CIImage){
        lblResult.text = "Finding...";
        if let model = try? VNCoreMLModel(for: GoogLeNetPlaces().model){
            let request = VNCoreMLRequest(model: model) { (nvrequest, error) in
                if error != nil {
                    self.lblResult.text = error?.localizedDescription;
                } else {
                    if let results = nvrequest.results as? [VNClassificationObservation]{
                        
                        DispatchQueue.main.async {
                            
                            for topresults in results {
                                let conf = (topresults.confidence) * 100;
                                let rounded = Int (conf * 100) / 100
                                self.lblResult.text = String(rounded) + "% it's " + String(describing: (topresults.identifier));
                                print(self.lblResult.text)
                            }
                        }
                    }
                }
            }
            
            let handler = VNImageRequestHandler(ciImage: image)
            DispatchQueue.global(qos: .userInteractive).async {
                
                do {
                    
                    try handler.perform([request])
                    
                } catch {
                    print("error")
                }
                
            }
        }
    }
}

