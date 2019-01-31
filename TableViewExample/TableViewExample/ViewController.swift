//
//  ViewController.swift
//  TableViewExample
//
//  Created by iamkurtgoz on 12.01.2019.
//  Copyright © 2019 iamkurtgoz. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var tableView: UITableView!

    var teamNames = [String]();
    var teamPositions = [String]();
    var teamImages = [UIImage]();
    
    var senderIntentPlayerDetail = "";
    var senderIntentPlayerImage = UIImage();

    override func viewDidLoad() {
        super.viewDidLoad()
        initTableView();
        addDataForArrays();
    }

    private func initTableView(){
        tableView.dataSource = self;
        tableView.delegate = self;
    }
    
    private func addDataForArrays(){
        teamNames.append("Muslera");
        teamNames.append("Mariano");
        teamNames.append("Maicon");
        teamNames.append("Ozan")
        teamNames.append("Nagatomo");
        teamNames.append("Fernando");
        teamNames.append("Belhanda");
        teamNames.append("Emre");
        teamNames.append("Feghouli");
        teamNames.append("Onyekuru");
        teamNames.append("Sinan");
        
        teamPositions.append("Kaleci");
        teamPositions.append("Sağ Bek");
        teamPositions.append("Stoper");
        teamPositions.append("Stoper");
        teamPositions.append("Sol Bek");
        teamPositions.append("Defansif Orta Saha");
        teamPositions.append("Ofansif Orta Saha");
        teamPositions.append("Ofansif Orta Saha");
        teamPositions.append("Sağ Açık");
        teamPositions.append("Sol Açık");
        teamPositions.append("Forvet");
        
        teamImages.append(UIImage(named: "images/muslera.jpg")!);
        teamImages.append(UIImage(named: "images/mariano.jpg")!);
        teamImages.append(UIImage(named: "images/maicon.jpg")!);
        teamImages.append(UIImage(named: "images/ozan.jpg")!);
        teamImages.append(UIImage(named: "images/yuto.jpg")!);
        teamImages.append(UIImage(named: "images/fernando.jpg")!);
        teamImages.append(UIImage(named: "images/belhanda.jpg")!);
        teamImages.append(UIImage(named: "images/akbaba.jpg")!);
        teamImages.append(UIImage(named: "images/feghouli.jpg")!);
        teamImages.append(UIImage(named: "images/onyekuru.jpg")!);
        teamImages.append(UIImage(named: "images/sinan.jpg")!);
    }
    
    //getSize metodu ile aynı. Dizi boyuntunu belirtmemizi istiyor.
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return teamNames.count;
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) ->  UITableViewCell {
        let cell = UITableViewCell();
        cell.textLabel?.text = teamNames[indexPath.row] + " (" + teamPositions[indexPath.row] + ")";
        return cell;
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        
        if  editingStyle == .delete {
            teamNames.remove(at: indexPath.row)
            teamPositions.remove(at: indexPath.row)
            teamImages.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: UITableView.RowAnimation.fade);
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        senderIntentPlayerImage = teamImages[indexPath.row];
        senderIntentPlayerDetail = teamNames[indexPath.row] + " (" + teamPositions[indexPath.row] + ")";
        performSegue(withIdentifier: "exampleID", sender: nil)
        //seçimi geri kaldırma.
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if segue.identifier == "exampleID" {
            
            let senderIntent = segue.destination as! DetailScreen;
            senderIntent.intentTitle = senderIntentPlayerDetail;
            senderIntent.intentImageView = senderIntentPlayerImage;
        
        }
    }
}

