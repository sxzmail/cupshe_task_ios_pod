//
//  TaskList.swift
//  OcSwiftUIDemo
//
//  Created by gbl on 2023/10/11.
//

import Foundation
import UIKit

//@objcMembers
class TaskListView : UIView ,UIScrollViewDelegate{
//    private var btn:SubclassedUIButton = SubclassedUIButton()
//    private var taskIcon:SubclassedUIButton = SubclassedUIButton()
    private var uiViewController:UIViewController?
    private var taskShareView:TaskShareView?
    private var brand:String = ""
    private var channel:String = ""
    private var site:String = ""
    private var terminal:String = ""
    private var token:String = ""
    private var lang:String = ""
    private var activityId: String = ""
    private var env:TaskEnvironment?
    private var listData:[TaskInfoVO]?
    

    private var taskMaskView:UIView = UIView()
    private var popContentView:UIView = UIView()
    private var listScrollView:UIScrollView = UIScrollView()
    private var empContent:UIView = UIView()
    
    private var taskVm:TaskVM = TaskVM()
    private var sdkManager:SdkManager = SdkManager()
    private var fontManager:FontManager = FontManager()
    
    private var screenWidth:CGFloat = UIScreen.main.bounds.width
    private var screenHeight:CGFloat = UIScreen.main.bounds.height

    private var widthPercent:CGFloat = 0.0
    private var heightPercent:CGFloat = 0.0
    
    private var popTitleWidth:CGFloat = UIScreen.main.bounds.width
    private var popTitleHeight:CGFloat = 52
    
    private var popTitleTxtFontSize:CGFloat = 16
    
    private var line_color:CGColor = UIColor(red: CGFloat(236/255.0), green: CGFloat(236/255.0), blue: CGFloat(236/255.0), alpha: 1).cgColor
    
    private var line_color2:CGColor = UIColor(red: CGFloat(0/255.0), green: CGFloat(0/255.0), blue: CGFloat(0/255.0), alpha: 1).cgColor
    
    private var taskBtn_normal_color:UIColor = UIColor(red: CGFloat(255/255.0), green: CGFloat(168/255.0), blue: 0, alpha: 1)
    
    private var taskBtn_finish_color:UIColor = UIColor(red: CGFloat(216/255.0), green: CGFloat(216/255.0), blue: CGFloat(216/255.0), alpha: 1)
    
    private var task_desc_txt_color:UIColor = UIColor(red: CGFloat(102/255.0), green: CGFloat(102/255.0), blue: CGFloat(102/255.0), alpha: 1)
    
    private var tips_color:UIColor = UIColor(red: CGFloat(244/255.0), green: CGFloat(116/255.0), blue: CGFloat(18/255.0), alpha: 1)

    private var boldPath:String?
    private var demiPath:String?
    private var mediumPath:String?
    private var regularPath:String?
    
    required public init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    override init(frame: CGRect){
        super.init(frame: frame)
//        fontManager.regCustomFont(for: TaskListView.self)
        self.boldPath = fontManager.getBoldFontPath(for: TaskListView.self)
        self.demiPath = fontManager.getDemiFontPath(for: TaskListView.self)
        self.mediumPath = fontManager.getMediumFontPath(for: TaskListView.self)
        self.regularPath = fontManager.getrRegularFontPath(for: TaskListView.self)
    }
    public func initView(uiViewController: UIViewController,brand:String,channel:String,site:String,terminal:String,token:String,lang: String,activityId:String,env:TaskEnvironment){
        self.brand = brand
        self.channel = channel
        self.site = site
        self.terminal = terminal
        self.token = token
        self.lang = lang
        self.activityId = activityId
        self.uiViewController = uiViewController
        self.env = env

        
        widthPercent = 1.0 //screenWidth / ScreenConfig.baseWidth
        heightPercent = 1.0 //screenHeight / ScreenConfig.baseHeight
        
        
        self.alpha = 0
        
        self.taskMaskView = UIView(frame: CGRect(x: 0, y: 0, width: screenWidth, height: screenHeight))
        self.taskMaskView.backgroundColor = .black
        self.taskMaskView.alpha = 0.5
//        self.taskMaskView.addGestureRecognizer(UIGestureRecognizer.init(target: self, action: #selector(dismissTaskList)))
        self.addSubview(self.taskMaskView)
        
        self.popContentView = UIView(frame: CGRect(x: 0, y: screenHeight, width: screenWidth, height: screenHeight * 0.5))
        popContentView.backgroundColor = .white
        
    
        
        var popTitleView:UIView = UIView(frame: CGRect(x: 0, y: 0, width: popTitleWidth, height: popTitleHeight * heightPercent))
        popTitleView.backgroundColor = .white
//        popTitleView.layer.cornerRadius = 3
        popTitleView.layer.borderColor = line_color
        popTitleView.layer.borderWidth = 1

        var popTitleTxt:UILabel = UILabel(frame: CGRect(x: 0, y: 0, width: popTitleWidth, height: popTitleHeight * heightPercent ))
        popTitleTxt.text = LangConfig.lang[lang]!["taskPopTitle"]
        popTitleTxt.textAlignment = .center
        popTitleTxt.font = UIFont.init(name: self.boldPath!, size: 16 * heightPercent)
       

        var closeBtn = SubclassedUIButton(frame: CGRect(x: screenWidth - 16 - 20 , y: 16 * heightPercent, width: 20 * heightPercent, height: 20 * heightPercent))
        closeBtn.setBackgroundImage(sdkManager.sdk_img(named: "close"), for: .normal)
        closeBtn.addTarget(self, action: #selector(dismissTaskList), for:.touchUpInside)
        
        popTitleView.addSubview(popTitleTxt)
        popTitleView.addSubview(closeBtn)
        
        
        self.empContent = UIView(frame: CGRect(x: 0, y: popTitleHeight * heightPercent, width: screenWidth, height: screenHeight * 0.5 - popTitleHeight * heightPercent))
        var empImg:UIImageView = UIImageView(frame: CGRect(x: CGFloat(screenWidth - 160 * widthPercent) * 0.5, y: CGFloat(screenHeight * 0.5 - popTitleHeight * heightPercent - 160) * 0.5, width: CGFloat(160 * widthPercent), height: CGFloat(160 * widthPercent)))
        empImg.image = sdkManager.sdk_img(named: "emptyimg")
        self.empContent.addSubview(empImg)
        self.empContent.alpha = 0
        
        
        self.listScrollView = UIScrollView(frame: CGRect(x: 0, y: popTitleHeight * heightPercent, width: screenWidth, height: screenHeight * 0.5 - popTitleHeight * heightPercent))
//        listScrollView.backgroundColor = .blue
        self.listScrollView.isScrollEnabled = true
        self.listScrollView.delegate = self
        self.listScrollView.alpha = 0
        
        self.popContentView.addSubview(popTitleView)
        self.popContentView.addSubview(self.empContent)
        self.popContentView.addSubview(listScrollView)
       
    
        self.addSubview(popContentView)


        var frame:CGRect = self.frame
        frame.size.width = UIScreen.main.bounds.width
        frame.size.height = UIScreen.main.bounds.height
        frame.origin.x = 0
        frame.origin.y = 0//UIScreen.main.bounds.height
//        alertController.view.frame = frame
        self.frame = frame
        uiViewController.view.addSubview(self)
       
    }

    public func setListData(taskList:[TaskInfoVO]){
        self.listData = taskList
    }

    public func showView(){
        if self.listData != nil {
            self.empContent.removeFromSuperview()
            let countNum = self.listData!.count
//            let countNum = 10
            for var i in 0..<countNum {
                let taskInfo :TaskInfoVO = self.listData![i] as TaskInfoVO
                
                let border = CALayer()
                var row:UIView = UIView(frame: CGRect(x: 16, y: CGFloat( i * 62) * heightPercent, width: (screenWidth - 32 ), height: 60 * heightPercent))
//                row.backgroundColor = .blue
                border.frame = CGRect(x: 0, y: 62 * heightPercent, width: (screenWidth - 32), height: 1);
                border.backgroundColor = line_color
                //            row!.backgroundColor = .gray
                row.layer.addSublayer(border)
                
                
                var col_icon:UIImageView = UIImageView(frame: CGRect(x: 0, y: CGFloat(14 * heightPercent), width: CGFloat(32 * widthPercent), height: CGFloat(32 * heightPercent)))
                col_icon.image = sdkManager.sdk_img(named: "progress")

                var col_title:UILabel = UILabel(frame: CGRect(x: CGFloat(40 * widthPercent), y: CGFloat(5 * heightPercent), width: (screenWidth - 32 ) - CGFloat(40 * widthPercent) - CGFloat(80 * widthPercent), height: 24 * heightPercent ))
                if taskInfo.finishCountLimit > 1 {
                    col_title.text = taskInfo.taskName + "(" + String(format:"%d",taskInfo.finishedCount) + "/" + String(format:"%d",taskInfo.finishCountLimit) + ")"
                }else{
                    col_title.text = taskInfo.taskName
                }
                col_title.textAlignment = .left
                col_title.textColor = .black
                col_title.font = UIFont.init(name: self.demiPath!, size: 14 * heightPercent)



                var polygonUIView:TipsUIView = TipsUIView(frame: CGRect(x: screenWidth * 0.34 , y: CGFloat(5 * heightPercent), width: 6.06 * widthPercent, height: 19 * heightPercent))
                polygonUIView.backgroundColor = .white
                if taskInfo.targetType == TaskType.CHECK_IN {
                    polygonUIView.code = "UIView_taskId_" + String(taskInfo.taskId)
                }

                polygonUIView.alpha = 0

                var polygon_img:UIImageView = UIImageView(frame: CGRect(x: 0, y: (19 - 4.25) * heightPercent * 0.5, width: CGFloat(6.06 * widthPercent), height: CGFloat(4.25 * widthPercent)))
                polygon_img.image = sdkManager.sdk_img(named: "polygon")

                polygonUIView.addSubview(polygon_img)

                var tipsUIView:TipsUIView = TipsUIView(frame: CGRect(x: screenWidth * 0.34 + CGFloat(6.06 * widthPercent), y: CGFloat(5 * heightPercent), width: 74 * widthPercent, height: 19 * heightPercent))
                tipsUIView.backgroundColor = tips_color
                tipsUIView.layer.cornerRadius = 2
                tipsUIView.layer.shadowRadius = 2
                if taskInfo.targetType == TaskType.CHECK_IN {
                    tipsUIView.code = "UIView_taskId_" + String(taskInfo.taskId)
                }
                tipsUIView.alpha = 0

                var tipsLbl:TipsUILabel = TipsUILabel(frame: CGRect(x: 0,y: 0, width: 74 * heightPercent, height: 19 * heightPercent))
                tipsLbl.text = "Chances +1"
                tipsLbl.textAlignment = .center
                tipsLbl.textColor = .white
                tipsLbl.code = "lbl_taskId_" + String(taskInfo.taskId)
                tipsLbl.font = UIFont.init(name: self.demiPath!, size: 12 * heightPercent)

                tipsUIView.addSubview(tipsLbl)

                var oprateBtn = SubclassedUIButton(frame: CGRect(x: (screenWidth - 32) - CGFloat(80 * widthPercent), y: CGFloat(5 * heightPercent), width: 80 * widthPercent, height: 24 * heightPercent))
                oprateBtn.tintColor = .white
                oprateBtn.titleLabel?.font = UIFont.systemFont(ofSize: 12 * heightPercent,weight: .bold)
                oprateBtn.taskId = taskInfo.taskId
                oprateBtn.taskType = taskInfo.targetType
                oprateBtn.backgroundColor = taskInfo.canExcute ? taskBtn_normal_color : taskBtn_finish_color
                if taskInfo.canExcute {
                    oprateBtn.addTarget(self, action: #selector(taskOp), for:.touchUpInside)
                }


                if taskInfo.targetType == TaskType.CHECK_IN {

                    oprateBtn.setTitle(LangConfig.lang[lang]!["checkIn"], for: .normal)
                }else if taskInfo.targetType == TaskType.PAGE_VIEW {
                    oprateBtn.activityId = taskInfo.taskActivityId
                    oprateBtn.setTitle(LangConfig.lang[lang]!["go"], for: .normal)
                    oprateBtn.jumpPageUrl = taskInfo.targetAppUrl

                }else if taskInfo.targetType == TaskType.SHARE {

                    oprateBtn.setTitle(LangConfig.lang[lang]!["share"], for: .normal)
                }


                var descLbl:UILabel = UILabel(frame: CGRect(x: CGFloat(40 * widthPercent), y: 33 * heightPercent, width: screenWidth - CGFloat(40 * widthPercent) - CGFloat(32 * widthPercent), height: 15 * heightPercent ))

                descLbl.text = taskInfo.taskDesc//"Log in daily to obtain a lottery opportunity" //
                descLbl.textColor = task_desc_txt_color
                descLbl.textAlignment = .left
                descLbl.font = UIFont.init(name: self.regularPath!, size: 12 * heightPercent)
//
//
                row.addSubview(col_icon)
                row.addSubview(col_title)
                row.addSubview(oprateBtn)
                row.addSubview(descLbl)

                row.addSubview(polygonUIView)
                row.addSubview(tipsUIView)
                
                self.listScrollView.addSubview(row)
            }
            self.listScrollView.contentSize = CGSizeMake(UIScreen.main.bounds.width, CGFloat(CGFloat(countNum * 64) * heightPercent))
            self.listScrollView.alpha = 1
            
        }else{
            self.listScrollView.removeFromSuperview()
            self.empContent.alpha = 1
        }
        
        UIView.animate(withDuration: 0.1, animations: {
            self.alpha = 1
            
            self.popContentView.frame.origin.y = self.screenHeight * 0.5
        })
        
//        self.present(self.alertController, animated: true, completion: nil)
    }
    
    
    @objc func dismissTaskList(){
        UIView.animate(withDuration: 0.1, animations: {
            self.alpha = 0
            print(self.frame.size.height)
            self.popContentView.frame.origin.y = self.screenHeight
            self.removeFromSuperview()
            
        })
    }
    
    
    @objc func taskOp(sender:SubclassedUIButton) {
        
        let type: String = sender.taskType!
        let taskId: Int = sender.taskId!
        if type == TaskType.CHECK_IN {
            //签到

            let query: TaskCheckInParam = TaskCheckInParam()
            query.actionId = TaskType.CHECK_IN
            query.token = self.token
            if !self.brand.isEmpty {
                query.brandId = brand
            }
            if !self.channel.isEmpty {
                query.channelId = channel
            }
            if !self.site.isEmpty {
                query.siteId = site
            }
            if !self.terminal.isEmpty {
                query.terminalId = terminal
            }
            if !self.lang.isEmpty {
                query.appLangCode = self.lang
            }
            if taskId != nil && taskId > 0 {
                query.taskId  = taskId
            }

//        brand: self.brand, channel: self.channel, site: self.site, terminal: self.terminal, lang: self.lang
            self.taskVm.taskCheckIn(env:self.env!,token: self.token, params: query) { lst in


                if lst != nil && lst!.count > 0 {
                    //签到成功
                    let userTaskProgressInfo:UserTaskProgress = lst![0] as UserTaskProgress
                    self.showToast(taskId: sender.taskId!,tipMsg:LangConfig.lang[self.lang]!["Chances"]! + " +1")
                    if userTaskProgressInfo.status == 2 || userTaskProgressInfo.status == 3 {
                        sender.backgroundColor = self.taskBtn_finish_color
                        sender.removeTarget(self, action: nil, for:.touchUpInside)
                    }
                }

            }
        }else if type == TaskType.PAGE_VIEW {
            //浏览
//            print(sender.taskId!)
//            print(sender.jumpPageUrl!)
//            print(sender.activityId!)
            var taskPageViewParam: [AnyHashable : Any] = ["taskId" : sender.taskId!, "type": TaskType.PAGE_VIEW, "jumpPageUrl" : sender.jumpPageUrl!, "activityId": sender.activityId!]
            //发送通知
            NotificationCenter.default.post(name: NSNotification.Name(rawValue: "notify_taskPageView"), object: nil, userInfo:taskPageViewParam )
            self.dismissTaskList()

        }else if type == TaskType.SHARE {
            //分享
            self.dismissTaskList()
            self.showShareView(taskId: taskId)

        }
    
    }
    
   

    
    public func showShareView(taskId:Int){
        if self.uiViewController != nil {
        
            if self.taskShareView == nil {
                self.taskShareView = TaskShareView(frame: CGRect(x: 0, y: 0, width: 0, height: 0))

                self.taskShareView!.initView(uiViewController: self.uiViewController!, brand: self.brand, channel: self.channel, site: self.site, terminal: self.terminal, token: self.token,lang: self.lang,activityId: self.activityId,taskId: taskId,env: self.env!)
            }


            self.taskShareView!.showView()
        }

    }
    
    
    public func closeShareView(){
        
//        closeCountdownView();
        if self.taskShareView != nil {
            self.taskShareView!.dismissTaskShare()
            
        }
    }
    
    public func showToast(taskId:Int,tipMsg:String){
        print(self.subviews.count)
        
        self.listScrollView.subviews.map { row in
            row.subviews.map { ui in
               
                if ui is TipsUIView {
                    let uiObj = ui as! TipsUIView
                    if uiObj.code == "UIView_taskId_" + String(taskId) {
                        
                        ui.subviews.map { lbl in
                            if lbl is TipsUILabel {
                                let lblObj = lbl as! TipsUILabel
                                if lblObj.code == "lbl_taskId_" + String(taskId) {
                                    lblObj.text = tipMsg
                                }
                            }
                            
                        }
                        
                        
                        ui.alpha = 1
                        UIView.animate(withDuration: 3, animations: {
                          
                            ui.alpha = 0
                            
                        })
                    }
                   
                }
            }
            
        }
    }
 
}

