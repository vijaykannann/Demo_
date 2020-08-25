//
//  APIService.swift
//  Demo
//
//  Created by VJ's iMAC on 25/08/20.
//  Copyright © 2020 VJ's. All rights reserved.
//
import Foundation
import Alamofire


typealias APIResponseHandler = (NSDictionary?,APIError?)->Void
typealias APIResponse = (AnyObject?, APIError?)->Void
typealias APIResponsee = [String : Any]
let oops = "Oops! Something went wrong."

class APIService: NSObject{
    
    public static let shared = APIService()
    public var baseURL: String = APIConfig.url
    public var baseURLParent: String = "" //APIConfig.url
        
    func getServiceOBJ(_ endPoint: APIEndPoints, parameters: Parameters?, completionHandler: @escaping APIResponse){
        print(endPoint)
        Alamofire.request("\(baseURL)\(endPoint.rawValue)", method: .get, parameters: parameters, encoding: URLEncoding(destination: .queryString), headers: nil) .validate().responseJSON { response in
            print(response.result)
            switch response.result {
            case .success:
                if let data = response.result.value{
                    completionHandler(data as AnyObject, nil)
                }
            case .failure(let error):
                completionHandler(nil, APIError(statusCode: 0, message: error.localizedDescription))
            }
        }
    }

}
    

class Connectivity {
    class var isConnectedToInternet:Bool {
        return NetworkReachabilityManager()!.isReachable
    }
}

