//
//  ItemFactory.swift
//  SwiftyCompanion
//
//  Created by Denis SEMERYCH on 5/14/19.
//  Copyright © 2019 Denis SEMERYCH. All rights reserved.
//

import Foundation
import SwiftyJSON

protocol Item {
    var name: String {get}
    var id: Int {get}
}

protocol LevelItem: Item {
    var level: Double {get}
}

enum Items {
    case skill, project, cursus, userData
}

class ItemFactory {
    
    static let shared = ItemFactory()
    
    func createUser(from data: Data) -> UserData {
        let json = JSON(data: data)
        return createUser(from: json)
    }
    
    private func createSkill(from allSkills: JSON) -> [Skill] {
        var skills = [Skill]()
        allSkills.forEach { index, json in
            let id = json["id"].int
            let name = json["name"].string
            let level = json["level"].double
            skills.append(Skill(id: id ?? 0, name: name ?? "Wrong Skill", level: level ?? 0.0))
        }
        return skills
    }
    
    private func createCursuses(from allCursuses: JSON) -> [Cursus] {
        var cursuses = [Cursus]()
        allCursuses.forEach { index, json in
            let grade = json["grade"].string
            let level = json["level"].double
            let skills = createSkill(from: json["skills"])
            let cursusName = json["cursus"].dictionary?["name"]?.string
            let cursusID = json["cursus"].dictionary?["id"]?.int
            cursuses.append(Cursus(id: cursusID ?? 0, name: cursusName ?? "Wrong Cursus", level: level ?? 0.0, skills: skills, grade: grade))
        }
        return cursuses
    }
    
    private func createProjects(from json: JSON, for cursuses: [Cursus]) {
        var waitingProjects = [Project]()
        json.forEach { index, project in
            let cursusIDs = project["cursus_ids"]
        }
    }
    
    private func createUser(from json: JSON) -> UserData {
        let image = json["image_url"].url
        let name = json["displayname"].string
        let evaluationPoints = json["correction_point"].int
        let grade = json["cursus_users"][0]["grade"].string
        let campus = json["campus"][0]["name"].string
        let phoneNumber = json["phone"].string
        let email = json["email"].string
        let level = json["cursus_users"][0]["level"].double
        let cursuses = createCursuses(from: json["cursus_users"])
        createProjects(from: json["project_users"], for: cursuses)
        return UserData( name: "1", id: 1, image: URL(string: "1")!, evaluationPoints: 1, cursuses: [Cursus](), campus: "Kampus", phoneNumber: "", email: "")
    }
    private init(){}
}
