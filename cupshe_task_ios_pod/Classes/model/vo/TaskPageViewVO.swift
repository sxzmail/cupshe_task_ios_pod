//
//  TaskPageViewVO.swift
//  OcSwiftUIDemo
//
//  Created by gbl on 2023/10/18.
//

import Foundation
import SwiftyJSON

class TaskPageViewVO : Codable,GBSwiftyJSONAble,Identifiable {

    var taskId: Int
    var redirectUrl:  String
    var targetValue:  Int
    var taskRetention: String
    var endImageUrlWeb: String
    var startImageUrlApp: String
    var uiDesc: String
    var endImageUrlApp: String
    var startImageUrlWeb: String
    var userTaskId: Int
    
   
    
    init(){
        taskId = 0
        redirectUrl = ""
        targetValue = 0
        taskRetention = ""
        endImageUrlWeb = ""
        startImageUrlApp = ""
        uiDesc = ""
        endImageUrlApp = ""
        startImageUrlWeb = ""
        userTaskId = 0
        
    }
    
    required init?(jsonData:JSON){
        self.taskId = jsonData["taskId"].intValue
        self.redirectUrl = jsonData["redirectUrl"].stringValue
        self.targetValue = jsonData["targetValue"].intValue
        self.taskRetention = jsonData["taskRetention"].stringValue
        self.endImageUrlWeb = jsonData["endImageUrlWeb"].stringValue
        self.startImageUrlApp = jsonData["startImageUrlApp"].stringValue
        self.uiDesc = jsonData["uiDesc"].stringValue
        self.endImageUrlApp = jsonData["endImageUrlApp"].stringValue
        self.startImageUrlWeb = jsonData["startImageUrlWeb"].stringValue
        self.userTaskId = jsonData["userTaskId"].intValue
       
    }
}
    

