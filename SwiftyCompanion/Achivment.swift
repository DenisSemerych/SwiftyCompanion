//
//  Achivment.swift
//  SwiftyCompanion
//
//  Created by Denis SEMERYCH on 6/27/19.
//  Copyright © 2019 Denis SEMERYCH. All rights reserved.
//

import Foundation


class Achievement: Item {
    var name: String
    var id: Int
    var description: String
    var stringURL: String
    
    init(name: String, id: Int, description: String, stringURL: String) {
        self.name = name
        self.id = id
        self.description = description
        self.stringURL = stringURL
    }
}
