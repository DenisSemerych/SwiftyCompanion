//
//  Cursus.swift
//  SwiftyCompanion
//
//  Created by Denis SEMERYCH on 5/14/19.
//  Copyright © 2019 Denis SEMERYCH. All rights reserved.
//

import Foundation

class Cursus: Item {
    
    var id: Int
    var name: String
    var skills = [Skill]()
    var waitingProjects = [Project]()
    var finishedProjects = [Project]()
    var failedProjects = [Project]()
    
    init(id: Int, name: String) {
        self.id = 1
        self.name = name
    }
}
