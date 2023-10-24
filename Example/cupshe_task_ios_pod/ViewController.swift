//
//  ViewController.swift
//  cupshe_task_ios_pod
//
//  Created by xiaozhong.shi@gmail.com on 10/24/2023.
//  Copyright (c) 2023 xiaozhong.shi@gmail.com. All rights reserved.
//

import UIKit
import cupshe_task_ios_pod

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        var sdk = TaskSDK(token:"",brand:"1",channel:"1",site:"1",terminal:"2", lang:"en-GB",activityId:"44F3DD326696447D260612C6BD37B5E7")
        sdk.setTaskEnvironment(env: TaskEnvironment.TEST)
        
//        TaskSDK(token: String, brand: <#T##String#>, channel: <#T##String#>, site: <#T##String#>, terminal: <#T##String#>, lang: <#T##String#>, activityId: <#T##String#>, uiContextHanlder: UIViewController)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}

