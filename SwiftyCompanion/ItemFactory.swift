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
    
    public func createUser(from data: Data) -> UserData {
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
            let cursusIDs = project["cursus_ids"].arrayObject as? [Int]
            let name = project["project"]["name"].string
            let projectID = project["project"]["id"].int
            let parentID = project["project"]["parentID"].int
            let validated: ValidStatus
            if let valid = project["validated?"].bool {
                valid ? (validated = .valid) : (validated = .failed)
            } else {
                validated = .waiting
            }
            let status = project["status"].string
            let finalMark = project["final_mark"].int
            let newProject = Project(name: name ?? "No Project", cursusID: cursusIDs ?? [Int](), id: projectID ?? 0, parentID: parentID, finalMark: finalMark ?? 0, status: status ?? "No status", validated: validated, subProjects: [Project]())
            let cursusesToSave = cursuses.filter({newProject.cursusID.contains($0.id)})
            if newProject.isParent {
               add(project: newProject, to: cursusesToSave)
            } else {
                waitingProjects.append(newProject)
            }
        }
        add(subprojects: waitingProjects, to: cursuses)
    }
    
    private func add(project: Project, to cursuses: [Cursus]) {
        cursuses.forEach {cursus in
            switch project.validated {
            case .waiting:
                cursus.waitingProjects.append(project)
            case .valid:
                cursus.finishedProjects.append(project)
            case .failed:
                cursus.failedProjects.append(project)
            }
        }
    }
    
    private func add(subprojects: [Project], to cursuses: [Cursus]) {
        subprojects.forEach { project in
            let cursuses = cursuses.filter({project.cursusID.contains($0.id)})
            cursuses.forEach({ cursus in
                let projectsToAdd = (cursus.waitingProjects + cursus.failedProjects + cursus.finishedProjects).filter({project.parentID! == $0.id})
                for var projectToAdd in projectsToAdd {
                    projectToAdd.subProjects.append(project)
                }
            })
        }
    }
    
    private func createUser(from json: JSON) -> UserData {
        let image = json["image_url"].url
        let id = json["id"].int
        let name = json["displayname"].string
        let evaluationPoints = json["correction_point"].int
        let campus = json["campus"][0]["name"].string
        let phoneNumber = json["phone"].string
        let email = json["email"].string
        let cursuses = createCursuses(from: json["cursus_users"])
        createProjects(from: json["projects_users"], for: cursuses)
        return UserData( name: name ?? "NoName", id: id ?? 0, image: image, evaluationPoints: evaluationPoints ?? 0, cursuses: cursuses, campus: campus ?? "No Campus", phoneNumber: phoneNumber, email: email)
    }
    private init(){}
}
