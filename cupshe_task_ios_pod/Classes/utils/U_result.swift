//
//  U_result.swift
//  OcSwiftUIDemo
//
//  Created by gbl on 2023/10/12.
//

import Foundation
import SwiftyJSON

class U_result<T: GBSwiftyJSONAble>: GBSwiftyJSONAble {
    var code: Int!
//    var msg: String!
    var data: T?
    
    
    required init?(jsonData:JSON){
        self.code = jsonData["code"].intValue
//        self.msg = jsonData["msg"].stringValue
        self.data = T(jsonData: jsonData["data"])
    }
}


class U_result_List<T: GBSwiftyJSONAble>: GBSwiftyJSONAble {
    var code: Int!
    var msg: String!
    var data: [T]!
    
    required init?(jsonData:JSON){
        self.code = jsonData["code"].intValue
        self.data = jsonData["data"].arrayValue.flatMap {
            T(jsonData: $0)
            
        }
    }
}
