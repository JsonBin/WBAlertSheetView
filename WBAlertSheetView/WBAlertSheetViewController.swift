//
//  WBAlertSheetViewController.swift
//  WBAlertSheetView
//
//  Created by Zwb on 16/4/13.
//  Copyright © 2016年 zwb. All rights reserved.
//

import UIKit

public enum WBAlertSheetType: Int {
    case Default
    case Destructive
    case Cancle
}

typealias WBAlertAction = (()->Void)?

class WBAlertSheetViewController: UIViewController {

    internal var wbTitle:NSString?  // 标题
    internal var wbMessage:NSString?  // 信息
    
    private let bgView=UIView()
    private var chidControl:UIViewController?
    private var alertCount=1  // 记录button的数量
    private var actions:[WBAlertAction] = []
    private var bgHeight=CGFloat()
    private var bgWidth=CGFloat()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor=UIColor ( red: 0.0, green: 0.0, blue: 0.0, alpha: 0.4 )
        
        bgView.frame=CGRectMake(0, self.view.bounds.size.height, self.view.bounds.size.width, 0)
        bgWidth=CGRectGetWidth(bgView.bounds)
        if wbTitle != nil {
            label(0, string: wbTitle!)
        }
        if wbMessage != nil {
            label(1, string: wbMessage!)
        }
        
        bgHeight=CGRectGetHeight(bgView.bounds)
        bgView.backgroundColor=UIColor.whiteColor()
        self.view.addSubview(bgView)
    }
    
    private func label(count:NSInteger ,string:NSString)->Void{
        if wbTitle==nil {
            bgView.frame=CGRectMake(0, self.view.bounds.size.height-CGFloat(count)*23, bgWidth, 23)
        }else{
            bgView.frame=CGRectMake(0, self.view.bounds.size.height-CGFloat(count+1)*23, bgWidth, 23*CGFloat(count+1))
        }
        let label = UILabel()
        if wbTitle==nil {
            label.frame=CGRectMake(0, 23*CGFloat(count-1), bgWidth, 20)
        }else{
            label.frame=CGRectMake(0, 23*CGFloat(count), bgWidth, 20)
        }
        label.text=string as String
        label.font=UIFont.systemFontOfSize(12)
        label.textColor=UIColor ( red: 0.702, green: 0.702, blue: 0.702, alpha: 1.0 )
        label.textAlignment = .Center
        label.backgroundColor=UIColor.clearColor()
        bgView.addSubview(label)
        
        // 线条
        let lineView = UIView()
        if wbTitle==nil {
            lineView.frame=CGRectMake(0, 21,bgWidth, 1)
        }else{
            if count==0 {
                lineView.frame=CGRectMake(bgWidth/6, CGFloat((count+1)*21),bgWidth/3*2, 1)
            }else{
                lineView.frame=CGRectMake(0, CGFloat((count+1)*21),bgWidth, 1)
            }
        }
        lineView.backgroundColor=UIColor.lightGrayColor()
        bgView.addSubview(lineView)
    }
    
    internal func presentAlertControll(viewControl:UIViewController ,animation:Bool)->Void{
        let win=UIApplication.sharedApplication().keyWindow!
        win.addSubview(self.view)
        viewControl.addChildViewController(self)
        chidControl=viewControl
        if animation {
            let transtion=CATransition()
            transtion.duration=0.5
            transtion.type=kCATransitionMoveIn
            transtion.subtype=kCATransitionFromTop
            transtion.timingFunction=CAMediaTimingFunction.init(name: kCAMediaTimingFunctionDefault)
            self.view.layer.addAnimation(transtion, forKey: nil)
        }
    }
    
    override func touchesEnded(touches: Set<UITouch>, withEvent event: UIEvent?) {
        weak var weakself=self
        if NSStringFromClass(touches.first!.view!.superview!.classForCoder)=="UIView" {
            return
        }
        UIView.animateWithDuration(0.3, animations: {
            weakself?.bgView.frame=CGRectMake((weakself?.bgView.frame.origin.x)!, (weakself?.self.view.bounds.size.height)!, (weakself?.bgWidth)!, 0)
            weakself?.view.alpha=0
        }) { (flag) in
                weakself?.view.removeFromSuperview()
                weakself?.chidControl!.removeFromParentViewController()
                weakself?.dismissViewControllerAnimated(true, completion: nil)
        }
    }

    internal func addAlert(title:NSString, alertType:WBAlertSheetType, action:WBAlertAction){
        actions.append(action)
        bgView.frame=CGRectMake(bgView.frame.origin.x, self.view.bounds.size.height-bgHeight-33*CGFloat(alertCount), bgWidth, 33*CGFloat(alertCount)+bgHeight)
        let button=UIButton.init(type: .System)
        button.frame=CGRectMake(0, bgHeight+33*CGFloat(alertCount-1), bgWidth, 30)
        button.backgroundColor=UIColor.clearColor()
        button.setTitle(title as String, forState: .Normal)
        button.titleLabel?.font=UIFont.systemFontOfSize(15)
        button.tag=alertCount+100
        button.addTarget(self, action: #selector(WBAlertSheetViewController.buttonClicked(_:)), forControlEvents: .TouchUpInside)
        if alertType == .Destructive{
            button.setTitleColor(UIColor.redColor(), forState: .Normal)
        }else {
            button.setTitleColor(UIColor.blueColor(), forState: .Normal)
        }
        bgView.addSubview(button)
        
        if alertCount>1 {
            // 线条
            let lineView = UIView()
            lineView.frame=CGRectMake(0, bgHeight+CGFloat(alertCount-1)*31, bgWidth, 1)
            lineView.backgroundColor=UIColor.lightGrayColor()
            bgView.addSubview(lineView)
        }
        alertCount += 1
    }
    
    internal func buttonClicked(sender:UIButton)->Void{
        (actions[sender.tag-101] as WBAlertAction)!()
        weak var weakself=self
        UIView.animateWithDuration(0.3, animations: {
            weakself?.bgView.frame=CGRectMake((weakself?.bgView.frame.origin.x)!, (weakself?.self.view.bounds.size.height)!, (weakself?.bgWidth)!, 0)
            weakself?.view.alpha=0
        }) { (flag) in
            weakself?.view.removeFromSuperview()
            weakself?.chidControl!.removeFromParentViewController()
            weakself?.dismissViewControllerAnimated(true, completion: nil)
        }
    }
}
