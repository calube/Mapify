//
//  User.swift
//  mapify
//
//  Created by Caleb Davis on 9/30/17.
//  Copyright © 2017 Caleb Davis. All rights reserved.
//

import Foundation

import Firebase

class User: NSObject, NSCoding {
    var uid: String
    var providerID: String
    var email: String
    var displayName: String
    var photoURL: URL?

    init(authData: User) {
        uid = authData.uid
        providerID = authData.providerID
        email = String(describing: authData.email)
        displayName = String(describing: authData.displayName)
        if let url = authData.photoURL {
            photoURL = url
        }
    }

    init(email: String,
         uid: String) {
        self.email = email
        self.uid = uid
        self.providerID = ""
        self.displayName = ""
        self.photoURL = nil
    }

    init (uid: String,
          providerID: String,
          email: String,
          displayName: String,
          photoURL: URL?) {
        self.uid = uid
        self.providerID = providerID
        self.email = email
        self.displayName = displayName
        self.photoURL = photoURL
    }

    required convenience init(coder aDecoder: NSCoder) {
        let uid = aDecoder.decodeObject(forKey: "uid") as? String ?? ""
        let providerID = aDecoder.decodeObject(forKey: "providerID") as? String ?? ""
        let email = aDecoder.decodeObject(forKey: "email") as? String ?? ""
        let displayName = aDecoder.decodeObject(forKey: "displayName") as? String ?? ""
        let urlString = aDecoder.decodeObject(forKey: "photoURL") as? String ?? ""
        let photoURL = URL(string: urlString) ?? nil

        self.init(uid: uid, providerID: providerID, email: email, displayName: displayName, photoURL: photoURL)
    }

    func encode(with aCoder: NSCoder) {
        aCoder.encode(self.uid, forKey: "uid")
        aCoder.encode(self.providerID, forKey: "providerID")
        aCoder.encode(self.email, forKey: "email")
        aCoder.encode(self.displayName, forKey: "displayName")
        aCoder.encode(self.photoURL, forKey: "photoURL")
    }

}

extension User {
    func toAnyObject() -> Any {
        let urlString: String = (photoURL != nil) ? (photoURL?.absoluteString)! : ""
        return [
            "providerID": providerID,
            "displayName": displayName,
            "email": email,
            "photoURL": urlString
        ]
    }

}
