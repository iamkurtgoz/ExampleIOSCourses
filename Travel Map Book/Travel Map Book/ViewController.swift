//
//  ViewController.swift
//  Travel Map Book
//
//  Created by iamkurtgoz on 14.01.2019.
//  Copyright © 2019 iamkurtgoz. All rights reserved.
//

import UIKit
import MapKit
import CoreLocation
import CoreData;

class ViewController: UIViewController, MKMapViewDelegate, CLLocationManagerDelegate{

    @IBOutlet weak var textSubTitle: UITextField!
    @IBOutlet weak var textTitle: UITextField!
    @IBOutlet weak var mapView: MKMapView!
    var locationManager = CLLocationManager();
    var selectedLatitude = Double();
    var selectedLongitude = Double();
    
    override func viewDidLoad() {
        super.viewDidLoad()
        mapView.delegate = self;
        locationManager.delegate = self;
        locationManager.desiredAccuracy = kCLLocationAccuracyBest;
        locationManager.requestWhenInUseAuthorization();
        locationManager.startUpdatingLocation();
        
        let recognizer = UILongPressGestureRecognizer(target: self, action: #selector(ViewController.longPressPin(gestureRecognizer:)))
        recognizer.minimumPressDuration = 3;
        mapView.addGestureRecognizer(recognizer);
    }

    @objc func longPressPin(gestureRecognizer: UILongPressGestureRecognizer){
        
        if gestureRecognizer.state == UIGestureRecognizer.State.began{
            let touchPosition = gestureRecognizer.location(in: self.mapView);
            let choosenCordinates = self.mapView.convert(touchPosition, toCoordinateFrom: self.mapView);
            
            self.selectedLatitude = choosenCordinates.latitude;
            self.selectedLongitude = choosenCordinates.longitude;
            
            let annotation = MKPointAnnotation();
            annotation.coordinate = choosenCordinates;
            annotation.title = "Title";
            annotation.subtitle = "SubTitle";
            
            //Daha önce eklendiyse.
            self.mapView.annotations.forEach {
                if !($0 is MKUserLocation) {
                    self.mapView.removeAnnotation($0)
                }
            }
            self.mapView.addAnnotation(annotation);
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        let location = CLLocationCoordinate2D(latitude: locations[0].coordinate.latitude, longitude: locations[0].coordinate.longitude);
        let span = MKCoordinateSpan(latitudeDelta: 0.1, longitudeDelta: 0.1);
        let region = MKCoordinateRegion(center: location, span: span);
        mapView.setRegion(region, animated: true);
    }

    @IBAction func btnSave(_ sender: Any) {
        
        let appDelegate = UIApplication.shared.delegate as! AppDelegate;
        let context = appDelegate.persistentContainer.viewContext;
        
        let newPlace = NSEntityDescription.insertNewObject(forEntityName: "Places", into: context);
        newPlace.setValue(textTitle.text, forKey: "title");
        newPlace.setValue(textSubTitle.text, forKey: "subtitle");
        newPlace.setValue(self.selectedLatitude, forKey: "latitude");
        newPlace.setValue(self.selectedLongitude, forKey: "longitude");
        
        do{
            try context.save();
            print("SAVED :)")
        } catch {
            print("ERROR!");
        }
    }
}

