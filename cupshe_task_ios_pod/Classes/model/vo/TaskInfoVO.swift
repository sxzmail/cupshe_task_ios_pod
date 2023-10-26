//
//  TaskInfoVO.swift
//  OcSwiftUIDemo
//
//  Created by gbl on 2023/10/16.
//

import Foundation
import SwiftyJSON

class TaskInfoVO : Codable,GBSwiftyJSONAble,Identifiable {
    var taskId: Int
    var taskName:  String
    var taskDesc:  String
    var taskRetention: String
    var taskCategory: Int
    var taskBrand: Int
    var taskChannel: Int
    var taskSite: Int
    var taskTerminal: Int
    var status: Int
    var startTime: String
    var endTime: String
    var targetId: Int
    var rewardId: Int
    var rewardCount: Int
    var finishType: Int
    var finishCountLimit: Int
    var finishStartTime: String
    var finishEndTime: String
    var finishedCount: Int
    
    var taskTargetId: Int
    var taskTargetName: String
    var taskTargetDesc: String
    var targetType: String
    var targetAction: String
    var targetValue: Int
    var targetUrl: String
    var targetPage: String
    var activityId: Int
    
    var progressStatus: Int //完成状态
    var canExcute: Bool //可执行状态
   
    var taskActivityId: String
    
    var targetAppUrl: String
    var targetAppPage: String
    
    init(){
        taskId = 0
        taskName = ""
        taskDesc = ""
        taskRetention = ""
        taskCategory = 0
        taskBrand = 0
        taskChannel = 0
        taskSite = 0
        taskTerminal = 0
        status = 0
        startTime = ""
        endTime = ""
        targetId = 0
        rewardId = 0
        rewardCount = 0
        finishType = 0
        finishCountLimit = 0
        finishStartTime = ""
        finishEndTime = ""
        taskTargetId = 0
        taskTargetName = ""
        taskTargetDesc = ""
        targetType = ""
        targetAction = ""
        targetValue = 0
        targetUrl = ""
        targetPage = ""
        activityId = 0
        progressStatus = 0
        canExcute = false
        taskActivityId = ""
        targetAppUrl = ""
        targetAppPage = ""
        finishedCount = 0

    }
    
    required init?(jsonData:JSON){
        self.taskId = jsonData["taskId"].intValue
//        self.taskName = jsonData["taskName"].arrayValue.flatMap { LangVO(jsonData: $0) }
//        self.taskDesc = jsonData["taskDesc"].arrayValue.flatMap { LangVO(jsonData: $0) }
        self.taskName = jsonData["taskName"].stringValue
        self.taskDesc = jsonData["taskDesc"].stringValue
        self.taskRetention = jsonData["taskRetention"].stringValue
        self.taskCategory = jsonData["taskCategory"].intValue
        self.taskBrand = jsonData["taskBrand"].intValue
        self.taskChannel = jsonData["taskChannel"].intValue
        self.taskSite = jsonData["taskSite"].intValue
        self.taskTerminal = jsonData["taskTerminal"].intValue
        self.status = jsonData["status"].intValue
        self.startTime = jsonData["startTime"].stringValue
        self.endTime = jsonData["endTime"].stringValue
        self.targetId = jsonData["targetId"].intValue
        self.rewardId = jsonData["rewardId"].intValue
        self.rewardCount = jsonData["rewardCount"].intValue
        self.finishType = jsonData["finishType"].intValue
        self.finishCountLimit = jsonData["finishCountLimit"].intValue
        self.finishStartTime = jsonData["finishStartTime"].stringValue
        self.finishEndTime = jsonData["finishEndTime"].stringValue
        self.taskTargetId = jsonData["taskTargetId"].intValue
        self.taskTargetName = jsonData["taskTargetName"].stringValue
        self.taskTargetDesc = jsonData["taskTargetDesc"].stringValue
        self.targetType = jsonData["targetType"].stringValue
        self.targetAction = jsonData["targetAction"].stringValue
        self.targetValue = jsonData["targetValue"].intValue
        self.targetUrl = jsonData["targetUrl"].stringValue
        self.targetPage = jsonData["targetPage"].stringValue
        self.activityId = jsonData["activityId"].intValue
        self.progressStatus = jsonData["progressStatus"].intValue
        self.canExcute = jsonData["canExcute"].boolValue
        self.taskActivityId = jsonData["taskActivityId"].stringValue
        self.targetAppUrl = jsonData["targetAppUrl"].stringValue
        self.targetAppPage = jsonData["targetAppPage"].stringValue
        self.finishedCount = jsonData["finishedCount"].intValue
    }
}
