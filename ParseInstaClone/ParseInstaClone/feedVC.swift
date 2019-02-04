//
//  FirstViewController.swift
//  ParseInstaClone
//
//  Created by iamkurtgoz on 1.02.2019.
//  Copyright © 2019 iamkurtgoz. All rights reserved.
//

import UIKit
import Parse

class feedVC: UIViewController, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet weak var feedTableView: UITableView!
    
    var postOwnerArray = [String]();
    var postCommentArray = [String]();
    var postUUIDArray = [String]();
    var postImageArray = [PFFileObject]();
    
    override func viewDidLoad() {
        super.viewDidLoad()
    
        self.feedTableView.delegate = self;
        self.feedTableView.dataSource = self;
        self.feedTableView.register(UINib(nibName: "TableViewCell", bundle: nil), forCellReuseIdentifier: "tableViewCell");
    
        getData()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        NotificationCenter.default.addObserver(self, selector: #selector(feedVC.getData), name: NSNotification.Name("new"), object: nil)
    }
    
    @objc func getData(){
        let query = PFQuery(className: "Posts");
        query.addDescendingOrder("createdAt")
        query.findObjectsInBackground { (objects, error) in
            if error != nil {
                let alert = UIAlertController(title: "Hata", message: error?.localizedDescription, preferredStyle: UIAlertController.Style.alert);
                let action = UIAlertAction(title: "Ok", style: UIAlertAction.Style.cancel, handler: nil);
                alert.addAction(action);
                self.present(alert, animated: true, completion: nil);
            } else {
                if objects!.count > 0 {
                    
                    self.postOwnerArray.removeAll(keepingCapacity: false);
                    self.postUUIDArray.removeAll(keepingCapacity: false);
                    self.postCommentArray.removeAll(keepingCapacity: false);
                    self.postImageArray.removeAll(keepingCapacity: false);
                    
                    for row in objects! {
                        self.postOwnerArray.append(row.object(forKey: "postowner") as! String)
                        self.postUUIDArray.append(row.object(forKey: "postuuid") as! String)
                        self.postCommentArray.append(row.object(forKey: "postcomment") as! String)
                        self.postImageArray.append(row.object(forKey: "image") as! PFFileObject)
                    }
                }
            }
            self.feedTableView.reloadData();
        }
    }

    @IBAction func btnLogout(_ sender: Any) {
        PFUser.logOutInBackground { (error) in
            if error != nil {
                let alert = UIAlertController(title: "Hata", message: error?.localizedDescription, preferredStyle: UIAlertController.Style.alert);
                let action = UIAlertAction(title: "Ok", style: UIAlertAction.Style.cancel, handler: nil);
                alert.addAction(action);
                self.present(alert, animated: true, completion: nil);
            } else {
                UserDefaults.standard.removeObject(forKey: "username");
                UserDefaults.standard.synchronize();
                (UIApplication.shared.delegate as! AppDelegate).rememberUser();
            }
        }
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return postOwnerArray.count;
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = self.feedTableView.dequeueReusableCell(withIdentifier: "tableViewCell", for: indexPath) as! TableViewCell;
        cell.textUsername.text = postOwnerArray[indexPath.row];
        cell.textUUID.text = postUUIDArray[indexPath.row];
        cell.textComment.text = postCommentArray[indexPath.row];
        
        postImageArray[indexPath.row].getDataInBackground { (data, error) in
            if error == nil {
                cell.imgHeader.image = UIImage(data: data!);
            }
        }
        return cell;
    }
}

