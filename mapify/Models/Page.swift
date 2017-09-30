//
//  Page.swift
//  mapify
//
//  Created by Caleb Davis on 9/30/17.
//  Copyright © 2017 Caleb Davis. All rights reserved.
//

import Foundation

struct Page {
    let title: String
    let message: String
    let imageName: String

    init(title: String, message: String, imageName: String) {
        self.title = title
        self.message = message
        self.imageName = imageName
    }
}
