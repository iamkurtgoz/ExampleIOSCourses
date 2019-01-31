//
//  tableVC.swift
//  TravelApp
//
//  Created by iamkurtgoz on 15.01.2019.
//  Copyright © 2019 iamkurtgoz. All rights reserved.
//

import UIKit
import CoreData

class tableVC: UIViewController, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet weak var tableView: UITableView!
    var titleArray = [String]();
    var subtitleArray = [String]();
    var latitudeArray = [Double]();
    var longitudeArray = [Double]();
    
    var choosenTitle = "";
    var choosenSubtitle = "";
    var choosenLatitude: Double = 0;
    var choosenLongitude: Double = 0;
    
    override func viewDidLoad() {
        super.viewDidLoad()

        tableView.delegate = self;
        tableView.dataSource = self;
        
        fetchData();
    }
    
    override func viewWillAppear(_ animated: Bool) {
        NotificationCenter.default.addObserver(self, selector: #selector(tableVC.fetchData), name: NSNotification.Name(rawValue: "newPlace"), object: nil);
    }

    @objc func fetchData(){
        let appDelegate = UIApplication.shared.delegate as! AppDelegate;
        let context = appDelegate.persistentContainer.viewContext;
    
        let request = NSFetchRequest<NSFetchRequestResult>(entityName: "Places");
        request.returnsObjectsAsFaults = false;
        
        do{
            let results = try context.fetch(request);
            if results.count > 0 {
                
                self.titleArray.removeAll(keepingCapacity: false);
                self.subtitleArray.removeAll(keepingCapacity: false);
                self.latitudeArray.removeAll(keepingCapacity: false);
                self.longitudeArray.removeAll(keepingCapacity: false);
                
                for row in results as! [NSManagedObject]{
                    if let title = row.value(forKey: "title") as? String {
                        self.titleArray.append(title);
                    }
                    
                    if let subtitle = row.value(forKey: "subtitle") as? String {
                        self.subtitleArray.append(subtitle);
                    }
                    
                    if let latitude = row.value(forKey: "latitude") as? Double {
                        self.latitudeArray.append(latitude);
                    }
                    
                    if let longitude = row.value(forKey: "longitude") as? Double {
                        self.longitudeArray.append(longitude);
                    }
                    self.tableView.reloadData();
                }
            }
        } catch{
            
        }
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return titleArray.count;
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell()
        cell.textLabel?.text = titleArray[indexPath.row];
        return cell;
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        choosenTitle = titleArray[indexPath.row];
        choosenSubtitle = subtitleArray[indexPath.row]
        choosenLatitude = latitudeArray[indexPath.row]
        choosenLongitude = longitudeArray[indexPath.row]
        
        performSegue(withIdentifier: "toMapVC", sender: nil);
    }
    
    @IBAction func btnAddNewAdress(_ sender: Any) {
        choosenTitle = "";
        performSegue(withIdentifier: "toMapVC", sender: nil);
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "toMapVC"{
            let destinationVC = segue.destination as! mapVC;
            destinationVC.choosenTitle = choosenTitle;
            destinationVC.choosenSubtitle = choosenSubtitle;
            destinationVC.choosenLatitude = choosenLatitude;
            destinationVC.choosenLongitude = choosenLongitude;
        }
    }
}
