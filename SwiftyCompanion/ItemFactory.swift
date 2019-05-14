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
    private init(){}
    
    
    func create(item: Items, from data: Data) -> Item {
        let json = JSON(data: data)
        switch item {
        case .skill:
            return createSkill(from: json)
        case .cursus:
            return createCursus(from: json)
        case .project:
            return createProject(from: json)
        case .userData:
            return createUser(from: json)
        }
    }
    
    private func createSkill(from: JSON) -> Skill {
        return Skill(id: 1, name: "test", level: 1)
    }
    
    private func createCursus(from: JSON) -> Cursus {
        return Cursus(id: 1, name: "s")
    }
    
    private func createProject(from: JSON) -> Project {
        return Project(name: "test", id: 1, isParent: false, parentID: 0, finalMark: 0, status: "tes", validated: .valid, subProjects: [Project]())
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
        let cursus = json["cursus_users"][0]["cursus"]["name"].string
        let allProjects = json["projects_users"].arrayObject
        let allSkills = json["cursus_users"][0]["skills"].arrayObject
        
    }
}
