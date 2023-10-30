//
//  TaskSDK.swift
//  TaskSDK
//
//  Created by gbl on 2023/10/23.
//

import Foundation
import UIKit

@objcMembers
public class TaskENV : NSObject {
    public static var token: String = ""
    public static var brand: String = ""
    public static var channel: String = ""
    public static var site: String = ""
    public static var terminal: String = ""
    public static var lang: String = ""
    public static var activityId: String = ""
    public static var env:TaskEnvironment = TaskEnvironment.TEST
    public static var getRewardCallBack:AnyObject?
    public static var uiContextHanlderArr: WeakArray<UIView>?

}

@objcMembers
public class TaskSDK : NSObject {

    
    static var countDownView : CountdownView?
    static var taskListView : TaskListView?
    static var taskShareView: TaskShareView?

    
    public static func setEnv(token:String,brand:String,channel:String,site:String,terminal:String,lang:String,activityId:String){
        TaskENV.token = token
        TaskENV.brand = brand
        TaskENV.channel = channel
        TaskENV.site = site
        TaskENV.terminal = terminal
        TaskENV.lang = lang
        TaskENV.activityId = activityId
//        acceptDataWithClosure()
    }
    
    // 接收OC传递的Block,调用并回传数据
    public static func setGetRewardCallBack(parameter:[AnyHashable : Any]){
//        let callback = parameter["callback"]
        TaskENV.getRewardCallBack = parameter["callback"] as! AnyObject
        
    }
    
    public static func setToken(token:String){
        TaskENV.token = token
    }

    public static func setBrand(brand:String){
        TaskENV.brand = brand
    }

    public static func setChannel(channel:String){
        TaskENV.channel = channel
    }

    public static func setSite(site:String){
        TaskENV.site = site
    }

    public static func setTerminal(terminal:String){
        TaskENV.terminal = terminal
    }

    public static func setLang(lang:String){
        TaskENV.lang = lang
    }

    public static func setActivityId(activityId:String){
        TaskENV.activityId = activityId
    }
//
    public static func setUiContextHanlder(uiContextHanlder: UIView?){
        if TaskENV.uiContextHanlderArr == nil {
            TaskENV.uiContextHanlderArr = WeakArray<UIView>()
        }
        TaskENV.uiContextHanlderArr!.append( uiContextHanlder)
    }

    public static func setTaskEnvironment(env : TaskEnvironment){
        TaskENV.env = env
    }

    public static func stopPageView(){
        if TaskSDK.countDownView != nil {
            TaskSDK.countDownView!.dismissCountdownView()
            TaskSDK.countDownView = nil
        }
        
        if TaskSDK.taskShareView != nil {
            TaskSDK.taskShareView!.dismissTaskShare()
            TaskSDK.taskShareView = nil
        }


        if TaskSDK.taskListView != nil {
            TaskSDK.taskListView!.dismissTaskList()
            TaskSDK.taskListView = nil
        }
    }
    
    public static func showTaskList(){
        if  TaskSDK.getUiContextFunc() != nil {
            //得到当前用户所有的任务
            
            let query: TaskListParam = TaskListParam()
            
            query.token = TaskENV.token
            
            if !TaskENV.brand.isEmpty {
                query.brandId = TaskENV.brand
            }
            if !TaskENV.channel.isEmpty {
                query.channelId = TaskENV.channel
            }
            if !TaskENV.site.isEmpty {
                query.siteId = TaskENV.site
            }
            if !TaskENV.terminal.isEmpty {
                query.terminalId = TaskENV.terminal
            }
            if !TaskENV.lang.isEmpty {
                query.appLangCode = TaskENV.lang
            }
            
            if !TaskENV.activityId.isEmpty {
                query.activityId = TaskENV.activityId
            }
            
//        brand: self.brand, channel: self.channel, site: self.site, terminal: self.terminal, lang: self.lang
            TaskVM().getTaksList(env:TaskENV.env,token: TaskENV.token, params: query) { taskList in

               
                if taskList != nil && taskList!.count > 0  && TaskSDK.getUiContextFunc() != nil{
                    
                    if TaskSDK.taskListView != nil {
                        TaskSDK.taskListView!.dismissTaskList()
                        TaskSDK.taskListView = nil
                    }
                    
                    
//                    print(taskList)
//                    if self.taskListView == nil {
                    TaskSDK.taskListView = TaskListView(frame: CGRect(x: 0, y: 0, width: 0, height: 0))
                        
                    TaskSDK.taskListView!.initView()
//                    }
                    
                    TaskSDK.taskListView!.setListData(taskList: taskList!)
                    TaskSDK.taskListView!.showView { flag in
//                        self.clickListFlag = false
                    }
                   
                }
                
            }
        }

    }

    public static func closeTaskList(){
        if TaskSDK.taskListView != nil {
            TaskSDK.taskListView!.dismissTaskList()
            TaskSDK.taskListView = nil
        }
    }
    
    public static func showShareView(taskId:Int){
        if TaskSDK.getUiContextFunc() != nil{
            
            if TaskSDK.taskShareView != nil {
                TaskSDK.taskShareView!.dismissTaskShare()
                TaskSDK.taskShareView = nil
            }
           
            TaskSDK.taskShareView = TaskShareView(frame: CGRect(x: 0, y: 0, width: 0, height: 0))

            TaskSDK.taskShareView!.initView(taskId: taskId)

            TaskSDK.taskShareView!.showView()
        }

    }


    public static func closeShareView(){

//        closeCountdownView();
        if TaskSDK.taskShareView != nil {
            TaskSDK.taskShareView!.dismissTaskShare()
        }
    }
    
    public static func startPageView(taskId:Int){
        if TaskSDK.getUiContextFunc() != nil {
            let query: TaskPageViewParam = TaskPageViewParam()
            query.token = TaskENV.token
            if !TaskENV.brand.isEmpty{
                query.brandId = TaskENV.brand
            }
            if !TaskENV.channel.isEmpty{
                query.channelId = TaskENV.channel
            }
            if !TaskENV.site.isEmpty {
                query.siteId = TaskENV.site
            }
            if !TaskENV.terminal.isEmpty {
                query.terminalId = TaskENV.terminal
            }

            if !TaskENV.lang.isEmpty {
                query.appLangCode = TaskENV.lang
            }
            if taskId != nil && taskId > 0 {
                query.taskId  = taskId
            }
            TaskVM().startPageViewTask(env:TaskENV.env,token: TaskENV.token, params: query) { info in
                if info != nil {
                    //开始浏览任务
                    
                    if TaskSDK.countDownView != nil {
                        TaskSDK.countDownView!.removeFromSuperview()
                        TaskSDK.countDownView = nil
                    }
                    
                    TaskSDK.countDownView = CountdownView(frame: CGRect(x: 0, y: 0, width: 0, height: 0))
                    TaskSDK.countDownView!.showView(data: info!)
                    
                    
                    //        showCountdownView();
                }
            }
        }
    }
    
    public static func getUiContextFunc() -> UIView?{
        if TaskENV.uiContextHanlderArr != nil {
            

            
            if TaskENV.uiContextHanlderArr!.allObjects().isEmpty {
                
                return nil
            }
            
            return TaskENV.uiContextHanlderArr!.allObjects().last

        }
        return nil
    }
    
    
    public static func startExecuteTask(taskId:Int) {
        
        if taskId > 0 {
            
            let query: TaskInfoParam = TaskInfoParam()
            query.token = TaskENV.token
            query.taskId  = taskId
            if !TaskENV.brand.isEmpty {
                query.brandId = TaskENV.brand
            }
            if !TaskENV.channel.isEmpty {
                query.channelId = TaskENV.channel
            }
            if !TaskENV.site.isEmpty {
                query.siteId = TaskENV.site
            }
            if !TaskENV.terminal.isEmpty {
                query.terminalId = TaskENV.terminal
            }
            if !TaskENV.lang.isEmpty {
                query.appLangCode = TaskENV.lang
            }
           
            
            TaskVM().getTaskInfo(env:TaskENV.env,token: TaskENV.token, params: query, callback: { taskInfoVo in
                if taskInfoVo != nil {
                    
                    let type = taskInfoVo!.targetType
                    
                    if type == TaskType.PAGE_VIEW {
                        //浏览
                        let taskInfo:TaskInfoVO = TaskInfoVO()
                        var taskPageViewParam: [AnyHashable : Any] = ["taskId" : taskId, "type": TaskType.PAGE_VIEW, "jumpPageUrl" : taskInfo.targetAppUrl, "activityId": TaskENV.activityId]
                        //发送通知
                        NotificationCenter.default.post(name: NSNotification.Name(rawValue: "notify_taskPageView"), object: nil, userInfo:taskPageViewParam)
                    }else if type == TaskType.SHARE {
                        //分享
                        if TaskSDK.getUiContextFunc() != nil {
                            if TaskSDK.taskShareView != nil {
                                TaskSDK.taskShareView!.dismissTaskShare()
                                TaskSDK.taskShareView = nil
                            }
                            TaskSDK.taskShareView = TaskShareView(frame: CGRect(x: 0, y: 0, width: 0, height: 0))
                            
                            TaskSDK.taskShareView!.initView(taskId: taskId)
                            TaskSDK.taskShareView!.showView()
                        }

                    }
                }
            })
        }
        
        
    }
    
}
