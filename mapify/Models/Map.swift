//
//  Map.swift
//  mapify
//
//  Created by Caleb Davis on 9/30/17.
//  Copyright © 2017 Caleb Davis. All rights reserved.
//

import Foundation
import CoreLocation
import Firebase
import SwiftyJSON

class Map {
    var key: String
    let name: String
    var cityName: String
    var stateName: String
    var addedByUser: String
    var coordinates: CLLocationCoordinate2D
    var regionDistance: CLLocationDistance = 0
    let ref: DatabaseReference?

    typealias CoordinateHandler = (_ coordinate: CLLocationCoordinate2D?, _ radius: CLLocationDistance?, _ error: Error?) -> Void

    init(name: String,
         cityName: String,
         stateName: String,
         addedByUser: String,
         regionDistance: CLLocationDistance = 0,
         coordinates: CLLocationCoordinate2D = CLLocationCoordinate2D(),
         key: String = "") {
        self.key = key
        self.name = name
        self.cityName = cityName
        self.stateName = stateName
        self.addedByUser = addedByUser
        self.coordinates = coordinates
        self.regionDistance = regionDistance
        self.ref = nil
    }

    init(snapshot: DataSnapshot) {
        key = snapshot.key
        ref = snapshot.ref


        let json = JSON(snapshot.value as! [String: Any])

        let latitude = json["latitude"].double!
        let longitude = json["longitude"].double!
        coordinates = CLLocationCoordinate2D(latitude: latitude, longitude: longitude)

        regionDistance = json["regionDistance"].double!

        addedByUser = json["addedByUser"].string!
        name = json["name"].string!
        cityName = json["cityName"].string!
        stateName = json["stateName"].string!
    }


}

extension Map {
    func toAnyObject() -> Any {
        return [
            "name": name,
            "city": cityName,
            "state": stateName,
            "latitude": coordinates.latitude,
            "longitude": coordinates.longitude,
            "regionDistance": regionDistance,
            "addedByUser": addedByUser
        ]
    }

    func usersMapsToAnyObject(jsonKey: String) -> Any {
        return [
            jsonKey: "true"
        ]
    }
}

extension Map {
    func getCoordinatesForMap(city: String, state: String, completion: @escaping CoordinateHandler) {
        let geocoder = CLGeocoder()
        let address = "\(city), \(state)"
        geocoder.geocodeAddressString(address) { (placemarks, error) in
            if error != nil {
                print(error?.localizedDescription ?? "Error geocoding address")
                completion(nil, nil, error)
            }

            if let placemark = placemarks?.first {
                let coordinate = placemark.location!.coordinate
                let region = String(describing: placemark.region!)

                let array = region.components(separatedBy: " ")
                var radius = array[3]
                radius = radius.replacingOccurrences(of: "\',", with: "")
                let distance: CLLocationDistance = Double(radius)!

                completion(coordinate, distance, nil)
            }
        }
    }
}
