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
    var image: URL?
    var evaluationPoints: Int
    var cursuses: [Cursus]
    var campus: String
    var phoneNumber: String?
    var email: String?

    init(name: String, id: Int, image: URL?, evaluationPoints: Int, cursuses: [Cursus], campus: String, phoneNumber: String?, email: String?) {
        self.name = name
        self.id = id
        self.image = image
        self.evaluationPoints = evaluationPoints
        self.cursuses = cursuses
        self.campus = campus
        self.phoneNumber = phoneNumber
        self.email = email
    }
}
