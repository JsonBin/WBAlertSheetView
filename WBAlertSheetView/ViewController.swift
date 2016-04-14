//
//  ViewController.swift
//  WBAlertSheetView
//
//  Created by Zwb on 16/4/13.
//  Copyright © 2016年 zwb. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        self.title="WBAlertSheetView"
        
        let button=UIButton.init(type: .System)
        button.frame=self.view.bounds
        button.setTitle("点击", forState: .Normal)
        button.addTarget(self, action: #selector(ViewController.click), forControlEvents: .TouchUpInside)
        self.view.addSubview(button)
        
    }
    
    func click() -> Void {
        // 初始化
        let alert=WBAlertSheetViewController()
        // 设置属性（标题，内容） 可不设置
        alert.wbTitle="测试"
        alert.wbMessage="这只是一个测试"
        
        // 添加按钮
        alert.addAlert("测试一", alertType: .Default, action: {
            print("测试   一   点击")
        })
        alert.addAlert("测试二", alertType: .Destructive, action: {
            print("测试    二    点击")
        })
        alert.addAlert("测试三", alertType: .Default, action: {
            print("测试   三   点击")
        })
        alert.addAlert("取消", alertType: .Cancle, action: {
            print("取消")
        })
        // 推送显示
        alert.presentAlertControll(self, animation: true)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

