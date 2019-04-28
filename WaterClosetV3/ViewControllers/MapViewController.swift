//
//  MapViewController.swift
//  WaterClosetV3
//
//  Created by Michael Mcmanus on 4/27/19.
//  Copyright © 2019 Michael Mcmanus. All rights reserved.
//

import UIKit
import MapKit
import CoreLocation

class MapViewController: BaseViewController, CLLocationManagerDelegate, MKMapViewDelegate {

    // Outlet that allows us to manipulate our mapkit
    @IBOutlet weak var mapView: MKMapView!
    @IBOutlet var gestureRecognizer: UILongPressGestureRecognizer!
    // This holds all of the users location data
    let locationManager = CLLocationManager()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        addSlideMenuButton()
        
        // Ask for Authorisation from the User.
        self.locationManager.requestAlwaysAuthorization()
        
        // For use in foreground
        self.locationManager.requestWhenInUseAuthorization()
        
        if CLLocationManager.locationServicesEnabled() {
            // Allows location manager to change the view
            locationManager.delegate = self
            // Set to best accuracy
            locationManager.desiredAccuracy = kCLLocationAccuracyBest
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
    
   @IBAction func onLongPress(_ sender: Any) {
////        let touchPoint = gestureRecognizer.location(in: mapView)
////        let newCoordinates = mapView.convert(touchPoint, toCoordinateFrom: mapView)
////        let annotation = MKPointAnnotation()
////        annotation.coordinate = newCoordinates
////        mapView.addAnnotation(annotation)
//        print("Nah b.")
//
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
