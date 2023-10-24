//
//  TaskInfo.swift
//  OcSwiftUIDemo
//
//  Created by gbl on 2023/10/12.
//

import Foundation
import SwiftyJSON

class TaskInfo : Codable,GBSwiftyJSONAble,Identifiable {
    var taskId: Int
    var taskName: String
    var taskDesc: String
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
    var isDel: Int
    var createTime: String
    var updateTime: String
//    var taskActivityId: String
   
    
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
        isDel = 0
        createTime = ""
        updateTime = ""
    }
    
    required init?(jsonData:JSON){
        self.taskId = jsonData["taskId"].intValue
        
//        let taskNameJsonStr = jsonData["taskName"].stringValue
//        if taskNameJsonStr != nil {
////            let taskNameList = JSON(taskNameJsonStr)
//            self.taskName = taskNameJsonStr.flatMap { LangVO(jsonData: $0) }
//        }
        
//        if jsonData["notes"].count > 0 {
//            var idx = 0
//            jsonData["notes"].map(){ (_,v) in
//                if idx == 0 {
//                    notes!.append(Note(v,new_page,new_system))
//                }else{
//                    notes!.append(Note(v))
//                }
//                idx += 1
//                return v
//            }
//        }else{
//            notes = nil
//        }
        
        
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
        self.isDel = jsonData["isDel"].intValue
        self.createTime = jsonData["createTime"].stringValue
        self.updateTime = jsonData["updateTime"].stringValue
    }
}
