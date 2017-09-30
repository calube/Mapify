//
//  Coordinate.swift
//  mapify
//
//  Created by Caleb Davis on 9/30/17.
//  Copyright © 2017 Caleb Davis. All rights reserved.
//

import Foundation
import CoreLocation

struct Coordinate {
    var latitude : Double
    var longitude : Double

    init(latitude: Double, longitude: Double) {
        self.latitude = latitude
        self.longitude = longitude
    }

    func toString() -> String {
        return "\(latitude), \(longitude)"
    }

}
