//
//  TaskCategory.swift
//  OcSwiftUIDemo
//
//  Created by gbl on 2023/10/12.
//
import Foundation
import SwiftyJSON

class TaskCategory : Codable,GBSwiftyJSONAble,Identifiable {
    var taskCategoryId:Int
    var taskCategoryName: String
    var isDel: Int
    var createTime: String
    var updateTime: String
   
    
    init(){
        taskCategoryId = 0
        taskCategoryName = ""
        isDel = 0
        createTime = ""
        updateTime = ""
    }
    
    required init?(jsonData:JSON){
        self.taskCategoryId = jsonData["taskCategoryId"].intValue
        self.taskCategoryName = jsonData["taskCategoryName"].stringValue
        self.isDel = jsonData["isDel"].intValue
        self.createTime = jsonData["createTime"].stringValue
        self.updateTime = jsonData["updateTime"].stringValue
    }
}
