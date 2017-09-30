//
//  Location.swift
//  mapify
//
//  Created by Caleb Davis on 9/30/17.
//  Copyright © 2017 Caleb Davis. All rights reserved.
//

import Foundation
import CoreLocation
import Firebase
import MapKit
import SwiftyJSON

class Location: NSObject, MKAnnotation {
    let key: String
    let title: String?
    let locationArea: String?
    let desc: String
    let address: String
    let zip: String
    let coordinate: CLLocationCoordinate2D
    var addedByUser: String
    var mapKey: String
    let ref: DatabaseReference?

    var subtitle: String? {
        return address
    }

    init(title: String?,
         locationArea: String?,
         description: String,
         address: String,
         zip: String = "",
         coordinate: CLLocationCoordinate2D,
         addedByUser: String,
         mapKey: String,
         key: String = "") {

        self.title = title
        self.locationArea = locationArea
        self.key = key
        self.desc = description
        self.address = address
        self.zip = zip
        self.coordinate = coordinate
        self.mapKey = mapKey
        self.addedByUser = addedByUser
        self.ref = nil
        super.init()
    }

    init(snapshot: DataSnapshot) {
        key = snapshot.key
        ref = snapshot.ref

        let json = JSON(snapshot.value as! [String: Any])
        title = json["title"].string
        address = json["address"].string!
        locationArea = json["locationArea"].string
        desc = json["desc"].string!
        zip = json["zip"].string!
        addedByUser = json["addedByUser"].string!
        mapKey = json["mapKey"].string!

        let latitude = json["latitude"].double!
        let longitude = json["longitude"].double!
        coordinate = CLLocationCoordinate2D(latitude: latitude, longitude: longitude)



    }
}

extension Location {
    func toAnyObject() -> Any {
        return [
            "title": title ?? "",
            "area": locationArea ?? "",
            "desc": desc,
            "address": address,
            "zip": zip,
            "latitude": coordinate.latitude,
            "longitude": coordinate.longitude,
            "addedByUser": addedByUser,
            "mapKey": mapKey,
        ]
    }

    func mapLocationsToAnyObject(jsonKey: String) -> Any {
        return [
            jsonKey: "true"
        ]
    }
}
