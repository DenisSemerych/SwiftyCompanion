//
//  UserData.swift
//  SwiftyCompanion
//
//  Created by Denis SEMERYCH on 5/13/19.
//  Copyright © 2019 Denis SEMERYCH. All rights reserved.
//

import Foundation

class UserData: LevelItem {
    
    var level: Double
    var name: String
    var id: Int
    var image: URL
    var evaluationPoints: Int
    var cursus = [Cursus]()
    var grade: String
    var campus: String
    var phoneNumber: String?
    var email: String?

    init() {
        level = 0.1
        name = "test"
        image = URL(string: "test")!
        evaluationPoints = 10
        grade = "Test"
        campus = "Kiev"
        phoneNumber = "Test"
        email = "test"
        id = 1
    }
}
