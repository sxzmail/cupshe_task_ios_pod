//
//  Student.swift
//  OcSwiftUIDemo
//
//  Created by gbl on 2023/10/13.
//

import Foundation
import SwiftyJSON

class Student :Codable,GBSwiftyJSONAble,Identifiable {
    var id:String
    var name: String
    var address: String
    var phone: String
    var password: String
    var status: Int
    var createdat: String
    var school: String
    var smsCode: String
    var portrait: String
    var newer: Int
    var freeLessonId: String
    var payer: Bool
    
    init(){
        id = ""
        name = ""
        address = ""
        phone = ""
        password = ""
        createdat = ""
        school = ""
        status = 0
        smsCode = ""
        portrait = ""
        newer = 0
        freeLessonId = ""
        payer = false
    }
    
    required init?(jsonData:JSON){
        self.id = jsonData["id"].stringValue
        self.name = jsonData["name"].stringValue
        self.address = jsonData["address"].stringValue
        self.phone = jsonData["phone"].stringValue
        self.password = jsonData["password"].stringValue
        self.createdat = jsonData["createdat"].stringValue
        self.school = jsonData["school"].stringValue
        self.status = jsonData["status"].intValue
        self.smsCode = jsonData["smsCode"].stringValue
        self.portrait = jsonData["portrait"].stringValue
        self.newer = jsonData["newer"].intValue
        self.freeLessonId = jsonData["freeLessonId"].stringValue
        self.payer = jsonData["payer"].boolValue
    }
}
