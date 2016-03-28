//
//  UIButtonTimerExtension.swift
//  UIButtonTimerExtension
//
//  Created by joe on 16/3/28.
//  Copyright © 2016年 joe. All rights reserved.
//

import Foundation
//import ObjectiveC

private var buttonTimerKey: UInt8 = 0
private var buttonMaxSecondsKey: UInt8 = 1
private var buttonDelegateKey: UInt8 = 2

protocol UIButtonTimerDelegate {
    func durtionTImer(second:NSInteger)
    func finishedTimer()
}

extension UIButton {
    var timer:NSTimer? {
        get {
            return objc_getAssociatedObject(self, &buttonTimerKey) as? NSTimer
        }
        set(newValue) {
            objc_setAssociatedObject(self, &buttonTimerKey, newValue, .OBJC_ASSOCIATION_RETAIN)
        }
    }
    
    var maxSeconds:NSInteger {
        get {
            return (objc_getAssociatedObject(self, &buttonMaxSecondsKey) as! NSNumber).integerValue
        }
        set(newValue) {
            objc_setAssociatedObject(self, &buttonMaxSecondsKey, NSNumber(integer: newValue), .OBJC_ASSOCIATION_ASSIGN)
        }
    }
    
    var delegate:UIButtonTimerDelegate? {
        get {
            return (objc_getAssociatedObject(self, &buttonDelegateKey) as? UIButtonTimerDelegate)
        }
        set(newValue) {
            objc_setAssociatedObject(self, &buttonDelegateKey, newValue as! AnyObject, .OBJC_ASSOCIATION_ASSIGN)
        }
    }
    
    func disableDelayTimer(seconds:NSInteger,target:UIButtonTimerDelegate) {
        self.delegate = target
        self.maxSeconds = seconds
        if self.timer == nil {
            self.timer = NSTimer.scheduledTimerWithTimeInterval(1,
                                 target: self,
                                 selector: #selector(UIButton.setSubmitBtnText),
                                 userInfo: nil,
                                 repeats: true)
        }
        setSubmitBtnText()
        self.enabled = false
    }
    
    func setSubmitBtnText() {
        self.maxSeconds -= 1
        if self.maxSeconds > 0 {
            delegate?.durtionTImer(self.maxSeconds)
        }else{
            delegate?.finishedTimer()
            self.enabled = true
        }
    }
}