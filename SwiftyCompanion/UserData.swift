//
//  UserData.swift
//  SwiftyCompanion
//
//  Created by Denis SEMERYCH on 5/13/19.
//  Copyright © 2019 Denis SEMERYCH. All rights reserved.
//

import Foundation
import SwiftyJSON

class UserData {
    
    var image: URL?
    var displayName: String?
    var evaluationPoints: Int?
    var cursus: String?
    var grade: String?
    var campus: String?
    var phoneNumber: String?
    var email: String?
    var level: Double?
    var skills: [Skill]?
    var projectsWaiting: [Project]?
    var projectsFinished: [Project]?
    var projectsFailed: [Project]?

    init?(form data: Data) {
        let json = JSON(data: data)
        image = json["image_url"].url
        displayName = json["displayname"].string
        evaluationPoints = json["correction_point"].int
        cursus = json["cursus_users"][0]["cursus"]["name"].string
        grade = json["cursus_users"][0]["grade"].string
        campus = json["campus"][0]["name"].string
        phoneNumber = json["phone"].string
        email = json["email"].string
        level = json["cursus_users"][0]["level"].double
        let allProjects = json["projects_users"].arrayObject
        let allSkills = json["cursus_users"][0]["skills"].arrayObject
        print(image, displayName, evaluationPoints, cursus, grade, campus, phoneNumber, email, level, allSkills, allProjects)

    }
}
