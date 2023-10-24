//
//  TaskView.swift
//  TaskSDK
//
//  Created by gbl on 2023/10/9.
//

import Foundation
import UIKit
import Alamofire

@objcMembers
public class TaskView : UIView {
    private var btn:SubclassedUIButton = SubclassedUIButton()
    private var taskIcon:SubclassedUIButton = SubclassedUIButton()

    override init(frame:CGRect){
        super.init(frame: frame)
  
//        var sdkManager : SdkManager = SdkManager()
        
        self.btn = SubclassedUIButton(frame: CGRect(x: 0, y: 0, width: 100, height: 50))
                btn.urlString = "222"
                btn.backgroundColor = .green
                btn.setTitle("click", for: .normal)
                btn.addTarget(self, action: #selector(self.login), for: .touchUpInside)
        self.addSubview(btn)
        
//        let actionSheet = UIActionSheet()
//        actionSheet.addButton(withTitle: "取消")
//        actionSheet.addButton(withTitle: "ONE")
//        actionSheet.addButton(withTitle: "TWO")
//        actionSheet.cancelButtonIndex = 0
//        actionSheet.delegate = self
//        actionSheet.show(in: self)


        self.taskIcon = SubclassedUIButton(frame: CGRect(x: 210, y: 300, width: 100, height: 50))
//        self.taskIcon.setBackgroundImage(sdkManager.sdk_img(named: "gift"), for: .normal)
//        let globalVm:GlobalVM = GlobalVM()
//        let pUrl = "https://cdn-review.cupshe.com/cmc-admin/2023_05_12/21_03_047/b4c2db4d-773f-477c-8783-499d694e5482/CAA12C3H073AA/1.jpg"
////    https://smartviolin.oss-cn-shanghai.aliyuncs.com/76f91026-32b3-4acc-9bb8-bb5e7e9dbdfc.png
//        globalVm.fetchRemoteImage(pUrl) { imgData in
//            DispatchQueue.main.async {
//                if imgData != nil {
//                    if UIImage(data: imgData!) != nil {
//                        self.taskIcon.setBackgroundImage(UIImage(data: imgData!)!, for: .normal)
//                        //                    globalVm.taskIcon = UIImage(data: imgData!)!
//                        //                    self.taskIcon.setBackgroundImage(UIImage(named: "list2_0"), for: .normal)
//
//                    }
//                }
//            }
//        }
//        self.addSubview(self.taskIcon)
        
        
//        let optionMenuController = UIAlertController(title: nil, message: "选择图片", preferredStyle: .actionSheet)
//
//                let libraryAction = UIAlertAction(title: "从相册选择", style: .default, handler: {
//                    (alert: UIAlertAction!) -> Void in
//                })
//
//                let cameraAction = UIAlertAction(title: "拍照", style: .default, handler: {
//                    (alert: UIAlertAction!) -> Void in
//                })
//
//                let cancelAction = UIAlertAction(title: "取消", style: .default, handler: {
//                    (alert: UIAlertAction!) -> Void in
//                })
//
//                optionMenuController.addAction(libraryAction)
//                optionMenuController.addAction(cameraAction)
//                optionMenuController.addAction(cancelAction)
//
//                self.present(optionMenuController, animated: true, completion: nil)
        
        
        
//        self.taskIcon.setBackgroundImage(UIImage(named: "list2_0"), for: .normal)
//        self.addSubview(self.taskIcon)
    }

    override required init?(coder: NSCoder) {
        super.init(coder: coder)
    }

//    override func layoutSubviews() {
//        super.layoutSubviews()
//    }
    
    @objc public func creatView(x:CGFloat,y:CGFloat,w:CGFloat,h:CGFloat){
        print(x,y,w,h)
        let params = ["phone":"13815871546", "userPwd":"1"]
//        AF.request("http://101.132.171.250:7901/app/api/login",method: .post,parameters:params).responseJSON { res in
//
//             switch res.result {
//                 case let .success(data):
//                     print(data)
//                
//                 case let .failure(error):
//                     print(error)
//             }
//
//    //
//         }
    }

    //签到
    @objc public func signIn(uid:String) -> Bool{
        
//
//        self.taskIcon.setBackgroundImage(UIImage(named: "ttqlogo"), for: .normal)
        return false
    }

    @objc func login(sender:SubclassedUIButton) -> Bool {
        print(sender.urlString)
        sender.urlString = "666"
        return false
    }
    

    @objc public func sinr(uid:String){
        btn.setTitle(uid, for: .normal)
        let globalVm:GlobalVM = GlobalVM()
        let pUrl = "https://cdn-review.cupshe.com/cmc-admin/2023_05_12/21_03_0411/a95ab4fb-42e6-456e-a1c1-3af58cb13fac/CAA12C3H073AA/2.jpg"

        globalVm.fetchRemoteImage(pUrl) { imgData in
            DispatchQueue.main.async {
                if imgData != nil {
                    if UIImage(data: imgData!) != nil {
                        self.taskIcon.setBackgroundImage(UIImage(data: imgData!)!, for: .normal)
                        //                    globalVm.taskIcon = UIImage(data: imgData!)!
                        //                    self.taskIcon.setBackgroundImage(UIImage(named: "list2_0"), for: .normal)
                        
                    }
                }
            }
        }
    }


}




