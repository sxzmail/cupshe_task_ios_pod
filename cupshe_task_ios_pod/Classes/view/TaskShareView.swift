//
//  TaskShareView.swift
//  OcSwiftUIDemo
//
//  Created by gbl on 2023/10/16.
//

import Foundation
import UIKit

//@objcMembers
class TaskShareView : UIView ,UIScrollViewDelegate{
//    private var btn:SubclassedUIButton = SubclassedUIButton()
//    private var taskIcon:SubclassedUIButton = SubclassedUIButton()
    
   
    private var taskId: Int = 0
    
    private var listData:[TaskInfo]?

    private var popContentView:UIView = UIView()

    
    private var screenWidth:CGFloat = UIScreen.main.bounds.width
    private var screenHeight:CGFloat = UIScreen.main.bounds.height

    private var widthPercent:CGFloat = 0.0
    private var heightPercent:CGFloat = 0.0
    
    private var popTitleWidth:CGFloat = UIScreen.main.bounds.width
    private var popTitleHeight:CGFloat = 52
    
    private var popTitleTxtFontSize:CGFloat = 16
    
    private var line_color:CGColor = UIColor(red: CGFloat(236/255.0), green: CGFloat(236/255.0), blue: CGFloat(236/255.0), alpha: 1).cgColor
    
    private var taskBtn_normal_color:UIColor = UIColor(red: CGFloat(255/255.0), green: CGFloat(168/255.0), blue: 0, alpha: 1)
    
    private var taskBtn_finish_color:UIColor = UIColor(red: CGFloat(216/255.0), green: CGFloat(216/255.0), blue: CGFloat(216/255.0), alpha: 1)
    
    private var task_desc_txt_color:UIColor = UIColor(red: CGFloat(102/255.0), green: CGFloat(102/255.0), blue: CGFloat(102/255.0), alpha: 1)
    
    private var boldPath:String?
//    private var demiPath:String?
    private var mediumPath:String?
//    private var regularPath:String?
    
    private var clickFlag: Bool = false

    required public init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    override init(frame: CGRect){
        super.init(frame: frame)
//        fontManager.regCustomFont(for: TaskShareView.self)
        self.boldPath = FontManager().getBoldFontPath(for: TaskShareView.self)
//        self.demiPath = fontManager.getDemiFontPath(for: TaskShareView.self)
        self.mediumPath =  FontManager().getMediumFontPath(for: TaskShareView.self)
//        self.regularPath = fontManager.getrRegularFontPath(for: TaskShareView.self)
    }
    public func initView(taskId: Int){
        if TaskSDK.getUiContextFunc() != nil {
            self.taskId = taskId
            
            
            widthPercent = screenWidth / ScreenConfig.baseWidth
            heightPercent = screenHeight / ScreenConfig.baseHeight
            
            
            self.alpha = 0
            
            var taskMaskView:UIView =  UIView(frame: CGRect(x: 0, y: 0, width: screenWidth, height: screenHeight))
            taskMaskView.backgroundColor = .black
            taskMaskView.alpha = 0.5
            //        self.taskMaskView.addGestureRecognizer(UIGestureRecognizer.init(target: self, action: #selector(dismissTaskList)))
            self.addSubview(taskMaskView)
            
            self.popContentView = UIView(frame: CGRect(x: 0, y: screenHeight, width: screenWidth, height: (151 + 52) * heightPercent))
            popContentView.backgroundColor = .white
            
            
            var popTitleView:UIView = UIView(frame: CGRect(x: 0, y: 0, width: popTitleWidth, height: popTitleHeight * heightPercent))
            popTitleView.backgroundColor = .white
            //        popTitleView.layer.cornerRadius = 3
            popTitleView.layer.borderColor = line_color
            popTitleView.layer.borderWidth = 1
            
            var popTitleTxt:UILabel = UILabel(frame: CGRect(x: 0, y: 0, width: popTitleWidth, height: popTitleHeight * heightPercent ))
            popTitleTxt.text = LangConfig.lang[TaskENV.lang]!["taskSharePopTitle"]
            popTitleTxt.textAlignment = .center
            if self.boldPath != nil {
                popTitleTxt.font = UIFont.init(name:"AvenirNextLTPro-Bold", size: 16 * heightPercent)
            }
            //        popTitleTxt.font = UIFont.init(name: "AvenirNextLTPro-Bold", size: 16 * heightPercent)
            //        popTitleTxt.font = UIFont.systemFont(ofSize: 16 * heightPercent,weight: .bold)//UIFont(name:, size: 16 * heightPercent)
            
            
            var closeBtn = SubclassedUIButton(frame: CGRect(x: 339 * widthPercent, y: 16 * heightPercent, width: 20 * heightPercent, height: 20 * heightPercent))
            closeBtn.setBackgroundImage(SdkManager().sdk_img(named: "close"), for: .normal)
            closeBtn.addTarget(self, action: #selector(dismissTaskShare), for:.touchUpInside)
            
            popTitleView.addSubview(popTitleTxt)
            popTitleView.addSubview(closeBtn)
            
            
            var row =  UIView(frame: CGRect(x: (screenWidth * 0.05), y:  52 * heightPercent, width: (screenWidth * 0.9), height: 99 * heightPercent))
            
            
            var colView_facebook = UIView(frame: CGRect(x: 0, y:  21 * heightPercent, width: (screenWidth * 0.3), height: 51 * heightPercent))
            
            var facebookBtn = SubclassedUIButton(frame: CGRect(x: ((screenWidth * 0.3) - CGFloat(32 * widthPercent)) * 0.5, y: 0, width: 32 * heightPercent, height: 32 * heightPercent))
            facebookBtn.shareType = "facebook"
            facebookBtn.setBackgroundImage(SdkManager().sdk_img(named: "facebook"), for: .normal)
            facebookBtn.addTarget(self, action: #selector(shareOp), for:.touchUpInside)
            
            var facebookLbl:UILabel = UILabel(frame: CGRect(x: 0, y: CGFloat(35 * widthPercent), width: (screenWidth * 0.3), height: 15 * heightPercent ))
            facebookLbl.text = "Facebook"
            facebookLbl.textAlignment = .center
            
            //        facebookLbl.font = UIFont.init(name: "AvenirNextLTPro-Medium", size: 12 * heightPercent)
            if self.mediumPath != nil {
                facebookLbl.font = UIFont.init(name: "AvenirNextLTPro-Medium", size: 12 * heightPercent)
            }
            
            colView_facebook.addSubview(facebookBtn)
            colView_facebook.addSubview(facebookLbl)
            
            
            var colView_messenger = UIView(frame: CGRect(x: (screenWidth * 0.3), y:  21 * heightPercent, width: (screenWidth * 0.3), height: 51 * heightPercent))
            
            var messengerBtn = SubclassedUIButton(frame: CGRect(x: ((screenWidth * 0.3) - CGFloat(32 * widthPercent)) * 0.5, y: 0, width: 32 * heightPercent, height: 32 * heightPercent))
            messengerBtn.setBackgroundImage(SdkManager().sdk_img(named: "messenger"), for: .normal)
            messengerBtn.shareType = "messenger"
            messengerBtn.addTarget(self, action: #selector(shareOp), for:.touchUpInside)
            
            var messengerLbl:UILabel = UILabel(frame: CGRect(x: 0, y: CGFloat(35 * widthPercent), width: (screenWidth * 0.3), height: 15 * heightPercent ))
            messengerLbl.text = "Messenger"
            messengerLbl.textAlignment = .center
            //        messengerLbl.font = UIFont.init(name: "AvenirNextLTPro-Medium", size: 12 * heightPercent)
            if self.mediumPath != nil {
                messengerLbl.font = UIFont.init(name: "AvenirNextLTPro-Medium", size: 12 * heightPercent)
            }
            
            colView_messenger.addSubview(messengerBtn)
            colView_messenger.addSubview(messengerLbl)
            
            var colView_ins = UIView(frame: CGRect(x: (screenWidth * 0.6), y:  21 * heightPercent, width: (screenWidth * 0.3), height: 51 * heightPercent))
            
            var insBtn = SubclassedUIButton(frame: CGRect(x: ((screenWidth * 0.3) - CGFloat(32 * widthPercent)) * 0.5, y: 0, width: 32 * heightPercent, height: 32 * heightPercent))
            insBtn.setBackgroundImage(SdkManager().sdk_img(named: "instagram"), for: .normal)
            insBtn.shareType = "Instagram"
            insBtn.addTarget(self, action: #selector(shareOp), for:.touchUpInside)
            
            var insLbl:UILabel = UILabel(frame: CGRect(x: 0, y: CGFloat(35 * widthPercent), width: (screenWidth * 0.3), height: 15 * heightPercent ))
            insLbl.text = "Ins"
            insLbl.textAlignment = .center
            
            //        insLbl.font = UIFont.init(name: "AvenirNextLTPro-Medium", size: 12 * heightPercent)
            if self.mediumPath != nil {
                insLbl.font = UIFont.init(name: "AvenirNextLTPro-Medium", size: 12 * heightPercent)
            }
            colView_ins.addSubview(insBtn)
            colView_ins.addSubview(insLbl)
            
            
            row.addSubview(colView_facebook)
            row.addSubview(colView_messenger)
            row.addSubview(colView_ins)
            
            //        var bottomSpace =  UIView(frame: CGRect(x: 0, y:  CGFloat(151 + 52) * heightPercent, width: (screenWidth), height: 20 * heightPercent))
            
            self.popContentView.addSubview(popTitleView)
            self.popContentView.addSubview(row)
            //        self.popContentView.addSubview(bottomSpace)
            
            self.addSubview(popContentView)
            
            
            var frame:CGRect = self.frame
            frame.size.width = UIScreen.main.bounds.width
            frame.size.height = UIScreen.main.bounds.height
            frame.origin.x = 0
            frame.origin.y = 0//UIScreen.main.bounds.height
            //        alertController.view.frame = frame
            self.frame = frame
            TaskSDK.getUiContextFunc()!.addSubview(self)
        }
    }


    public func showView(){
       
            
            
        UIView.animate(withDuration: 0.1, animations: {
            self.alpha = 1
            
            self.popContentView.frame.origin.y = self.screenHeight - 151 //- 52 - 40
        })
        
        
//        self.present(self.alertController, animated: true, completion: nil)
    }
    
    
    
    @objc func dismissTaskShare(){
        UIView.animate(withDuration: 0.1, animations: {
            self.alpha = 0
//            print(self.frame.size.height)
            self.popContentView.frame.origin.y = self.screenHeight
            
        }) { flag in
            if flag {
                var chilrenviews = self.subviews
                for chilren in chilrenviews {
                      chilren.removeFromSuperview()
                }
                self.removeFromSuperview()
                TaskSDK.taskShareView = nil
            }
            
        }
    }
    
    
    @objc func shareOp(sender:SubclassedUIButton) {
        if self.clickFlag {
            print("share no")
            return
        }
        print("share yes")
        self.clickFlag = true
        
        let shareType:String = sender.shareType!
        print(taskId)
        print("taskId")
                
        let shareQuery: UserShareParam = UserShareParam()
        
        shareQuery.token = TaskENV.token
        if !TaskENV.brand.isEmpty {
            shareQuery.brandId = TaskENV.brand
        }
        if !TaskENV.channel.isEmpty {
            shareQuery.channelId = TaskENV.channel
        }
        if !TaskENV.site.isEmpty {
            shareQuery.siteId = TaskENV.site
        }
        if !TaskENV.terminal.isEmpty {
            shareQuery.terminalId = TaskENV.terminal
        }
        if !TaskENV.lang.isEmpty {
            shareQuery.appLangCode = TaskENV.lang
        }
        
        if self.taskId > 0 {
            shareQuery.taskId = self.taskId
        }
        
        TaskVM().getShareUrl(env:TaskENV.env,token: TaskENV.token, params: shareQuery) { shareUrl in
            print("shareUrl1")
          
            if shareUrl != nil && !shareUrl!.isEmpty {
                
                var taskNotice: [AnyHashable : Any] = ["shareUrl" : shareUrl, "type": shareType]
                //发送通知
                NotificationCenter.default.post(name: NSNotification.Name(rawValue: "notify_userShare"), object: nil, userInfo:taskNotice )
            
            }
            
            self.clickFlag = false
        }
                
            
        self.dismissTaskShare()
        
    }


}
