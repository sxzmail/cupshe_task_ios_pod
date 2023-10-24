//
//  TaskCheckInParam.swift
//  OcSwiftUIDemo
//
//  Created by gbl on 2023/10/18.
//

import Foundation

class TaskCheckInParam : Codable{
    
    var siteId: String?
    var channelId: String?
    var brandId: String?
    var terminalId: String?
    var taskId: Int?
    var appLangCode: String?
    var token: String?
    var actionId: String?
    init(token: String?,siteId:String?,channelId: String?,brandId: String?,terminalId: String?,taskId: Int?,appLangCode: String?,actionId: String?){
        self.token = token
        self.siteId = siteId
        self.channelId = channelId
        self.brandId = brandId
        self.terminalId = terminalId
        self.taskId = taskId
        self.appLangCode = appLangCode
        self.actionId = actionId
    }
    
    init(){
        
    }
}
