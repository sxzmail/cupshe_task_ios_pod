//
//  TaskInfoParam.swift
//  TaskSDK
//
//  Created by gbl on 2023/10/27.
//

import Foundation

class TaskInfoParam : Codable{
    
    var siteId: String?
    var channelId: String?
    var brandId: String?
    var terminalId: String?
    var taskId: Int?
    var appLangCode: String?
    var token: String?

    init(token: String?,siteId:String?,channelId: String?,brandId: String?,terminalId: String?,taskId: Int?,appLangCode: String?){
        self.token = token
        self.siteId = siteId
        self.channelId = channelId
        self.brandId = brandId
        self.terminalId = terminalId
        self.taskId = taskId
        self.appLangCode = appLangCode
    }
    
    init(){
        
    }
}
