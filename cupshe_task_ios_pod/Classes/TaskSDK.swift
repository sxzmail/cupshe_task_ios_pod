//
//  TaskSDK.swift
//  TaskSDK
//
//  Created by gbl on 2023/10/23.
//

import Foundation
import UIKit



@objcMembers
public class TaskSDK : NSObject {

//    public static let instance = TaskSDK()
//    weak private var uiContextHanlder: UIView?
    
    private var token: String = ""
    private var brand: String = ""
    private var channel: String = ""
    private var site: String = ""
    private var terminal: String = ""
    private var lang: String = ""
    private var activityId: String = ""
    
    private var env:TaskEnvironment = TaskEnvironment.TEST
    
    private var countDownView : CountdownView?
    private var taskListView : TaskListView?
    private var taskShareView: TaskShareView?
//    private var taskShareView : TaskShareView?
    
    private var taskVm: TaskVM = TaskVM()
    
    private var userTaskId:Int = 0
    
    private var callbackBlock: ((String) -> Void)?
    
    private var goBrowsCallBack:(( [AnyHashable : Any]) -> Void)?
    
    private var shareCallBack:(( [AnyHashable : Any]) -> Void)?
    
    private var clickListFlag: Bool = false
    
    private var refreshPageCallBack:((Bool) -> Void)?
    
    
//    public func initSdk(token:String,brand:String,channel:String,site:String,terminal:String,lang:String,activityId:String,uiContextHanlder: UIView) -> TaskSDK{
//
//        self.token = token
//        self.brand = brand
//        self.channel = channel
//        self.site = site
//        self.terminal = terminal
//        self.lang = lang
//        self.uiContextHanlder = uiContextHanlder
//        self.activityId = activityId
//        return self
//    }
    
    
    
     public init(token:String,brand:String,channel:String,site:String,terminal:String,lang:String,activityId:String) {
       super.init()
       self.token = token
        self.brand = brand
        self.channel = channel
        self.site = site
        self.terminal = terminal
        self.lang = lang
        self.activityId = activityId
    }
    
  
    
    // 接收OC传递的Block,调用并回传数据
    public func setGetRewardCallBack(completion : @escaping ((String) -> Void)) {
//        let callback = parameter["callback"]
        self.callbackBlock = completion;
//        self.callbackBlock = parameter["callback"] as! AnyObject
        
    }
    
    public func setGoBrowsCallback(completion: @escaping (( [AnyHashable : Any] ) -> Void)){
//        let callback = parameter["callback"]
        self.goBrowsCallBack = completion
        
    }
    
    public func setShareCallback(completion: @escaping (( [AnyHashable : Any] ) -> Void)){
        //        let callback = parameter["callback"]
        self.shareCallBack = completion
        
    }
    
    public func setRefreshPage(completion: @escaping ((Bool) -> Void)){
        self.refreshPageCallBack = completion
    }
    
    public func setToken(token:String){
        self.token = token
    }
    
    public func setBrand(brand:String){
        self.brand = brand
    }
    
    public func setChannel(channel:String){
        self.channel = channel
    }
    
    public func setSite(site:String){
        self.site = site
    }
    
    public func setTerminal(terminal:String){
        self.terminal = terminal
    }
    
    public func setLang(lang:String){
        self.lang = lang
    }
    
    public func setActivityId(activityId:String){
        self.activityId = activityId
    }
    
//    public func setUiContextHanlder(uiContextHanlder: UIView){
//        self.uiContextHanlder = uiContextHanlder
//    }
    
    public func setTaskEnvironment(env : TaskEnvironment){
        self.env = env
    }


    public func stopPageView(){
        if self.countDownView != nil {
            self.countDownView!.dismissCountdownView()
            self.countDownView = nil
        }
        
        if self.taskListView != nil {
            self.taskListView!.dismissTaskList()
            self.taskListView = nil
        }
        
        if self.taskShareView != nil {
            self.taskShareView!.dismissTaskShare()
            self.taskShareView = nil
        }
//
//        if self.uiContextHanlder != nil {
//            self.uiContextHanlder!.removeFromSuperview()
//            self.uiContextHanlder = nil
//
//        }
//        closeCountdownView();
    }
    
    public func showTaskList(uiContextHanlder: UIView){
        if self.clickListFlag {
            
            return
        }
       
        self.clickListFlag = true
        //得到当前用户所有的任务
        
        let query: TaskListParam = TaskListParam()
        
        query.token = self.token
        
        if !self.brand.isEmpty {
            query.brandId = self.brand
        }
        if !self.channel.isEmpty {
            query.channelId = self.channel
        }
        if !self.site.isEmpty {
            query.siteId = self.site
        }
        if !self.terminal.isEmpty {
            query.terminalId = self.terminal
        }
        if !self.lang.isEmpty {
            query.appLangCode = self.lang
        }
        
        if !self.activityId.isEmpty {
            query.activityId = self.activityId
        }
        
//        brand: self.brand, channel: self.channel, site: self.site, terminal: self.terminal, lang: self.lang
        
        taskVm.getTaksList(env:self.env,token: self.token, params: query) { taskList in

            
            if taskList != nil && taskList!.count > 0 {
                
                if self.taskListView != nil {
                    self.taskListView!.dismissTaskList()
                    self.taskListView = nil
                }
//                    print(taskList)
//                    if self.taskListView == nil {
                self.taskListView = TaskListView(frame: CGRect(x: 0, y: 0, width: 0, height: 0))
                    
                self.taskListView!.initView(uiViewController: uiContextHanlder, brand: self.brand, channel: self.channel, site: self.site, terminal: self.terminal, token: self.token,lang: self.lang,activityId:self.activityId,env: self.env,callbackFunc:self.goBrowsCallBack!,shareCallBackFunc:self.shareCallBack!,refreshPageCallbackFunc: self.refreshPageCallBack!)
//                    }
                
                self.taskListView!.setListData(taskList: taskList!)
                self.taskListView!.showView { flag in
                    self.clickListFlag = false
                }
            }
            
        }
        

    }

    public func closeTaskList(){
        
//        closeCountdownView();
        if self.taskListView != nil {
            self.taskListView!.dismissTaskList()
        }
    }
    
//    public func showShareView(){
//        if self.uiContextHanlder != nil {
//            //得到当前用户所有的任务
////            taskVm.getTaksList(userId: self.userId, brand: self.brand, channel: self.channel, site: self.site, terminal: self.terminal, lang: self.lang) { taskList in
////
////                if taskList != nil && taskList!.count > 0 {
//                    if self.taskShareView == nil {
//                        self.taskShareView = TaskShareView(frame: CGRect(x: 0, y: 0, width: 0, height: 0))
//
//                        self.taskShareView!.initView(uiViewController: self.uiContextHanlder!, brand: self.brand, channel: self.channel, site: self.site, terminal: self.terminal, token: self.token,lang: self.lang)
//                    }
//
////                    self.taskListView!.setListData(taskList: taskList!)
//
//                    self.taskShareView!.showView()
////                }
////
////            }
//        }
//
//    }
//
//
//    public func closeShareView(){
//
////        closeCountdownView();
//        if self.taskShareView != nil {
//            self.taskShareView?.dismissTaskShare()
//        }
//    }
    
    
    public func startPageView(uiContextHanlder:UIView,taskId:Int){
      
        let query: TaskPageViewParam = TaskPageViewParam()
        query.token = self.token
        if !self.brand.isEmpty{
            query.brandId = self.brand
        }
        if !self.channel.isEmpty{
            query.channelId = self.channel
        }
        if !self.site.isEmpty {
            query.siteId = self.site
        }
        if !self.terminal.isEmpty {
            query.terminalId = self.terminal
        }

        if !self.lang.isEmpty {
            query.appLangCode = self.lang
        }
        if taskId != nil && taskId > 0 {
            query.taskId  = taskId
            taskVm.startPageViewTask(env:self.env,token: self.token, params: query) { info in
                if info != nil {
                    //开始浏览任务
                        
                    self.countDownView = CountdownView(frame: CGRect(x: 0, y: 0, width: 0, height: 0))
                    self.countDownView!.showView(uiViewController: uiContextHanlder,token: self.token,brand: self.brand, channel: self.channel, site: self.site, terminal: self.terminal,lang: self.lang,data:info!,env: self.env,activityId: self.activityId,notifyCallbacdk:self.callbackBlock!)
                    
                    
                    //        showCountdownView();
                }
            }
        }
            
        
    }
    
    
    public func startExecuteTask(uiContextHanlder:UIView,taskId:Int) {
        
        if taskId > 0 {
            
            let query: TaskInfoParam = TaskInfoParam()
            query.token = self.token
            query.taskId  = taskId
            if !self.brand.isEmpty {
                query.brandId = self.brand
            }
            if !self.channel.isEmpty {
                query.channelId = self.channel
            }
            if !self.site.isEmpty {
                query.siteId = self.site
            }
            if !self.terminal.isEmpty {
                query.terminalId = self.terminal
            }
            if !self.lang.isEmpty {
                query.appLangCode = self.lang
            }
           
            
            self.taskVm.getTaskInfo(env:self.env,token: self.token, params: query, callback: { taskInfoVo in
                if taskInfoVo != nil {
                    
                    let type = taskInfoVo!.targetType
                    
                    if type == TaskType.PAGE_VIEW {
                        //浏览
                    
                        
                        var taskPageViewParam: [AnyHashable : Any] = ["taskId" : taskId, "type": TaskType.PAGE_VIEW, "jumpPageUrl" : taskInfoVo!.targetAppUrl, "activityId": self.activityId]
                        //发送通知
                      
                        if self.goBrowsCallBack != nil {
                            self.goBrowsCallBack!(taskPageViewParam)
                        }
//
//
//
//                        //发送通知
//                        NotificationCenter.default.post(name: NSNotification.Name(rawValue: "notify_taskPageView"), object: nil, userInfo:taskPageViewParam)
                    }else if type == TaskType.SHARE {
                        //分享
                       
                        if self.taskShareView != nil {
                            self.taskShareView!.dismissTaskShare()
                            self.taskShareView = nil
                        }
                        self.taskShareView = TaskShareView(frame: CGRect(x: 0, y: 0, width: 0, height: 0))
                        
                        self.taskShareView!.initView(uiViewController: uiContextHanlder, brand: self.brand, channel: self.channel, site: self.site, terminal: self.terminal, token: self.token,lang: self.lang,activityId: self.activityId,taskId: taskId,env: self.env,notifyCallbacdk: self.shareCallBack!)
                        self.taskShareView!.showView()
                        

                    }
                }
            })
        }
        
        
    }
    
}
