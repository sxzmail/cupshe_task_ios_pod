//
//  ApiConfig.swift
//  OcSwiftUIDemo
//
//  Created by gbl on 2023/10/12.
//

import Foundation

struct ApiConfig {

    public static var API_PATH_TEST = "https://task-release.kapeixi.cn/task-service/"
    
    public static var API_PATH_PRE = ""
    
    public static var API_PATH_PRODUCTION = "https://task-service.cupshe.com/task-service/"
    //获取用户任务列表
    public static var API_GET_TASK_LIST =  "userTask/getTaskList"
    
    //用户签到
    public static var API_CHECK_IN =  "userTask/userTaskAction"

    //页面浏览任务开始
    public static var API_Page_VIEW_TASK_START =  "userTask/startPageViewiOS"
    //页面浏览任务结束
    public static var API_Page_VIEW_TASK_STOP =  "userTask/stopPageView"
    //获取分享id
    public static var API_GET_USER_SHARE_ID =  "userTask/getUserShareId"
    
    //获取分享链接地址
    public static var API_GET_SHARE_URL =  "userTask/getShareUrl"
    
    public static var API_LOGIN =  "login"
    
    
    public static func getAPIPath(env:TaskEnvironment) -> String{
        switch env {
        case .TEST:
            return ApiConfig.API_PATH_TEST
        case .PRE:
            return ApiConfig.API_PATH_PRE
        case .PRODUCTION:
            return ApiConfig.API_PATH_PRODUCTION
        }
        
        return ""
    }

}

