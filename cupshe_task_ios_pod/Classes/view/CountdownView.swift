//
//  TaskBrowseView.swift
//  OcSwiftUIDemo
//
//  Created by gbl on 2023/10/12.
//

import Foundation

import UIKit

//@objcMembers
class CountdownView : UIView{
    private var timer: DispatchSourceTimer? = nil
//    private var dataQueue:DispatchQueue?
    
    private var taskVm: TaskVM = TaskVM()
    private var globalVm: GlobalVM = GlobalVM()
    private var fontManager:FontManager = FontManager()
    private var sdkManager:SdkManager = SdkManager()
    
    private var screenWidth:CGFloat = UIScreen.main.bounds.width
    private var screenHeight:CGFloat = UIScreen.main.bounds.height

    private var widthPercent:CGFloat = 0.0
    private var heightPercent:CGFloat = 0.0
    
    private var baseProgressVal: Float = 10.0
    
    private var tipsBgColor:UIColor = UIColor(red: CGFloat(0/255.0), green: CGFloat(0/255.0), blue: CGFloat(0/255.0), alpha: 0.3)
    
    private var progressBarStartColor:UIColor = UIColor(red: CGFloat(255/255.0), green: CGFloat(138/255.0), blue: 0, alpha: 1)
    
    private var progressBarEndColor:UIColor = UIColor(red: CGFloat(251/255.0), green: CGFloat(8/255.0), blue: 0, alpha: 1)
    
    private var progressBarBgColor:UIColor = UIColor(red: CGFloat(194/255.0), green: CGFloat(194/255.0), blue: CGFloat(194/255.0), alpha: 1)
    
    private var lang:String = ""
    private var token:String = ""
    private var brand: String = ""
    private var channel: String = ""
    private var site: String = ""
    private var terminal: String = ""
    private var env:TaskEnvironment?
    private var activityId: String = ""
    
    
    
//    private var countDownSecbase: Int = 5
    private var countDownSec: Int = 0
    private var proressPercentVal:Float = 0.0
    private var taskPageViewData:TaskPageViewVO?
    
    private var progressView: GradientProgressView?
    private var countDownLbl:SubclassedUIButton?
    private var browseIcon:SubclassedUIButton?
    private var countDownTipsView: UIView?
    private var tipsTriangle:UIImageView?
    
    private var boldPath:String?
    private var demiPath:String?
//    private var mediumPath:String?
//    private var regularPath:String?
//
//    private var task_desc_txt_color:UIColor = UIColor(red: CGFloat(102/255.0), green: CGFloat(102/255.0), blue: CGFloat(102/255.0), alpha: 1)

    required public init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    override init(frame: CGRect){
        super.init(frame: frame)
        
//        fontManager.regCustomFont(for: CountdownView.self)
        self.boldPath = fontManager.getBoldFontPath(for: CountdownView.self)
        self.demiPath = fontManager.getDemiFontPath(for: TaskListView.self)
//        self.mediumPath = fontManager.getMediumFontPath(for: TaskListView.self)
//        self.regularPath = fontManager.getrRegularFontPath(for: TaskListView.self)
    }

    public func showView(uiViewController: UIViewController,token:String,brand:String,channel:String,site:String,terminal:String,lang: String,data:TaskPageViewVO,env:TaskEnvironment,activityId:String){
        self.activityId = activityId
        self.env = env
        self.taskPageViewData = data
        self.token = token
        self.lang = lang
        self.countDownSec = self.taskPageViewData!.targetValue
//        self.countDownSec = self.taskPageViewData!.targetValue
       
        widthPercent = 1.0 //screenWidth / ScreenConfig.baseWidth
        heightPercent = 1.0 // screenHeight / ScreenConfig.baseHeight
        
        self.browseIcon = SubclassedUIButton(frame: CGRect(x: 0, y: 0, width: 46 * widthPercent, height: 46 * widthPercent))
        if data.startImageUrlApp.isEmpty {
            self.browseIcon!.setBackgroundImage(sdkManager.sdk_img(named: "gift"), for: .normal)
        } else {
            globalVm.fetchRemoteImage(data.startImageUrlApp) { imgData in
                if imgData != nil {
                    if UIImage(data: imgData!) != nil {
                        self.browseIcon!.setBackgroundImage(UIImage(data: imgData!)!, for: .normal)
                    }
                }
            }
        }
        self.addSubview(self.browseIcon!)
        
        
        countDownTipsView = UIView(frame: CGRect(x:  -160, y: 8, width: 152, height: 27))
        self.countDownTipsView!.backgroundColor = tipsBgColor
        self.countDownTipsView?.layer.cornerRadius = 5
    
        var tipsLbl:TipsUILabel = TipsUILabel(frame: CGRect(x: 0,y: 0, width: 152, height: 27))
        if self.taskPageViewData != nil && !self.taskPageViewData!.uiDesc.isEmpty {
            tipsLbl.text = self.taskPageViewData!.uiDesc
        }else{
            tipsLbl.text = "Lucky Draw Chances +1"
        }
        
        tipsLbl.textAlignment = .center
        tipsLbl.textColor = .white
        tipsLbl.font = UIFont.init(name: "AvenirNextLTPro-Medium", size: 12 * heightPercent)

        
    
        self.countDownTipsView!.alpha = 1
        self.countDownTipsView!.addSubview(tipsLbl)
        
        
        
        
        self.tipsTriangle = UIImageView(frame: CGRect(x: -8, y: 19,width: 6.02 , height: 4))
        self.tipsTriangle!.image = sdkManager.sdk_img(named: "Triangle")
        
        self.tipsTriangle!.alpha = 1
        
        self.addSubview(self.countDownTipsView!)
        self.addSubview(self.tipsTriangle!)
        
        
        
        
        var progressBg: UIView = UIView(frame: CGRect(x: 0, y: (46-9) * widthPercent, width: 46 * widthPercent, height: 18 * heightPercent))
        progressBg.backgroundColor = progressBarBgColor
        progressBg.layer.cornerRadius = 10
        
        progressView = GradientProgressView(frame: CGRect(x: 0, y: (46-9) * widthPercent, width: 46 * widthPercent, height: 18 * heightPercent))
        //设置圆角
        progressView!.layer.cornerRadius = 10
        //设置进度条圆角
        progressView!.progressCornerRadius = 10
        //设置纯色和渐变色
        progressView!.progressColors = [progressBarStartColor,progressBarEndColor]
        //动画时间
        progressView!.animationDuration = 0.2
        //动画函数
        progressView!.timingFunction = CAMediaTimingFunction(name: .linear)
        
        self.addSubview(progressBg)
        self.addSubview(progressView!)
        
        
        countDownLbl = SubclassedUIButton(frame: CGRect(x: 0, y: (46-9) * widthPercent, width: 46 * widthPercent, height: 18 * heightPercent))
        countDownLbl!.tintColor = .white
//        countDownLbl!.titleLabel?.font = UIFont.init(name: "AvenirNextLTPro-Bold", size: 12 * heightPercent)
        if self.boldPath != nil {
            countDownLbl!.titleLabel?.font = UIFont.init(name: "AvenirNextLTPro-Bold", size: 12 * heightPercent)
        }
        
        countDownLbl!.setTitle(self.countDownSec >= 0 ? String(self.countDownSec)+"s" : LangConfig.lang[lang]!["get"], for: .normal)
//        countDownLbl!.backgroundColor = taskInfo.canExcute ? taskBtn_normal_color : taskBtn_finish_color
        if self.taskPageViewData!.targetValue <= 0 {
            countDownLbl!.addTarget(self, action: #selector(doGetGift), for:.touchUpInside)
        }
     
        
        self.addSubview(countDownLbl!)
        

        var frame:CGRect = self.frame
        frame.size.width = 46 * widthPercent
        frame.size.height = 55 * heightPercent
        frame.origin.x = screenWidth - 46 * widthPercent - 15 * widthPercent
        frame.origin.y = 200
//        alertController.view.frame = frame
        self.frame = frame
//        print(self.frame.size.height)
        
        progressView!.setProgress(0.0, animated: true)
        uiViewController.view.addSubview(self)
        
        initTimer()
        timer!.activate()
//        //启动定时器
//        if timer != nil {
//            timer?.cancel()
//            timer = nil
//        }
        
    }
    
    private func initTimer(){
//        let vm = self
        
//        timer = DispatchSource.makeTimerSource(queue: vm.dataQueue)
        timer = DispatchSource.makeTimerSource(queue: DispatchQueue.main)
        timer!.schedule(deadline: .now(),repeating: .milliseconds(1000))
        timer!.setEventHandler(handler: {
            DispatchQueue.main.async {
         
                self.proressPercentVal = Float(self.taskPageViewData!.targetValue - self.countDownSec) / Float(self.taskPageViewData!.targetValue)
          
                self.progressView!.setProgress(self.proressPercentVal, animated: true)
                if  self.countDownSec <= 0 {
                    if self.timer != nil {
                        self.timer!.cancel()
                        self.timer = nil
                    }
          
//                    self.dismissCountdownView()
//                    self.progressView!.setProgress(1.0, animated: true)
                    var getStr = ""
                    if LangConfig.lang[self.lang] != nil {
                        getStr = LangConfig.lang[self.lang]!["get"]!
                    }
                    self.countDownLbl!.setTitle( getStr, for: .normal)
                    
//                    //设置结束图
//                    if self.browseIcon != nil && self.taskPageViewData != nil {
//                        
//                        if self.taskPageViewData!.endImageUrlApp.isEmpty {
//                            self.browseIcon!.setBackgroundImage(self.sdkManager.sdk_img(named: "gift"), for: .normal)
//                        } else {
//                            self.globalVm.fetchRemoteImage(self.taskPageViewData!.endImageUrlApp) { imgData in
//                                if imgData != nil {
//                                    if UIImage(data: imgData!) != nil {
//                                        self.browseIcon!.setBackgroundImage(UIImage(data: imgData!)!, for: .normal)
//                                    }
//                                }
//                            }
//                        }
//                    }
//                    
//                    //显示tips
//                    if self.countDownTipsView != nil && self.tipsTriangle != nil {
//                        self.countDownTipsView!.alpha = 1
//                        self.tipsTriangle!.alpha = 1
//                        
//                        UIView.animate(withDuration: 5, animations: {
//                            self.countDownTipsView!.alpha = 0
//                            self.tipsTriangle!.alpha = 0
//                            
//                        })
//                    }
                    
                    
                    let query: TaskPageViewParam = TaskPageViewParam()
                    if !self.brand.isEmpty {
                        query.brandId = self.brand
                    }
                    if !self.channel.isEmpty {
                        query.channelId = self.channel
                    }
                    if !self.site.isEmpty{
                        query.siteId = self.site
                    }
                    if !self.terminal.isEmpty{
                        query.terminalId = self.terminal
                    }
                    if !self.lang.isEmpty {
                        query.appLangCode = self.lang
                    }
                    if self.taskPageViewData != nil && self.taskPageViewData!.userTaskId > 0 {
                        query.userTaskId  = self.taskPageViewData!.userTaskId
                    }
                    
                    self.taskVm.stopPageViewTask(env:self.env!,token: self.token, params: query) { userTaskProgressId in
                        if userTaskProgressId != nil {
                            //完成任务
                        }
                    }
                    
                    
                    if self.countDownLbl != nil {
                        self.countDownLbl!.addTarget(self, action: #selector(self.doGetGift), for:.touchUpInside)
                    }
                   
                }else{
                    
    //                self.proressPercentVal = Float(self.taskPageViewData!.targetValue - self.countDownSec) * self.baseProgressVal / Float(self.taskPageViewData!.targetValue)
                    
                    
//                    var getStr = ""
//                    if LangConfig.lang[self.lang] != nil {
//                        getStr = LangConfig.lang[self.lang]!["get"]!
//                    }
    //                self.countDownLbl!.setTitle( self.countDownSec > 0 ? String(self.countDownSec) : getStr, for: .normal)
                    self.countDownLbl!.setTitle(  String(self.countDownSec) , for: .normal)
                    
                    self.countDownSec -= 1
                }
                
               
            }
        })
    }
    
    
    @objc func doGetGift(sender:SubclassedUIButton){
        print("doGetGift")
        
        if self.env != nil {
            var taskPageViewParam: [AnyHashable : Any] = ["taskId" : 0, "type": TaskType.PAGE_VIEW, "jumpPageUrl" : ApiConfig.getRedirectUrl(env: self.env!), "activityId": self.activityId]
            //发送通知
            NotificationCenter.default.post(name: NSNotification.Name(rawValue: "notify_taskPageView"), object: nil, userInfo:taskPageViewParam )
        }
        
//        self.dismissCountdownView()
     
    }
    
    
    public func dismissCountdownView(){
        if timer != nil {
            timer?.cancel()
            timer = nil
        }
        self.removeFromSuperview()
    }
    
    

//    public func showTaskList(){
//
//        UIView.animate(withDuration: 0.1, animations: {
//            self.alpha = 1
//
//            self.popContentView.frame.origin.y = self.screenHeight * 0.5
//        })
//
////        self.present(self.alertController, animated: true, completion: nil)
//    }
//
    
//
//
//    func taskOp(sender:SubclassedUIButton) {
//        print(sender.taskId!)
////        var id = sender.taskId! + 2
//    }

}
