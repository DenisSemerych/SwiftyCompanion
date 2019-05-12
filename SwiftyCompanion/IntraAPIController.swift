//
//  ApiDelegate.swift
//  SwiftyCompanion
//
//  Created by Denis SEMERYCH on 5/11/19.
//  Copyright © 2019 Denis SEMERYCH. All rights reserved.
//

import Foundation
import Alamofire
import SwiftyJSON

class IntraAPIController {
    private var userID = "faf77e26c88d7eb346b286661a323b4e9b82abc46d3a3a21ca2937eefa1703de"
    private var secretKey =  "a92c30817af0819c05513568f92babc2e3bf7dda6d9f9aa7f0cc3dd8eb3c8090"
    private var token: String?
    private lazy var taskGroup = DispatchGroup()
    weak var delegate: IntraAPIDelegate?
    
    
    //Make request to get token from API
    func requestToken() {
        taskGroup.enter()
        let url: URLConvertible = "https://api.intra.42.fr/oauth/token"
        let bearer = ((userID + ":" + secretKey).data(using: String.Encoding.utf8))!.base64EncodedString(options: NSData.Base64EncodingOptions(rawValue: 0))
        let headers = ["Authorization" : "Basic \(bearer)"]
        let parameters = ["grant_type" : "client_credentials", "client_id" : userID,  "client_secret" : secretKey]
        Alamofire.request(url, method: .post, parameters: parameters, encoding: URLEncoding.httpBody, headers: headers).responseJSON() {[weak self] response in
            let responceData = response.value as! NSDictionary
            self?.token = responceData.value(forKey: "access_token") as? String
            print(self?.token)
            self?.taskGroup.leave()
        }
    }
    
    //Check if token isn`t expire
    private func checkToken(from auth: [String:String]) {
        taskGroup.enter()
        let url: URLConvertible = "https://api.intra.42.fr/oauth/token/info"
        Alamofire.request(url, method: .get, headers: auth).response {[weak self] response in
            switch response.response!.statusCode {
            case 200:
                break
            default:
                //recreate if expire
                self?.requestToken()
            }
            self?.taskGroup.leave()
        }
    }

    //Requesting user info from login
    func requestUserInfo(login: String) {
        let url: URLConvertible = "https://api.intra.42.fr/v2/users/" + login.trimmingCharacters(in: .whitespaces).lowercased()
        let headers = ["Authorization" : "Bearer \(token!)"]
        checkToken(from: headers)
        Alamofire.request(url, method: .get, headers: headers).response { [weak self] response in
            print(response.data)
            self?.taskGroup.notify(queue: .main) {
                self?.delegate?.processRequestResult(result: RequestResult.success)
            }
        }
    }
    
    init() {
        self.requestToken()
    }
}


