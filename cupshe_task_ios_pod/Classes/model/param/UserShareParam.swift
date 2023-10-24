//
//  UserShareParam.swift
//  OcSwiftUIDemo
//
//  Created by gbl on 2023/10/18.
//

import Foundation
class UserShareParam : Codable{
    
    var siteId: String?
    var channelId: String?
    var brandId: String?
    var terminalId: String?
    var taskId: Int?
    var appLangCode: String?
    var token: String?
    var activityId: String?
    var userShareId: String?
    
    init(token: String?,siteId:String?,channelId: String?,brandId: String?,terminalId: String?,taskId: Int?,pageName: String?,appLangCode: String?,activityId: String?,userShareId: String?){
        self.token = token
        self.siteId = siteId
        self.channelId = channelId
        self.brandId = brandId
        self.terminalId = terminalId
        self.taskId = taskId
        self.appLangCode = appLangCode
        self.activityId = activityId
        self.userShareId = userShareId
    }
    
    init(){
        
    }
}
