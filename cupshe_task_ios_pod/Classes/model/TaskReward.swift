//
//  TaskReward.swift
//  OcSwiftUIDemo
//
//  Created by gbl on 2023/10/12.
//

import Foundation
import SwiftyJSON

class TaskReward : Codable,GBSwiftyJSONAble,Identifiable {
    var taskRewardId: Int
    var taskRewardName: String
    var taskRewardDesc: String
    var rewardType: String
    var rewardValue: String
    var isDel: Int
    var createTime: String
    var updateTime: String
    
    init(){
        taskRewardId = 0
        taskRewardName = ""
        taskRewardDesc = ""
        rewardType = ""
        rewardValue = ""
        isDel = 0
        createTime = ""
        updateTime = ""
    }
    
    required init?(jsonData:JSON){
        self.taskRewardId = jsonData["taskRewardId"].intValue
        self.taskRewardName = jsonData["taskRewardName"].stringValue
        self.taskRewardDesc = jsonData["taskRewardDesc"].stringValue
        self.rewardType = jsonData["rewardType"].stringValue
        self.rewardValue = jsonData["rewardValue"].stringValue
        self.isDel = jsonData["isDel"].intValue
        self.createTime = jsonData["createTime"].stringValue
        self.updateTime = jsonData["updateTime"].stringValue
    }
}
