//
//  AddViewController.swift
//  WaterClosetV3
//
//  Created by Michael Mcmanus on 4/27/19.
//  Copyright © 2019 Michael Mcmanus. All rights reserved.
//

import UIKit
import MapKit
import CoreLocation


// Declares a custom protocol named HandleMapSearch. Anything that conforms to this protocol has to implement a method called dropPinZoomIn(_:).
protocol HandleMapSearch {
    func dropPinZoomIn(placemark:MKPlacemark)
}

class AddViewController: UIViewController, CLLocationManagerDelegate, MKMapViewDelegate {

    @IBOutlet weak var mapView: MKMapView!
    @IBOutlet var gestureRecognizer: UILongPressGestureRecognizer!
    let locationManager = CLLocationManager()
    var resultSearchController:UISearchController? = nil
    var selectedPin:MKPlacemark? = nil
    @IBOutlet weak var locatorButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        locatorButton.layer.cornerRadius = 5.0
        // Configures modal segue to Location Search Table
        let locationSearchTable = storyboard!.instantiateViewController(withIdentifier: "LocationSearchTable") as! LocationSearchTable
        resultSearchController = UISearchController(searchResultsController: locationSearchTable)
        resultSearchController?.searchResultsUpdater = locationSearchTable
        
        locationSearchTable.handleMapSearchDelegate = self

        // Configures the search bar and embeds into the navigation bar
        let searchBar = resultSearchController!.searchBar
        searchBar.sizeToFit()
        searchBar.placeholder = "Search for places"
        navigationItem.titleView = resultSearchController?.searchBar
        
        // Configures the appearance of the search bar.
        // We want the nav bar to be shown during search, since search bar is attached to it
        resultSearchController?.hidesNavigationBarDuringPresentation = false
        // Dims the background of the map view when searching
        resultSearchController?.dimsBackgroundDuringPresentation = true
        // Doesn't dim the area above the navigation bar
        definesPresentationContext = true
        
        // Ask for Authorisation from the User.
        self.locationManager.requestAlwaysAuthorization()
        
        // For use in foreground
        self.locationManager.requestWhenInUseAuthorization()
        
        locationSearchTable.mapView = mapView
        
        if CLLocationManager.locationServicesEnabled() {
            // Allows location manager to change the view
            locationManager.delegate = self
            // Set to best accuracy
            locationManager.desiredAccuracy = kCLLocationAccuracyNearestTenMeters
            // Updates location in realtime
            locationManager.startUpdatingLocation()
            // Shows the blue dot to the user
            mapView.showsUserLocation = true
        }
    
    }
    
    // Handles the logic for retriving the location info
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        
        // Constant variable for the users location
        let userLocation:CLLocation = locations[0] as CLLocation
        
        // Stop updating location, this prevents your device from constantly changing the Window to center your location while moving (you can omit this if you want it to function otherwise)
        manager.stopUpdatingLocation()
        
        // Get user coordinates from the userLocation defined above
        let coordinations = CLLocationCoordinate2D(latitude: userLocation.coordinate.latitude,longitude: userLocation.coordinate.longitude)
        
        // Define how zoomed you want the map to be. 0.011 is a good radius for our use case
        let span = MKCoordinateSpan(latitudeDelta: 0.011,longitudeDelta: 0.011)
        
        // This basically tells the map where to look and where from what distance
        let region = MKCoordinateRegion(center: coordinations, span: span)
        
        // Sets a 'region' based on the region variable above and animates to that location
        mapView.setRegion(region, animated: false)
        
        
        // Prints user coordinates to the console
        print("locations = \(coordinations.latitude) \(coordinations.longitude)")
    }
    
    @objc func getDirections(){
        if let selectedPin = selectedPin {
            let mapItem = MKMapItem(placemark: selectedPin)
            let launchOptions = [MKLaunchOptionsDirectionsModeKey : MKLaunchOptionsDirectionsModeDriving]
            mapItem.openInMaps(launchOptions: launchOptions)
        }
    }
    
    
    @IBAction func onLongPress(_ sender: Any) {
        
//        let touchPoint = gestureRecognizer.location(in: mapView)
//        let newCoordinates = mapView.convert(touchPoint, toCoordinateFrom: mapView)
//        let annotation = MKPointAnnotation()
//        annotation.coordinate = newCoordinates
//        mapView.addAnnotation(annotation)
        self.performSegue(withIdentifier: "addNewSegue", sender: self)
        
    }
    
    @IBAction func onLocBtnPressed(_ sender: UIButton) {
        locationManager.startUpdatingLocation()
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */



}


//This extension implements the dropPinZoomIn() method in order to adopt the HandleMapSearch protocol.
extension AddViewController: HandleMapSearch {
    func dropPinZoomIn(placemark:MKPlacemark){
        // cache the pin
        selectedPin = placemark
        // clear existing pins
        mapView.removeAnnotations(mapView.annotations)
        let annotation = MKPointAnnotation()
        annotation.coordinate = placemark.coordinate
        annotation.title = placemark.name
        if let city = placemark.locality,
            let state = placemark.administrativeArea {
            annotation.subtitle = "\(city) \(state)"
        }
        mapView.addAnnotation(annotation)
        let span = MKCoordinateSpan(latitudeDelta: 0.05, longitudeDelta: 0.05)
        let region = MKCoordinateRegion(center: placemark.coordinate, span: span)
        mapView.setRegion(region, animated: true)
    }
}

extension AddViewController {
    func mapView(mapView: MKMapView, viewForAnnotation annotation: MKAnnotation) -> MKAnnotationView?{
        if annotation is MKUserLocation {
            //return nil so map view draws "blue dot" for standard user location
            return nil
        }
        
        let reuseId = "pin"
        var pinView = mapView.dequeueReusableAnnotationView(withIdentifier: reuseId)
        if pinView == nil {
            pinView = MKPinAnnotationView(annotation: annotation, reuseIdentifier: reuseId)
            pinView?.canShowCallout = true
        } else {
            pinView?.annotation = annotation
        }
        
       
        let smallSquare = CGSize(width: 30, height: 30)
        let button = UIButton(frame: CGRect(origin: CGPoint.zero, size: smallSquare))
        button.setBackgroundImage(UIImage(named: "Plus30x30"), for: [])
        button.addTarget(self, action: Selector(("getDirections")), for: .touchUpInside)
        pinView?.leftCalloutAccessoryView = button
        return pinView
    }
}
