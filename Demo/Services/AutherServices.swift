//
//  AutherServices.swift
//  Demo
//
//  Created by VJ's iMAC on 25/08/20.
//  Copyright © 2020 VJ's. All rights reserved.
//

import Foundation
import UIKit


class AutherServices {
    
    public static let shared = AutherServices()
    
    
    func candidate_question_answer_service(completionHandler: @escaping APIResponse){
        APIService.shared.getServiceOBJ(.login, parameters: nil) { (response, error) in
            
            guard let result = response else{
                completionHandler(response, error!)
                return
            }
            
            print(result)
            completionHandler(result, error)
            
            
        }
    }
    
    
}
