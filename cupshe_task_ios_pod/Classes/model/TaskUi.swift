//
//  TaskUi.swift
//  OcSwiftUIDemo
//
//  Created by gbl on 2023/10/12.
//

import Foundation
import SwiftyJSON

class TaskUi : Codable,GBSwiftyJSONAble,Identifiable {
    var taskUiId: Int
    var taskUiName: String
    var taskCategory: Int
    var uiBrand: Int
    var uiChannel: Int
    var uiSite: Int
    var uiTerminal: Int
    var startTime: String
    var isDel: Int
    var createTime: String
    var updateTime: String
    
    init(){

        taskUiId = 0
        taskUiName = ""
        taskCategory = 0
        uiBrand = 0
        uiChannel = 0
        uiSite = 0
        uiTerminal = 0
        startTime = ""
        isDel = 0
        createTime = ""
        updateTime = ""
    }
    
    required init?(jsonData:JSON){
        self.taskUiId = jsonData["taskUiId"].intValue
        self.taskUiName = jsonData["taskUiName"].stringValue
        self.taskCategory = jsonData["taskCategory"].intValue
        self.uiBrand = jsonData["uiBrand"].intValue
        self.uiChannel = jsonData["uiChannel"].intValue
        self.uiSite = jsonData["uiSite"].intValue
        self.uiTerminal = jsonData["uiTerminal"].intValue
        self.startTime = jsonData["startTime"].stringValue
        self.isDel = jsonData["isDel"].intValue
        self.createTime = jsonData["createTime"].stringValue
        self.updateTime = jsonData["updateTime"].stringValue
    }
}
