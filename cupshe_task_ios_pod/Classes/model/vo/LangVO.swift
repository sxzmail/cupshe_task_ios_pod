//
//  LangVO.swift
//  OcSwiftUIDemo
//
//  Created by gbl on 2023/10/17.
//

import Foundation
import SwiftyJSON

class LangVO : Codable,GBSwiftyJSONAble,Identifiable {
    var key:String
    var value: String
    
   
    
    init(){
        key = ""
        value = ""
    }
    
    required init?(jsonData:JSON){
        self.key = jsonData["key"].stringValue
        self.value = jsonData["value"].stringValue
     
    }
}
