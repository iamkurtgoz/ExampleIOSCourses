//
//  ViewController.swift
//  Simpson Book
//
//  Created by iamkurtgoz on 12.01.2019.
//  Copyright © 2019 iamkurtgoz. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    @IBOutlet weak var tableView: UITableView!
    
    //dizi oluşturduk
    var mySimpson = [Simpson]();
    
    //seçilen veriyi hafızada tutmak için değişken oluşturduk
    var senderIntentSelectedSimpson = Simpson();
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "The Simpsons"; //navigation bar ismi değişti
        initTableView();
        addSimsons();
    
    }

    private func initTableView(){
        //tablo özelliklerini ayarladık. data ve delegate özelliklerinin bu classta belirlendiğini ekledik.
        tableView.dataSource = self;
        tableView.delegate = self;
        
        //"TableViewCell" isimli swift dosyasını tanımladık.
        let nibname = UINib(nibName: "TableViewCell", bundle: nil);
        //tanımladığımız swift dosyasındaki identifier değeri ile register ettik.
        tableView.register(nibname, forCellReuseIdentifier: "tableViewCell");
        
    }
    
    private func addSimsons(){
        //kayıtları ekledik
        let bart = Simpson();
        bart.name = "Bart Simpson";
        bart.occupation = "Student";
        bart.image = UIImage(named: "bart.png")!;
        
        let homer = Simpson();
        homer.name = "Homer Simpson";
        homer.occupation = "Nicular Safety Inspector";
        homer.image = UIImage(named: "homer.png")!;
        
        let lisa = Simpson();
        lisa.name = "Lisa Simpson";
        lisa.occupation = "Student";
        lisa.image = UIImage(named: "lisa.png")!;
        
        let maggie = Simpson();
        maggie.name = "Maggie Simpson";
        maggie.occupation = "Singer";
        maggie.image = UIImage(named: "maggie.png")!;
        
        let marge = Simpson();
        marge.name = "Marge Simpson";
        marge.occupation = "Homermaker";
        marge.image = UIImage(named: "marge.png")!;
        
        //diziye ekledik
        mySimpson.append(bart);
        mySimpson.append(homer);
        mySimpson.append(lisa);
        mySimpson.append(maggie);
        mySimpson.append(marge);
    }

    //FUNCTIONS
    
    //custom view height return value
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 90;
    }
    
    //list size return value
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return mySimpson.count;
    }
    
    //listeyi ekleyen sınıf.
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        //custom view olan satırı "dequeueReusableCell" ile çağırdık identifier göndererek tanımladık. "as! TableViewCell" kısmında o veri olup olmadığını doğruladık.
        let cell = tableView.dequeueReusableCell(withIdentifier: "tableViewCell", for: indexPath) as! TableViewCell;
        cell.commonInit(simpsonValue: mySimpson[indexPath.row]);
        return cell;
    }
    
    //tıklanan satırdan sonra çalışan komut
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        //seçilen veriyi hafıza değişkenine attı
        senderIntentSelectedSimpson = mySimpson[indexPath.row];
        //identifiere göre yönlendirdi
        performSegue(withIdentifier: "toDetailsVC", sender: nil);
        //tabloda seçilen satırı geri kaldırdı
        tableView.deselectRow(at: indexPath, animated: true);
    }
    
    //yönlendirme fonksiyonu
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        //çalışan foksiyon id'si kontrol edilir
        if segue.identifier == "toDetailsVC" {
            
            //getirilen id destination yani hedefi doğrulanır(as! DetailsViewController)
            let detailDestination = segue.destination as! DetailsViewController;
            //hafızada tutulan veri hedefe yazdırılır.
            detailDestination.getterIntentSimspson = senderIntentSelectedSimpson;
            
        }
    }
}

