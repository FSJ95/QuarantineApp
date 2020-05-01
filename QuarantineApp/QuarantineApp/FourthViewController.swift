//
//  FourthViewController.swift
//  QuarantineApp
//
//  Created by Frederik Søndergaard Jensen on 01/05/2020.
//  Copyright © 2020 Frederik Søndergaard Jensen. All rights reserved.
//

import UIKit
import MapKit
import CoreLocation

class FourthViewController: UIViewController, CLLocationManagerDelegate, MKMapViewDelegate {
    /// ALI
    
    @IBOutlet weak var textFiledForAdress: UITextField!
    @IBOutlet weak var getDirectionsBtn: UIButton!
    @IBOutlet weak var map: MKMapView!
    
    var locationManager = CLLocationManager()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        
        locationManager.requestAlwaysAuthorization()
        locationManager.requestWhenInUseAuthorization()
        locationManager.startUpdatingLocation()
        map.delegate = self
        
        let sortedam = MKPointAnnotation()
        let faelledparken = MKPointAnnotation()
        let frederiksberg = MKPointAnnotation()
        
        sortedam.coordinate = CLLocationCoordinate2D(latitude: 55.692231, longitude: 12.5711601)
        sortedam.title = "Sortedamns Sø"
        sortedam.subtitle = "Få en dejlig gåtur om eftermiddagen langs søen, ensrettet vej"
        map.addAnnotation(sortedam)
        
        faelledparken.coordinate = CLLocationCoordinate2D(latitude: 55.710105, longitude: 12.560377)
        faelledparken.title = "Fælled parken"
        faelledparken.subtitle = "du vil blive omringet af dejlig natur omgivelser, hvor du blandt andet kan lufte hunden i hunde parken. Meget stor park"
        map.addAnnotation(faelledparken)
        
        frederiksberg.coordinate = CLLocationCoordinate2D(latitude: 55.675789, longitude: 12.525940)
        frederiksberg.title = "Frederiksberg have"
        frederiksberg.subtitle = "Dejlig stor have, der kan være mange mennesker hvis vejret er godt"
        map.addAnnotation(frederiksberg)
        
        /*let region = MKCoordinateRegion(center: annotation.coordinate, latitudinalMeters: 500, longitudinalMeters: 500)
        map.setRegion(region, animated: true)
         */
    }
    
    @IBAction func getDirectionsTapped(_ sender: Any){
        getAdress()
        
    }
    
    func getAdress(){
        let geoCoder = CLGeocoder()
        geoCoder.geocodeAddressString(textFiledForAdress.text!) { (placemarks, error) in
            
            guard let placemarks = placemarks, let location = placemarks.first?.location
                else{
                    print("no location found")
                    return
            }
            print(location)
            self.routeThis(destionCord: location.coordinate)
            
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        print(locations)
    }
    
    func routeThis(destionCord: CLLocationCoordinate2D){
        let sourceCordinate = (locationManager.location?.coordinate)!
        
        let sourePlaceMark = MKPlacemark(coordinate: sourceCordinate)
        let destPlaceMark = MKPlacemark(coordinate: destionCord)
        
        let sourceItem = MKMapItem(placemark: sourePlaceMark)
        let destItem = MKMapItem(placemark: destPlaceMark)
        
        let destinationRequest = MKDirections.Request()
        destinationRequest.source = sourceItem
        destinationRequest.destination = destItem
        destinationRequest.transportType = .automobile //hvilken transporttype
        destinationRequest.requestsAlternateRoutes = true
        let directions = MKDirections(request: destinationRequest)
        directions.calculate { (response, error) in
            guard let response = response
                else{
                    if let error = error{
                        print("Something is wrong (:")
                    }
                    
                    return
            }
            
            let route = response.routes[0]
            self.map.addOverlay(route.polyline)
            self.map.setVisibleMapRect(route.polyline.boundingMapRect, animated: true)
            
        }
        
    }
    
    func mapView(_ mapView: MKMapView, rendererFor overlay: MKOverlay) -> MKOverlayRenderer {
        let render = MKPolylineRenderer(overlay: overlay as! MKPolyline)
        render.strokeColor = .blue
        return render
    }
    
    
}
