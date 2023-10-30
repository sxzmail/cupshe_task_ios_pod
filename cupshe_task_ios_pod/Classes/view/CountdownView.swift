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
    
    private var screenWidth:CGFloat = UIScreen.main.bounds.width
    private var screenHeight:CGFloat = UIScreen.main.bounds.height

    private var widthPercent:CGFloat = 0.0
    private var heightPercent:CGFloat = 0.0
    
    private var baseProgressVal: Float = 10.0
    
    private var tipsBgColor:UIColor = UIColor(red: CGFloat(0/255.0), green: CGFloat(0/255.0), blue: CGFloat(0/255.0), alpha: 0.3)
    
    private var progressBarStartColor:UIColor = UIColor(red: CGFloat(255/255.0), green: CGFloat(138/255.0), blue: 0, alpha: 1)
    
    private var progressBarEndColor:UIColor = UIColor(red: CGFloat(251/255.0), green: CGFloat(8/255.0), blue: 0, alpha: 1)
    
    private var progressBarBgColor:UIColor = UIColor(red: CGFloat(194/255.0), green: CGFloat(194/255.0), blue: CGFloat(194/255.0), alpha: 1)

    private var countDownSec: Int = 0
    private var proressPercentVal:Float = 0.0
    private var taskPageViewData:TaskPageViewVO?
    
    private var progressView: GradientProgressView?
    private var countDownLbl:SubclassedUIButton?
    private var browseIcon:SubclassedUIButton?
    private var countDownTipsView: UIView?
    private var tipsTriangle:UIImageView?
    
    private var startImg:UIImage?
    private var endImg:UIImage?
    
    private var boldPath:String?
    private var demiPath:String?

    private var clickFlag: Bool = false
    
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
        self.boldPath = FontManager().getBoldFontPath(for: CountdownView.self)
        self.demiPath =  FontManager().getDemiFontPath(for: TaskListView.self)
//        self.mediumPath = fontManager.getMediumFontPath(for: TaskListView.self)
//        self.regularPath = fontManager.getrRegularFontPath(for: TaskListView.self)
    }

    public func showView(data:TaskPageViewVO){
        if TaskSDK.getUiContextFunc() != nil {
           
            self.taskPageViewData = data
           
            self.countDownSec = self.taskPageViewData!.targetValue
      
            widthPercent = 1.0 //screenWidth / ScreenConfig.baseWidth
            heightPercent = 1.0 // screenHeight / ScreenConfig.baseHeight
            
            self.browseIcon = SubclassedUIButton(frame: CGRect(x: 0, y: 0, width: 46 * widthPercent, height: 46 * widthPercent))
            if data.startImageUrlApp.isEmpty {
                self.browseIcon!.setBackgroundImage(SdkManager().sdk_img(named: "gift"), for: .normal)
            } else {
                GlobalVM().fetchRemoteImage(data.startImageUrlApp) { imgData in
                    if imgData != nil {
                        if UIImage(data: imgData!) != nil {
                            DispatchQueue.main.async {
                                self.browseIcon!.setBackgroundImage(UIImage(data: imgData!)!, for: .normal)
                            }
                        }
                    }
                }
                
            }
            
            if data.endImageUrlApp.isEmpty {
                self.endImg = SdkManager().sdk_img(named: "gift")
            }else{
                GlobalVM().fetchRemoteImage(self.taskPageViewData!.endImageUrlApp) { imgData in
                    if imgData != nil {
                        if UIImage(data: imgData!) != nil {
                            self.endImg = UIImage(data: imgData!)!
                            
                        }
                    }
                }
            }
            self.addSubview(self.browseIcon!)
            //
            //        if self.taskPageViewData!.targetValue <= 0 {
            //            self.browseIcon!.addTarget(self, action: #selector(doGetGift), for:.touchUpInside)
            //        }
            //
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
            
            
            
            self.countDownTipsView!.alpha = 0
            self.countDownTipsView!.addSubview(tipsLbl)
            
            
            
            
            self.tipsTriangle = UIImageView(frame: CGRect(x: -8, y: 19,width: 6.02 , height: 4))
            self.tipsTriangle!.image = SdkManager().sdk_img(named: "Triangle")
            
            self.tipsTriangle!.alpha = 0
            
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
            
            countDownLbl!.setTitle(self.countDownSec >= 0 ? String(self.countDownSec) + "s" : LangConfig.lang[TaskENV.lang]!["get"], for: .normal)
            //        countDownLbl!.backgroundColor = taskInfo.canExcute ? taskBtn_normal_color : taskBtn_finish_color
            //        if self.taskPageViewData!.targetValue <= 0 {
            //            countDownLbl!.addTarget(self, action: #selector(doGetGift), for:.touchUpInside)
            //        }
            
            
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
            TaskSDK.getUiContextFunc()!.addSubview(self)
            
            initTimer()
            timer!.activate()
            //        //启动定时器
            //        if timer != nil {
            //            timer?.cancel()
            //            timer = nil
            //        }
        }
    }
    
    private func initTimer(){

        timer = DispatchSource.makeTimerSource(queue: DispatchQueue.main)
        timer!.schedule(deadline: .now(),repeating: .milliseconds(1000))
        timer!.setEventHandler(handler: {
            DispatchQueue.main.async {
         
                self.proressPercentVal = Float(self.taskPageViewData!.targetValue - self.countDownSec) / Float(self.taskPageViewData!.targetValue)
                if self.progressView != nil {
                    self.progressView!.setProgress(self.proressPercentVal, animated: true)
                }
                if  self.countDownSec <= 0 {
                    if self.timer != nil {
                        self.timer!.cancel()
                        self.timer = nil
                    }
          
//                    self.dismissCountdownView()
//                    self.progressView!.setProgress(1.0, animated: true)
                    var getStr = ""
                    if LangConfig.lang[TaskENV.lang] != nil {
                        getStr = LangConfig.lang[TaskENV.lang]!["get"]!
                    }
                    
                    if self.countDownLbl != nil {
                        self.countDownLbl!.setTitle( getStr, for: .normal)
                    }
                    
                    
                    let query: TaskPageViewParam = TaskPageViewParam()
                    if !TaskENV.brand.isEmpty {
                        query.brandId = TaskENV.brand
                    }
                    if !TaskENV.channel.isEmpty {
                        query.channelId = TaskENV.channel
                    }
                    if !TaskENV.site.isEmpty{
                        query.siteId = TaskENV.site
                    }
                    if !TaskENV.terminal.isEmpty{
                        query.terminalId = TaskENV.terminal
                    }
                    if !TaskENV.lang.isEmpty {
                        query.appLangCode = TaskENV.lang
                    }
                    if self.taskPageViewData != nil && self.taskPageViewData!.userTaskId > 0 {
                        query.userTaskId  = self.taskPageViewData!.userTaskId
                    }
                    
                    TaskVM().stopPageViewTask(env:TaskENV.env,token: TaskENV.token, params: query) { userTaskProgressId in
                        if userTaskProgressId != nil {
                            //完成任务
                            //设置结束图
                            if self.browseIcon != nil && self.taskPageViewData != nil {
                                DispatchQueue.main.async {
                                    self.browseIcon!.setBackgroundImage(self.endImg!, for: .normal)
                                }
                                
                            }
                            
                            //显示tips
                            if self.countDownTipsView != nil && self.tipsTriangle != nil {
                                self.countDownTipsView!.alpha = 1
                                self.tipsTriangle!.alpha = 1
                                
                                UIView.animate(withDuration: 5, animations: {
                                    if self.countDownTipsView != nil && self.tipsTriangle != nil {
                                        DispatchQueue.main.async {
                                            self.countDownTipsView!.alpha = 0
                                            self.tipsTriangle!.alpha = 0
                                        }
                                    }
                                    
                                })
                            }
                            
                            
                            if self.countDownLbl != nil && self.browseIcon != nil {
                                DispatchQueue.main.async {
                                    self.countDownLbl!.userTaskId = userTaskProgressId
                                    self.browseIcon!.userTaskId = userTaskProgressId
                                    self.countDownLbl!.addTarget(self, action: #selector(self.doGetGift), for:.touchUpInside)
                                    self.browseIcon!.addTarget(self, action: #selector(self.doGetGift), for:.touchUpInside)
                                    
                                }
                            }
                            
                        }
                    }
                    
                    
                    
                   
                }else{
       
                    self.countDownLbl!.setTitle(  String(self.countDownSec) + "s" , for: .normal)
                    
                    self.countDownSec -= 1
                }
                
               
            }
        })
    }
    
    
    @objc func doGetGift(sender:SubclassedUIButton){
        print("doGetGift")
        if self.clickFlag {
            print("doGetGift Fal")
            return
        }
        print("doGetGift Ok")
        self.clickFlag = true
        
        if(TaskENV.getRewardCallBack != nil && TaskENV.env != nil){
            var userTaskId = sender.userTaskId! as Int
            //  OC的Block - >Swift的闭包,closure就是Block转化后的闭包
            typealias ClosureType = @convention(block) (String) -> Void
            let blockPtr = UnsafeRawPointer(Unmanaged<AnyObject>.passUnretained(TaskENV.getRewardCallBack  as AnyObject).toOpaque())
            let closure = unsafeBitCast(blockPtr, to: ClosureType.self)
            closure(ApiConfig.getRedirectUrl(env: TaskENV.env) + "&userTaskId=" + String(userTaskId))
        }
        self.clickFlag = false
//        if self.env != nil {
//            var taskPageViewParam: [AnyHashable : Any] = ["taskId" : 0, "type": TaskType.PAGE_VIEW, "jumpPageUrl" : ApiConfig.getRedirectUrl(env: self.env!), "activityId": self.activityId]
//            //发送通知
//            NotificationCenter.default.post(name: NSNotification.Name(rawValue: "notify_taskGetReward"), object: nil, userInfo:taskPageViewParam )
//        }
//        
        self.dismissCountdownView()
     
    }
    
    
    public func dismissCountdownView(){
        if timer != nil {
            timer?.cancel()
            timer = nil
        }
        
        var chilrenviews = self.subviews
        for chilren in chilrenviews {
              chilren.removeFromSuperview()
        }
        self.removeFromSuperview()
        TaskSDK.countDownView = nil
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
