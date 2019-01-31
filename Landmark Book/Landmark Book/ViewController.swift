//
//  ViewController.swift
//  Landmark Book
//
//  Created by iamkurtgoz on 11.01.2019.
//  Copyright © 2019 iamkurtgoz. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {

    @IBOutlet weak var tableView: UITableView!
    
    var landmarks = [String]();
    var images = [UIImage]();
    
    var selectedLandMarkName = "";
    var selectedLandMarkImage = UIImage();
    
    override func viewDidLoad() {
        super.viewDidLoad()
    
        tableView.dataSource = self;
        tableView.delegate = self;
    
        landmarks.append("Colloseum");
        landmarks.append("Great Wall");
        landmarks.append("İstanbul");
        landmarks.append("Kremlin");
        landmarks.append("Stonehenge");
        
        images.append(UIImage(named: "colosseum.jpg")!);
        images.append(UIImage(named: "greatwall.jpg")!);
        images.append(UIImage(named: "istanbul.jpg")!);
        images.append(UIImage(named: "kremlin.jpg")!);
        images.append(UIImage(named: "stonehenge.jpg")!);
    
    }

    //tabloda kaç satır olması gerektiğini istiyor. Adapter içinde getSize metodu gibi.
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return landmarks.count;
    }
    
    //kaydırma durumunda olacak olan kodlar.
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        
        if  editingStyle == .delete {
            landmarks.remove(at: indexPath.row);
            images.remove(at: indexPath.row);
            tableView.deleteRows(at: [indexPath], with: UITableView.RowAnimation.fade)
        }
    }
    
    //satır seçildiğinde ne olur onu yazıyoruz.
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        //diğer ekrana yönlendirme işlemi.
        selectedLandMarkName = landmarks[indexPath.row];
        selectedLandMarkImage = images[indexPath.row];
        performSegue(withIdentifier: "toImageVC", sender: nil)
    }
    
    //tablo içeriğini ekleme. içerik for döngüsü gibi çalışmakta
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell();
        cell.textLabel?.text = landmarks[indexPath.row]
        return cell;
    }

    //yönlendirme fonksiyonu
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if  segue.identifier == "toImageVC" {
            
            let destinationVC = segue.destination as! ImageViewController;
            destinationVC.landmarkName = selectedLandMarkName;
            destinationVC.image = selectedLandMarkImage;
        }
    }
}

