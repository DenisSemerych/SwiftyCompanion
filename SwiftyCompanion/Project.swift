//
//  Project.swift
//  SwiftyCompanion
//
//  Created by Denis SEMERYCH on 5/13/19.
//  Copyright © 2019 Denis SEMERYCH. All rights reserved.
//

import Foundation

enum ValidStatus {
    case valid, failed, waiting
}

class Project: Item {
    
    var name: String
    var cursusIDs: [Int]
    var id: Int
    var isParent: Bool {
        get {
            return parentID == nil ? true : false
        }
    }
    var parentID: Int?
    var finalMark: Int
    var status: String
    var validated: ValidStatus
    var subProjects: [Project]
    
    init(name: String, cursusIDs: [Int], id: Int, parentID: Int?, finalMark: Int, status: String, validated: ValidStatus, subProjects: [Project]) {
        self.name = name
        self.cursusIDs = cursusIDs
        self.id = id
        self.parentID = parentID
        self.finalMark = finalMark
        self.status = status
        self.validated = validated
        self.subProjects = subProjects
    }
}
