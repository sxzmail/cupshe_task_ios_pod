//
//  TaskTarget.swift
//  OcSwiftUIDemo
//
//  Created by gbl on 2023/10/12.
//

import Foundation
import SwiftyJSON

class TaskTarget : Codable,GBSwiftyJSONAble,Identifiable {
    var taskTargetId: Int
    var taskTargetName: String
    var taskTargetDesc: String
    var targetType: String
    var targetAction: String
    var targetValue: Int
    var targetUrl: String
    var targetPage: String
    var activityId: String
    var isDel: Int
    var createTime: String
    var updateTime: String
    var targetAppUrl: String
    var targetAppPage: String
    
    init(){

        taskTargetId = 0
        taskTargetName = ""
        taskTargetDesc = ""
        targetType = ""
        targetAction = ""
        targetValue = 0
        targetUrl = ""
        targetPage = ""
        activityId = ""
        isDel = 0
        createTime = ""
        updateTime = ""
        targetAppUrl = ""
        targetAppPage = ""
    }
    
    required init?(jsonData:JSON){
        self.taskTargetId = jsonData["taskTargetId"].intValue
        self.taskTargetName = jsonData["taskTargetName"].stringValue
        self.taskTargetDesc = jsonData["taskTargetDesc"].stringValue
        self.targetType = jsonData["targetType"].stringValue
        self.targetAction = jsonData["targetAction"].stringValue
        self.targetValue = jsonData["targetValue"].intValue
        self.targetUrl = jsonData["targetUrl"].stringValue
        self.targetPage = jsonData["targetPage"].stringValue
        self.activityId = jsonData["activityId"].stringValue
        self.isDel = jsonData["isDel"].intValue
        self.createTime = jsonData["createTime"].stringValue
        self.updateTime = jsonData["updateTime"].stringValue
        self.targetAppUrl = jsonData["targetAppUrl"].stringValue
        self.targetAppPage = jsonData["targetAppPage"].stringValue
    }
}
