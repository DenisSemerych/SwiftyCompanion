//
//  Cursus.swift
//  SwiftyCompanion
//
//  Created by Denis SEMERYCH on 5/14/19.
//  Copyright © 2019 Denis SEMERYCH. All rights reserved.
//

import Foundation

class Cursus: Item {
    
    var name: String
    var id: Int
    var skills: [Skill]
    var cursusUserLevel: Double
    var cursusUserGrade: String
    var waitingProjects = [Project]()
    var validProjects = [Project]()
    var failedProjects = [Project]()
    var allProjects: [Project] {
        return waitingProjects.sorted(by: {$0.name < $1.name}) + validProjects.sorted(by: {$0.name < $1.name}) + failedProjects.sorted(by: {$0.name < $1.name})
    }
    
    init(id: Int, name: String, level: Double, skills: [Skill], grade: String?) {
        self.cursusUserGrade = grade ?? "Novice"
        self.cursusUserLevel = level
        self.id = id
        self.name = name
        self.skills = skills
    }
}
