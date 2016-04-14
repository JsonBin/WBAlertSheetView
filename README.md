# WBAlertSheetView
Swift自定义的AlertSheetController

使用方法
=======
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
        
 效果图
 
  ![gif](https://github.com/JsonBin/WBAlertSheetView/raw/master/alertSheet.gif "自定义alertsheet")
