//
//  ViewController.swift
//  BubbleTeaLocation
//
//  Created by Pasut Kittiprapas on 2/13/2562 BE.
//  Copyright © 2562 Pasut Kittiprapas. All rights reserved.
//

import UIKit
import GoogleMaps
import Alamofire

class ViewController: UIViewController {

    let locationManager = CLLocationManager()
    
    
    @IBOutlet weak var mapView: GMSMapView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        locationManager.requestWhenInUseAuthorization()
        locationManager.delegate = self
        
        mapView.delegate = self;
        
//        let marker = GMSMarker(position: CLLocationCoordinate2D(latitude: 13.7597823, longitude: 100.5349915))
//        
//        marker.map = mapView
        
    }
    @IBAction func findAction(_ sender: UIButton) {
        Alamofire.request("https://api.foursquare.com/v2/venues/search?client_id=CO23EANCFD03LRND2AU1LOF4YQOZGOBHLRZTKOGHH2IDH3DP&client_secret=0CTGTLOKS2FFNXB4L0H1J10W2JKALK0MLVDHCWU4YL2CVSWV&v=20180323&limit=10&ll=\(locationManager.location?.coordinate.latitude ?? 0.0),\(locationManager.location?.coordinate.longitude ?? 0.0)&query=bubbletea").responseJSON(completionHandler: { res in
            
            guard let data = res.data else {
                return
            }

            let responseData = try?
                JSONDecoder().decode(JsonResponse.self, from: data)

            responseData?.response.venues.forEach{
                venue in
                let marker = GMSMarker(position: CLLocationCoordinate2D(latitude: venue.location.lat, longitude: venue.location.lng))
                
                marker.title = venue.name
                marker.map = self.mapView
            }
            
//            guard let json = res.result.value as? [String: Any] else {
//                return
//            }
//
//            guard let response = json["response"] as? [String: Any] else {
//                return
//            }
//
//            guard let venues = response["venues"] as? [[String: Any]] else {
//                return
//            }
//
//            venues.forEach{ venue in
//            let place = Place(venue: venue)
//                let marker = GMSMarker(position: place.Location)
//                print(marker)
//                marker.map = self.mapView
//                marker.title = place.name
//            }
        })
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "showDetails" {
            let vc = segue.destination as? VenueDetailController
            let name = sender as? String
            vc?.name = name
        }
    }
    
}


extension ViewController: CLLocationManagerDelegate {
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        if status == .authorizedWhenInUse{
            locationManager.startUpdatingLocation()
            
            mapView.isMyLocationEnabled = true
            mapView.settings.myLocationButton = true
        }
    }
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard let location = locations.first
            else{
            return
        }
        
        mapView.camera = GMSCameraPosition(latitude: location.coordinate.latitude, longitude: location.coordinate.longitude, zoom: 15)
    }
}

extension ViewController: GMSMapViewDelegate {
    func mapView(_ mapView: GMSMapView, didTap marker: GMSMarker) -> Bool{
        print(marker.title)
        
        performSegue(withIdentifier: "showDetails", sender: marker.title)
        return true;
    }
}
