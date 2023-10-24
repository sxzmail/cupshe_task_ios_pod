//
//  TaskListVM.swift
//  OcSwiftUIDemo
//
//  Created by gbl on 2023/10/12.
//

import Foundation
import Alamofire
import SwiftyJSON
import CommonCrypto

class TaskListVM {
    
    func login(_ userName:String, _ userPwd:String,callback: @escaping (Student?) -> Void){
        
        let params = ["phone":userName, "userPwd":userPwd]
        AF.request("http://101.132.171.250:7901/app/api/login",method: .post,parameters:params).responseJSON { res in
    
                     switch res.result {
                     case let .success(data):
//                         print(data)
                         let result = U_result<Student>(jsonData: JSON(data));
                         if result?.code == 0{
//                             print(result?.data)
//                             type(of: result?.data)
                             var userInfo = result?.data as! Student
//                             self.userID = (result?.data as! Account).id
//                             self.loginFlag = true
                             print("1")
                             callback(userInfo)
                             print("2")
                         }else{
//                             self.userID = ""
                             callback(nil)
                         }
                         
//                         //list
                         
//                         let result = U_result_List<Staff>(jsonData: JSON(data))
//                         result?.data.map(){ staff in
//
//                             print((staff as Staff).username)
//                         }


                     case let .failure(error):
                         print(error)
//                         self.userID = ""
   
                     }
                     
//
                 }
    }
    
    
    
    func getTaksList(_ uid:String, callback: @escaping ([TaskInfo]?) -> Void){
        //        API_GET_RECOMMAND_DATA
        let params = ["uid":uid]
        AF.request(ApiConfig.API_GET_TASK_LIST,method: .post,parameters:params).responseJSON { res in

             switch res.result {
                 case let .success(data):
                 let result = U_result_List<TaskInfo>(jsonData: JSON(data))
                 if result?.code == 0{
                     if (result?.data.count)! > 0 {
                         var typesList: [TaskInfo] = [TaskInfo]()
                         //list
//                         let result = U_result_List<Staff>(jsonData: JSON(data))
                         result?.data.map(){ typesInfo in

                             
                             typesList.append(typesInfo)
                         }
                         callback(typesList)

                     }else{
                         callback(nil)
                     }
                 }else{
                     callback(nil)
                 }
                 case let .failure(error):
                     print(error)
                    callback(nil)
//                     self.sms = nil
             }

         }
    }
    
//    func getTaskInfo(_ userName:String, _ userPwd:String,callback: @escaping (TaskInfo?) -> Void){
//        
//        let params = ["phone":userName, "userPwd":userPwd]
//        AF.request(ApiConfig.API_GET_TASK_INFO,method: .post,parameters:params).responseJSON { res in
//    
//                     switch res.result {
//                     case let .success(data):
////                         print(data)
//                         let result = U_result<TaskInfo>(jsonData: JSON(data));
//                         if result?.code == 0{
////                             print(result?.data)
////                             type(of: result?.data)
//                             var taskInfo:TaskInfo = result?.data as! TaskInfo
////                             self.userID = (result?.data as! Account).id
////                             self.loginFlag = true
//                             callback(taskInfo)
//                         }else{
////                             self.userID = ""
//                             callback(nil)
//                         }
//                         
////                         //list
//                         
////                         let result = U_result_List<Staff>(jsonData: JSON(data))
////                         result?.data.map(){ staff in
////
////                             print((staff as Staff).username)
////                         }
//
//
//                     case let .failure(error):
//                         print(error)
//                     }
//                     
////
//                 }
//    }
    
    
//    func saveTaskInfo(_ videoPath:URL,_ homeWork:HomeWork,callback: @escaping (HomeWork?) -> Void){
//        //        API_GET_RECOMMAND_DATA
//
//        do{
//
//            AF.upload(multipartFormData: { multipartFormData in
//                multipartFormData.append(videoPath, withName: "file")
//            }, to: ApiConfig.API_UPLOAD_HOMEWORK_VIDEO, method: .post, headers: ["Content-Type": "application/json"]).uploadProgress(closure: { (progress) in
//                print("Upload Progress: \(progress.fractionCompleted)")
//            })
//
//            .responseJSON{
//                (response) in
//                debugPrint("SUCCESS RESPONSE: \(response)")
//                switch response.result{
//                case let .success(data):
////                    print(type(of: data))
//                    let rs =  JSON(data)
//                    if rs["code"].intValue == 0 {
//                        let videoUrl = rs["data"].stringValue
//                        homeWork.url = videoUrl
//                        do{
//                            let strParam = try JSONEncoder().encode(homeWork)
//                            let homeWorkData = String(decoding: strParam, as: UTF8.self)
//
//                            let params = ["data":homeWorkData]
//                            AF.request(ApiConfig.API_ADD_HOMEWORK,method: .post,parameters:params).responseJSON { res in
//
//                                 switch res.result {
//                                     case let .success(data):
//                                     let result = U_result<HomeWork>(jsonData: JSON(data));
//                                     if result?.code == 0{
//                    //                             print(result?.data)
//                    //                             type(of: result?.data)
//                                         var homeWorkInfo = result?.data as! HomeWork
//                    //                             self.userID = (result?.data as! Account).id
//                    //                             self.loginFlag = true
//                                         callback(homeWorkInfo)
//                                     }else{
//                    //                             self.userID = ""
//                                         callback(nil)
//                                     }
//                                     case let .failure(error):
//                                         print(error)
//                                        callback(nil)
//                    //                     self.sms = nil
//                                 }
//
//                             }
//                        }catch let error{
//
//                        }
//
//                    }
//
//
////                    let json = data as? JSON
////                    print(json["code"].intValue,terminator: "==")
////                    print(json["data"].intValue)
//                    break
//                case let .failure(err):
//                    print(err)
//                    break
//                }
//             }
//
//        }catch{
//
//        }
//
//
//    }
    
}

