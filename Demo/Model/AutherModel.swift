//
//  AutherModel.swift
//  Demo
//
//  Created by VJ's iMAC on 25/08/20.
//  Copyright © 2020 VJ's. All rights reserved.
//

import Foundation
import UIKit
import ObjectMapper


struct AutherModel: Mappable,Equatable {
    
    var id  : Int?
    var author  : String?
    var width : Int?
    var height: Int?
    var url : String?
    var download_url : String?
    
    init?(map: Map) {
        
    }
    
    mutating func mapping(map: Map) {
        
        self.id <- map["id"]
        self.author <- map ["author"]
        self.width <- map ["width"]
        self.height <- map ["height"]
        self.url <- map["url"]
        self.download_url <- map["download_url"]
        
    }
    
    
}
