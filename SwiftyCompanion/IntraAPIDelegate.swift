//
//  IntraAPIDelegate.swift
//  SwiftyCompanion
//
//  Created by Denis SEMERYCH on 5/11/19.
//  Copyright © 2019 Denis SEMERYCH. All rights reserved.
//

import Foundation


protocol IntraAPIDelegate: NSObjectProtocol {
    func processRequestResult(result: RequestResult)
}
