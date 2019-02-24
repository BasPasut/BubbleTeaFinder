//
//  Place.swift
//  BubbleTeaLocation
//
//  Created by Pasut Kittiprapas on 2/14/2562 BE.
//  Copyright © 2562 Pasut Kittiprapas. All rights reserved.
//

import Foundation
import GoogleMaps

class Place {
    let name: String
    let Location: CLLocationCoordinate2D
    
    init(venue: [String: Any]) {
        self.name = venue["name"] as? String ?? ""
        let rawLocation = venue["location"] as? [String: Any] ?? [:]
        let lat = rawLocation["lat"] as? Double ?? 0.0
        let lng = rawLocation["lng"] as? Double ?? 0.0
        
        self.Location = CLLocationCoordinate2D(latitude: lat, longitude: lng)
    }
}
