//
//  UserTaskProgress.swift
//  OcSwiftUIDemo
//
//  Created by gbl on 2023/10/12.
//

import Foundation
import SwiftyJSON

class UserTaskProgress : Codable,GBSwiftyJSONAble,Identifiable {
    var userId: Int
    var taskId: Int
    var status: Int
    var startTime: String
    var endTime: String
    var targetFinishCount: Int
    var rewardId: Int
    var rewardCount: Int
    var isDel: Int
    var createTime: String
    var updateTime: String

    init(){
        userId = 0
        taskId = 0
        status = 0
        startTime = ""
        endTime = ""
        targetFinishCount = 0
        rewardId = 0
        rewardCount = 0
        isDel = 0
        createTime = ""
        updateTime = ""
    }
    
    required init?(jsonData:JSON){
        self.userId = jsonData["userId"].intValue
        self.taskId = jsonData["taskId"].intValue
        self.status = jsonData["status"].intValue
        self.startTime = jsonData["startTime"].stringValue
        self.endTime = jsonData["endTime"].stringValue
        self.targetFinishCount = jsonData["targetId"].intValue
        self.rewardId = jsonData["rewardId"].intValue
        self.rewardCount = jsonData["rewardCount"].intValue
        self.isDel = jsonData["isDel"].intValue
        self.createTime = jsonData["createTime"].stringValue
        self.updateTime = jsonData["updateTime"].stringValue
    }
}
