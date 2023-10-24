//
//  GlobalVM.swift
//  TaskSDK
//
//  Created by gbl on 2023/10/10.
//

import Foundation

class GlobalVM {
    
    func fetchRemoteImage(_ httpUrl:String,callback: @escaping (Data?) -> Void)  //用来下载互联网上的图片
    {
        guard let url = URL(string: httpUrl) else { return } //初始化一个字符串常量，作为网络图片的地址
        URLSession.shared.dataTask(with: url){ (data, response, error) in //执行URLSession单例对象的数据任务方法，以下载指定的图片
            if data != nil {
                callback(data!)
            }else{
                callback(nil)
            }
            //                if let image = UIImage(data: data!){
            //                    self.remoteImage = image //当图片下载成功之后，将下载后的数据转换为图像，并存储在remoteImage属性中
            //                }
            //                else{
            //                    print(error ?? "") //如果图片下载失败之后，则在控制台输出错误信息
            //                }
        }.resume() //通过执行resume方法，开始下载指定路径的网络图片
    }
}
