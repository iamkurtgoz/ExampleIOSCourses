//
//  ViewController.swift
//  TravelApp
//
//  Created by iamkurtgoz on 15.01.2019.
//  Copyright © 2019 iamkurtgoz. All rights reserved.
//

import UIKit
import MapKit
import CoreLocation
import CoreData

class mapVC: UIViewController, MKMapViewDelegate, CLLocationManagerDelegate{


    @IBOutlet weak var textTitle: UITextField!
    @IBOutlet weak var textSubTitle: UITextField!
    @IBOutlet weak var mapView: MKMapView!
    
    var locationManager = CLLocationManager();
    var requestCLLocation = CLLocation();
    var selectedLatitude = Double();
    var selectedLongitude = Double();
    
    var choosenTitle = "";
    var choosenSubtitle = "";
    var choosenLatitude: Double = 0;
    var choosenLongitude: Double = 0;
    
    override func viewDidLoad() {
        super.viewDidLoad()
        mapView.delegate = self;
        locationManager.delegate = self;
        locationManager.desiredAccuracy = kCLLocationAccuracyBest;
        locationManager.requestWhenInUseAuthorization();
        locationManager.startUpdatingLocation();
        
        let recognizer = UILongPressGestureRecognizer(target: self, action: #selector(mapVC.longPressPin(gestureRecognizer:)))
        recognizer.minimumPressDuration = 3;
        mapView.addGestureRecognizer(recognizer);
        
        if choosenTitle != ""{
            let annotation = MKPointAnnotation();
            let cordinate = CLLocationCoordinate2D(latitude: self.choosenLatitude, longitude: self.choosenLongitude);
            annotation.coordinate = cordinate;
            annotation.title = self.choosenTitle;
            annotation.subtitle = self.choosenSubtitle;
            self.mapView.addAnnotation(annotation);
            
            textTitle.text = choosenTitle;
            textSubTitle.text = choosenSubtitle;
        }
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
    
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        if annotation is MKUserLocation{
            return nil;
        }
        let reuseID = "myAnotation";
        var pinView = mapView.dequeueReusableAnnotationView(withIdentifier: reuseID) as? MKPinAnnotationView;
        
        if pinView == nil{
            pinView = MKPinAnnotationView(annotation: annotation, reuseIdentifier: reuseID);
            pinView?.canShowCallout = true;
            pinView?.pinTintColor = UIColor.blue;
            
            let button = UIButton(type: UIButton.ButtonType.detailDisclosure);
            pinView?.rightCalloutAccessoryView = button;
        } else {
            pinView?.annotation = annotation;
        }
        return pinView;
    }
    
    func mapView(_ mapView: MKMapView, annotationView view: MKAnnotationView, calloutAccessoryControlTapped control: UIControl) {
        
        if selectedLatitude != 0 && selectedLongitude != 0{
            self.requestCLLocation = CLLocation(latitude: selectedLatitude, longitude: selectedLongitude);
        }
        
        CLGeocoder().reverseGeocodeLocation(requestCLLocation) { (placemarks, error) in
            if let placemark = placemarks{
                if placemark.count > 0{
                    let newPlacaMarks = MKPlacemark(placemark: placemark[0]);
                    let item = MKMapItem(placemark: newPlacaMarks);
                    item.name = self.choosenTitle;
                    
                    let launchOptions = [MKLaunchOptionsDirectionsModeKey: MKLaunchOptionsDirectionsModeDriving];
                    
                    item.openInMaps(launchOptions: launchOptions);
                }
            }
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        let location = CLLocationCoordinate2D(latitude: locations[0].coordinate.latitude, longitude: locations[0].coordinate.longitude);
        let span = MKCoordinateSpan(latitudeDelta: 0.05, longitudeDelta: 0.05)
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
        
        NotificationCenter.default.post(name: NSNotification.Name(rawValue: "newPlace"), object: nil);
        self.navigationController?.popViewController(animated: true);
    }
}

