//
//  TaskQuery.swift
//  OcSwiftUIDemo
//
//  Created by gbl on 2023/10/17.
//

import Foundation

class TaskListParam : Codable{
    
    var siteId: String?
    var channelId: String?
    var brandId: String?
    var terminalId: String?
    var appLangCode: String?
    var token: String?
    var activityId: String?
    
    init(token:String?,siteId:String?,channelId: String?,brandId: String?,terminalId: String?,appLangCode: String?,activityId: String?){
        self.token = token
        self.siteId = siteId
        self.channelId = channelId
        self.brandId = brandId
        self.terminalId = terminalId
        self.appLangCode = appLangCode
        self.activityId = activityId
    }
    
    init(){
        
    }
}
