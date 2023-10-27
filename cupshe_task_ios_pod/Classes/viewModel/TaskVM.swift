//
//  TaskVM.swift
//  OcSwiftUIDemo
//
//  Created by gbl on 2023/10/14.
//

import Foundation
import Alamofire
import SwiftyJSON
import CommonCrypto

class TaskVM {
    
    func getTaksList(env: TaskEnvironment,token: String,params: TaskListParam, callback: @escaping ([TaskInfoVO]?) -> Void){
        
        do{
            let headers:HTTPHeaders = ["Authorization":token,
                                       "Content-Type":"application/json",
                                       "charset": "UTF-8",
                                       "Accept": "application/json"]
//
//            HttpUtil.headers["Authorization"] = token
          
            AF.request(ApiConfig.getAPIPath(env: env) + ApiConfig.API_GET_TASK_LIST,method: .post,parameters:params,encoder: JSONParameterEncoder.default,headers: headers).responseJSON { res in
      
                switch res.result {
                case let .success(data):
                    var ret = JSON(data)
                    if ret["success"].boolValue {
                        let result = U_result_List<TaskInfoVO>(jsonData: ret["data"])
                        if result?.code == 0{
                            if (result?.data.count)! > 0 {
                                var lst: [TaskInfoVO] = [TaskInfoVO]()
                                //list
                                //                         let result = U_result_List<Staff>(jsonData: JSON(data))
                                result?.data.map(){ info in
                                    
                                    
                                    lst.append(info)
                                }
                                callback(lst)
                                
                            }else{
                                callback(nil)
                            }
                        }else{
                            callback(nil)
                        }
                    }else{
                        print(ret["retInfo"].stringValue)
                        callback(nil)
                    }
                case let .failure(error):
                    print(error)
                    callback(nil)
                    //                     self.sms = nil
                }
                
            }
        }catch let err {
            print(err)
        }
    }
    
    func checkPageBrowseView(env:TaskEnvironment,userId:Int,brand:Int,channel:Int,site:Int,terminal:Int,lang:String, callback: @escaping ([TaskInfo]?) -> Void){
        //        API_GET_RECOMMAND_DATA
        let params = ["uid":userId]
        AF.request(ApiConfig.getAPIPath(env: env) + ApiConfig.API_GET_TASK_LIST,method: .post,parameters:params).responseJSON { res in

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
    
    
    func taskCheckIn(env:TaskEnvironment,token: String,params: TaskCheckInParam, callback: @escaping ([UserTaskProgress]?) -> Void){
        do{
            HttpUtil.headers["Authorization"] = token
            AF.request(ApiConfig.getAPIPath(env: env) + ApiConfig.API_CHECK_IN,method: .post,parameters:params,encoder: JSONParameterEncoder.default,headers: HttpUtil.headers).responseJSON { res in
                
                print(res)
                switch res.result {
                case let .success(data):
                    var ret = JSON(data)
//                    print(ret)
                    if ret["success"].boolValue {
                        let result = U_result_List<UserTaskProgress>(jsonData: ret["data"])
                        if result?.code == 0{
                            if (result?.data.count)! > 0 {
                                var lst: [UserTaskProgress] = [UserTaskProgress]()
                                //list
                                //                         let result = U_result_List<Staff>(jsonData: JSON(data))
                                result?.data.map(){ info in
                                    
                                    
                                    lst.append(info)
                                }
                                callback(lst)
                                
                            }else{
                                callback(nil)
                            }
                        }else{
                            callback(nil)
                        }
                    }else{
                        print(ret["retInfo"].stringValue)
                        callback(nil)
                    }
                case let .failure(error):
                    print(error)
                    callback(nil)
                    //                     self.sms = nil
                }
                
            }
        }catch let err {
            print(err)
        }
    }
    
    func startPageViewTask(env:TaskEnvironment,token: String,params: TaskPageViewParam, callback: @escaping (TaskPageViewVO?) -> Void){
        do{
            HttpUtil.headers["Authorization"] = token
            AF.request(ApiConfig.getAPIPath(env: env) + ApiConfig.API_Page_VIEW_TASK_START,method: .post,parameters:params,encoder: JSONParameterEncoder.default,headers: HttpUtil.headers).responseJSON { res in
                print(res)
                switch res.result {
                case let .success(data):
                    var ret = JSON(data)
                    if ret["success"].boolValue {
                        let result = U_result<TaskPageViewVO>(jsonData: JSON(ret["data"]));
                        if result?.code == 0{
                            var data = result?.data as! TaskPageViewVO
                            callback(data)
                        }else{
                            callback(nil)
                        }
                    }else{
                        print(ret["retInfo"].stringValue)
                        callback(nil)
                    }
                case let .failure(error):
                    print(error)
                    callback(nil)
                }
                
            }
        }catch let err {
            print(err)
        }
    }
    
    func stopPageViewTask(env:TaskEnvironment,token: String,params: TaskPageViewParam, callback: @escaping (Int?) -> Void){
        do{
            HttpUtil.headers["Authorization"] = token
            AF.request(ApiConfig.getAPIPath(env: env) + ApiConfig.API_Page_VIEW_TASK_STOP,method: .post,parameters:params,encoder: JSONParameterEncoder.default,headers: HttpUtil.headers).responseJSON { res in
    print(res)
                switch res.result {
                case let .success(data):
                    var ret = JSON(data)
                    if ret["success"].boolValue {
                        
                        if ret["data"]["code"].intValue == 0{
                            var userTaskProgressId = ret["data"]["data"].intValue
                            callback(userTaskProgressId)
                        }else{
                            callback(nil)
                        }
                        
                        
                    }else{
                        print(ret["retInfo"].stringValue)
                        callback(nil)
                    }
                case let .failure(error):
                    print(error)
                    callback(nil)
                }
                
            }
        }catch let err {
            print(err)
        }
    }
    
    func getUserShareId(env:TaskEnvironment,token: String,params: UserShareParam, callback: @escaping (String?) -> Void){
        do{
            HttpUtil.headers["Authorization"] = token
            AF.request(ApiConfig.getAPIPath(env: env) + ApiConfig.API_GET_USER_SHARE_ID,method: .post,parameters:params,encoder: JSONParameterEncoder.default,headers: HttpUtil.headers).responseJSON { res in
    
                switch res.result {
                case let .success(data):
                    var ret = JSON(data)
                    if ret["success"].boolValue {
                        if ret["data"]["code"].intValue == 0{
                            var shareId = ret["data"]["data"].stringValue
                            callback(shareId)
                        }else{
                            callback(nil)
                        }
                 

                    }else{
                        print(ret["retInfo"].stringValue)
                        callback(nil)
                    }
                case let .failure(error):
                    print(error)
                    callback(nil)
                }
                
            }
        }catch let err {
            print(err)
        }
    }
    
    
    func getShareUrl(env:TaskEnvironment,token: String,params: UserShareParam, callback: @escaping (String?) -> Void){
        do{
            HttpUtil.headers["Authorization"] = token
            AF.request(ApiConfig.getAPIPath(env: env) + ApiConfig.API_GET_SHARE_URL,method: .post,parameters:params,encoder: JSONParameterEncoder.default,headers: HttpUtil.headers).responseJSON { res in
    
                switch res.result {
                case let .success(data):
                    var ret = JSON(data)
                    if ret["success"].boolValue {
                        if ret["data"]["code"].intValue == 0{
                            var shareId = ret["data"]["data"].stringValue
                            callback(shareId)
                        }else{
                            callback(nil)
                        }
                 

                    }else{
                        print(ret["retInfo"].stringValue)
                        callback(nil)
                    }
                case let .failure(error):
                    print(error)
                    callback(nil)
                }
                
            }
        }catch let err {
            print(err)
        }
    }
    
    func getTaskInfo(env:TaskEnvironment,token: String,params: TaskInfoParam, callback: @escaping (TaskInfoVO?) -> Void){
        do{
            HttpUtil.headers["Authorization"] = token
            AF.request(ApiConfig.getAPIPath(env: env) + ApiConfig.API_GET_TASK_INFO,method: .post,parameters:params,encoder: JSONParameterEncoder.default,headers: HttpUtil.headers).responseJSON { res in
                print(res)
                switch res.result {
                case let .success(data):
                    var ret = JSON(data)
                    if ret["success"].boolValue {
                        let result = U_result<TaskInfoVO>(jsonData: JSON(ret["data"]));
                        if result?.code == 0{
                            var data = result?.data as! TaskInfoVO
                            callback(data)
                        }else{
                            callback(nil)
                        }
                    }else{
                        print(ret["retInfo"].stringValue)
                        callback(nil)
                    }
                case let .failure(error):
                    print(error)
                    callback(nil)
                }
                
            }
        }catch let err {
            print(err)
        }
    }
    
    
    
}
