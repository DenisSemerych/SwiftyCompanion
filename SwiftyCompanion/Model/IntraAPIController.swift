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
    
    public static let shared = IntraAPIController()
    
    private var userID = "faf77e26c88d7eb346b286661a323b4e9b82abc46d3a3a21ca2937eefa1703de"
    private var secretKey =  "a92c30817af0819c05513568f92babc2e3bf7dda6d9f9aa7f0cc3dd8eb3c8090"
    private var token: String?
    private lazy var taskGroup = DispatchGroup()
    weak var delegate: IntraAPIDelegate?
    
    
    //Make request to get token from API
    private func requestToken() {
        if let token = UserDefaults.standard.string(forKey: "token") {
            self.token = token
        } else {getNewToken()}
    }
    
    private func getNewToken() {
        taskGroup.enter()
        UIApplication.shared.isNetworkActivityIndicatorVisible = true
        let url: URLConvertible = "https://api.intra.42.fr/oauth/token"
        let bearer = ((userID + ":" + secretKey).data(using: String.Encoding.utf8))!.base64EncodedString(options: NSData.Base64EncodingOptions(rawValue: 0))
        let headers = ["Authorization" : "Basic \(bearer)"]
        let parameters = ["grant_type" : "client_credentials", "client_id" : userID,  "client_secret" : secretKey]
        Alamofire.request(url, method: .post, parameters: parameters, encoding: URLEncoding.httpBody, headers: headers).responseJSON() {[unowned self] response in
            let responceData = response.value as? NSDictionary
            if let token = responceData?.value(forKey: "access_token") as? String {
                self.token = token
                UserDefaults.standard.set(token, forKey: "token")
                UIApplication.shared.isNetworkActivityIndicatorVisible = false
            }
           // print(self.token)
            self.taskGroup.leave()
        }
    }
    
    //Check if token isn`t expire
    private func checkToken(from auth: [String:String]) {
        taskGroup.enter()
        let url: URLConvertible = "https://api.intra.42.fr/oauth/token/info"
        Alamofire.request(url, method: .get, headers: auth).response {[unowned self] response in
            switch response.response?.statusCode {
            case 200:
                break
            default:
                self.getNewToken()
            }
            self.taskGroup.leave()
        }
    }

    //Requesting user info from login
    public func requestUserInfo(login: String) {
        UIApplication.shared.isNetworkActivityIndicatorVisible = true
        let url: URLConvertible = "https://api.intra.42.fr/v2/users/" + login.trimmingCharacters(in: .whitespaces).lowercased()
        let headers = ["Authorization" : "Bearer \(token!)"]
        checkToken(from: headers)
        Alamofire.request(url, method: .get, headers: headers).response { [unowned self] response in
            self.taskGroup.notify(queue: .main) {
                let requestResult: RequestResult
                if response.error == nil {
                    requestResult = .success
                } else {
                    requestResult = .requestFailure
                }
                self.delegate?.processRequestResult(result: requestResult, with: response.data)
                UIApplication.shared.isNetworkActivityIndicatorVisible = false
            }
        }
    }
    
    public func downloadImageData(from url: URL) {
        UIApplication.shared.isNetworkActivityIndicatorVisible = true
        Alamofire.request(url, method: .get).response { [unowned self] response in
            self.taskGroup.notify(queue: .main) {
                let requestResult: RequestResult
                if response.error == nil {
                    requestResult = .success
                } else {
                    requestResult = .requestFailure
                }
                self.delegate?.processRequestResult(result: requestResult, with: response.data)
                UIApplication.shared.isNetworkActivityIndicatorVisible = false
            }
        }
    }
    
    public func giveRequestForSVGDownload(from stringURL: String?) -> URLRequest? {
        guard let string = stringURL else {return nil}
        let fullURL = "https://api.intra.42.fr" + string
        guard let url = URL(string: fullURL) else {return nil}
        let request = URLRequest(url: url)
        return request
    }
    
   private init() {
        self.requestToken()
    }
}


