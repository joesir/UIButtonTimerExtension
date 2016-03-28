//
//  ViewController.swift
//  UIButtonTimer
//
//  Created by 蒋志礼 on 16/3/28.
//  Copyright © 2016年 joe. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var sendButton: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        self.sendButton.layer.borderWidth = 1
        self.sendButton.layer.cornerRadius = 3
        self.sendButton.setTitleColor(UIColor.lightGrayColor(), forState: .Disabled)
    }

    @IBAction func sendButtonAction(sender: AnyObject) {
        self.sendButton.disableDelayTimer(10, target: self)
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}

extension ViewController: UIButtonTimerDelegate {
    func durtionTImer(second: NSInteger) {
        self.sendButton.setTitle("重新发送(\(second)s)", forState: .Disabled)
    }
    
    func finishedTimer() {
        
    }
}

