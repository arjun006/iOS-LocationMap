//
//  ViewController.swift
//  LocationMap_A3
//
//  Created by arjun devakumar on 2021-11-26.
//

import UIKit
import CoreLocation
import MapKit
class ViewController: UIViewController {

    @IBOutlet weak var cityTextField: UITextField!
    @IBOutlet weak var locateButton: UIButton!
    @IBOutlet weak var mapView: MKMapView!
    @IBOutlet weak var clearButton: UIButton!
    let geocoder = CLGeocoder()
    var latitude = 43.64198643568011
    var longitude = -79.38913653757989
    override func viewDidLoad() {
        super.viewDidLoad()
        self.loadMap(long: longitude, lat: latitude, pinTitle: "Toronto")
    }
    private func loadMap(long:Double, lat:Double, pinTitle:String){
        let zoomLevel = MKCoordinateSpan(latitudeDelta: 0.05, longitudeDelta: 0.05)
        let mapCentre = CLLocationCoordinate2D(latitude: lat, longitude: long)
        let visibleRegion = MKCoordinateRegion(center: mapCentre, span: zoomLevel)
        
        self.mapView.setRegion(visibleRegion, animated: true)
        
        let pin = MKPointAnnotation()
        pin.coordinate = CLLocationCoordinate2D(latitude: lat, longitude: long)
        pin.title = pinTitle
        self.mapView.addAnnotation(pin)
        pin.subtitle = "\(lat),\(long)"
        print("\(pinTitle)")
    }
    @IBAction func onLocateButtonClicked(_ sender: Any) {
        guard let city = cityTextField.text else{return}
        
        print("\(city)")
        self.getLocation(address: "\(city)")
    }
    
    @IBAction func onClearButtonClicked(_ sender: Any) {
        self.cityTextField.text = nil
        self.loadMap(long: longitude, lat: latitude, pinTitle: "Toronto")
    }
    private func getLocation(address:String){
        self.geocoder.geocodeAddressString(address) { (resultsList, error) in
            print("waiting for response")
            
            if let err = error {
                print("Error while trying to geocode the address")
                print(err)
                return
            }
            
            if(resultsList != nil){
                if(resultsList!.count == 0){
                    print("No results found!")
                } else {
                    let placemark:CLPlacemark = resultsList!.first!
//                    print("Location found:\(placemark)")
//                    let lat = placemark.location?.coordinate.latitude
//                    let long = placemark.location?.coordinate.longitude
                    let tmpLat:Double = (placemark.location?.coordinate.latitude)!
                    let tmpLong:Double = (placemark.location?.coordinate.longitude)!
                   print("Latitude:\(placemark.location?.coordinate.latitude)")
                    print("Longitude:\(placemark.location?.coordinate.longitude)")
                    
                    self.loadMap(long:tmpLong, lat:tmpLat, pinTitle:address)
                }
            }
        }
    }
    
}

