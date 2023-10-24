//
//  TaskStatusCheckParam.swift
//  OcSwiftUIDemo
//
//  Created by gbl on 2023/10/18.
//

import Foundation

class TaskPageViewParam : Codable{
    
    var siteId: String?
    var channelId: String?
    var brandId: String?
    var terminalId: String?
    var taskId: Int?
    var appLangCode: String?
    var userTaskId: Int?
    var token: String?
    
    init(token: String?,siteId:String?,channelId: String?,brandId: String?,terminalId: String?,taskId: Int?,pageName: String?,appLangCode: String?,userTaskId: Int?){
        self.token = token
        self.siteId = siteId
        self.channelId = channelId
        self.brandId = brandId
        self.terminalId = terminalId
        self.taskId = taskId
        self.appLangCode = appLangCode
        self.userTaskId = userTaskId
    }
    
    init(){
        
    }
}
