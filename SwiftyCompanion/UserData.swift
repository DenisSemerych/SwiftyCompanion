//
//  UserData.swift
//  SwiftyCompanion
//
//  Created by Denis SEMERYCH on 5/13/19.
//  Copyright © 2019 Denis SEMERYCH. All rights reserved.
//

import Foundation

class UserData: Item {
    
    var name: String
    var id: Int
    var imageURL: URL?
    var evaluationPoints: Int
    var cursuses: [Cursus]
    var campus: String
    var wallet: Int
    var phoneNumber: String
    var email: String
    var location: String?
    var achievements: [Achievement]

    init(name: String, id: Int, image: URL?, evaluationPoints: Int, cursuses: [Cursus], campus: String, phoneNumber: String?, email: String?, wallet: Int, location: String?, achievements: [Achievement]) {
        self.name = name
        self.id = id
        self.imageURL = image
        self.evaluationPoints = evaluationPoints
        self.cursuses = cursuses
        self.campus = campus
        self.phoneNumber = phoneNumber ?? "No phone"
        self.email = email ?? "No mail"
        self.wallet = wallet
        self.location = location
        self.achievements = achievements
    }
}
