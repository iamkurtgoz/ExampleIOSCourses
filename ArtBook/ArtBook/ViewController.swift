//
//  ViewController.swift
//  ArtBook
//
//  Created by iamkurtgoz on 12.01.2019.
//  Copyright © 2019 iamkurtgoz. All rights reserved.
//

import UIKit
import CoreData

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var tableView: UITableView!
    
    var nameArray = [String]();
    var artistArray = [String]();
    var yearArray = [Int]();
    var imageArray = [UIImage]();
    
    var senderIntentName = "";
    
    override func viewDidLoad() {
        super.viewDidLoad()
    
        tableView.dataSource = self;
        tableView.delegate = self;
    
        getInfoData();
    }

    override func viewWillAppear(_ animated: Bool) {
        NotificationCenter.default.addObserver(self, selector: #selector(ViewController.getInfoData), name: NSNotification.Name("new"), object: nil)
    }
    
    @objc private func getInfoData(){
        let appDelegate = UIApplication.shared.delegate as! AppDelegate;
        let context = appDelegate.persistentContainer.viewContext;
        
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "Paintings");
        fetchRequest.returnsObjectsAsFaults = false;
        
        do {
            nameArray.removeAll(keepingCapacity: false);
            artistArray.removeAll(keepingCapacity: false);
            yearArray.removeAll(keepingCapacity: false);
            imageArray.removeAll(keepingCapacity: false);
            
            let results = try context.fetch(fetchRequest);
            if  results.count > 0 {
                for row in results as! [NSManagedObject] {
                    
                    if let name = row.value(forKey: "name") as? String {
                        self.nameArray.append(name);
                    }
                    
                    if let artist = row.value(forKey: "artist") as? String {
                        artistArray.append(artist);
                    }
                    
                    if let year = row.value(forKey: "year") as? Int {
                        self.yearArray.append(year);
                    }
                    
                    if let imageData = row.value(forKey: "image") as? Data {
                        let image = UIImage(data: imageData);
                        self.imageArray.append(image!);
                    }
                    self.tableView.reloadData();
                }
            }
        } catch {
            print("Error!");
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        senderIntentName = nameArray[indexPath.row];
        performSegue(withIdentifier: "toDetailsVC", sender: nil);
        tableView.deselectRow(at: indexPath, animated: true);
    }
    
    @IBAction func addButtonClick(_ sender: Any) {
        senderIntentName = "";
        performSegue(withIdentifier: "toDetailsVC", sender: nil);
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return nameArray.count;
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell();
        cell.textLabel?.text = nameArray[indexPath.row];
        return cell;
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        
        if editingStyle == .delete {
            
            let appDelegate = UIApplication.shared.delegate as! AppDelegate;
            let context = appDelegate.persistentContainer.viewContext;
        
            let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "Paintings");
            
            do {
                let result = try context.fetch(fetchRequest);
                for row in result as! [NSManagedObject] {
                    if let name = row.value(forKey: "name") as? String{
                        if name == nameArray[indexPath.row]{
                            context.delete(row);
                            nameArray.remove(at: indexPath.row);
                            artistArray.remove(at: indexPath.row);
                            yearArray.remove(at: indexPath.row);
                            imageArray.remove(at: indexPath.row);
                            self.tableView.reloadData();
                            do {
                                try context.save();
                            } catch {
                                
                            }
                            break;
                        }
                    }
                }
            } catch{
                
            }
        
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "toDetailsVC" {
            let destination = segue.destination as! detailsVC;
            destination.getterIntentName = senderIntentName;
        }
    }
}

