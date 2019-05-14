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

struct Project: Item {
    
    var name: String
    var id: Int
    var isParent: Bool
    var parentID: Int?
    var finalMark: Int
    var status: String
    var validated: ValidStatus
    var subProjects = [Project]()
}
