//
//  Api.swift
//  mapify
//
//  Created by Caleb Davis on 9/30/17.
//  Copyright © 2017 Caleb Davis. All rights reserved.
//

import Foundation
import Firebase

enum Api {
    /// Facebook Read Permissions
    var readPermissions: [String] {
        return ["public_profile", "email"]
    }
    /// Firebae URL
    // TODO: - Change URL when new firebase is created 
    var firebaseURL: String {
        return "https://my-maps-b68c5.firebaseio.com"
    }
}
