//
//  FirstViewController.swift
//  FirebaseInstaClone
//
//  Created by iamkurtgoz on 31.01.2019.
//  Copyright © 2019 iamkurtgoz. All rights reserved.
//

import UIKit
import Firebase
import FirebaseAuth
import FirebaseDatabase
import SDWebImage

class feedVC: UIViewController, UITableViewDelegate, UITableViewDataSource {

    var emailsArray = [String]();
    var commentsArray = [String]();
    var imagesArray = [String]();
    
    @IBOutlet weak var feedTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        feedTableView.delegate = self;
        feedTableView.dataSource = self;
        
        getDataFromDatabase()
    }

    func getDataFromDatabase(){
        let databaseRef = Database.database().reference();
        
        databaseRef.child("users").observe(DataEventType.childAdded) { (snapshot) in
            let values = snapshot.value! as! NSDictionary;
            let posts = values["post"] as! NSDictionary;
            let postID = posts.allKeys;
            for id in postID {
                let singleRow = posts[id] as! NSDictionary;
                
                self.emailsArray.append(singleRow["postedby"] as! String)
                self.commentsArray.append(singleRow["posttext"] as! String)
                self.imagesArray.append(singleRow["image"] as! String)
            }
            self.feedTableView.reloadData();
        }
    }
    
    @IBAction func btnLogout(_ sender: Any) {
        UserDefaults.standard.removeObject(forKey: "user");
        UserDefaults.standard.synchronize();
        do {
            try Auth.auth().signOut();
        } catch {
            print(error)
        }
        (UIApplication.shared.delegate as! AppDelegate).rememberUser();
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return emailsArray.count;
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 282;
    }
     
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = self.feedTableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as! feedCell;
        
        cell.lblUserName.text = emailsArray[indexPath.row];
        cell.lblContent.text = commentsArray[indexPath.row];
        cell.imageView?.sd_setImage(with: URL(string: self.imagesArray[indexPath.row]));
        
        return cell;
    }
    
}

