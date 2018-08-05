//
//  ViewController.swift
//  CountdownBtn
//
//  Created by 张淏 on 2018/7/26.
//  Copyright © 2018年 张淏. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    
    override func viewDidLoad() {
        super.viewDidLoad()
//         Do any additional setup after loading the view, typically from a nib.
    
//        let btn = ZHCountdownButton.init()
//        btn.setTitle("获取验证码", for: .normal)
//        btn.setTitleColor(UIColor.red, for: .normal)
//        btn.sizeToFit()
//        btn.frame.origin = CGPoint.init(x: 100, y: 100)
//        btn.addTarget(self, action: #selector(btnClick(sender:)), for: .touchUpInside)
//
//        view.addSubview(btn)
//
//
//        let btn1 = ZHCountdownButton.init()
//        btn1.setTitle("获取验证码1", for: .normal)
//        btn1.setTitleColor(UIColor.red, for: .normal)
//        btn1.sizeToFit()
//        btn1.frame.origin = CGPoint.init(x: 100, y: 200)
//        btn1.addTarget(self, action: #selector(btnClick(sender:)), for: .touchUpInside)
//
//        view.addSubview(btn1)
        
        navigationItem.rightBarButtonItem = UIBarButtonItem.init(title: "下一页", style: .done, target: self, action: #selector(gotoNextController))
    }
    
    @objc fileprivate func gotoNextController() {
       
        navigationController?.pushViewController(RegisterController(), animated: true)
    }
    
    @objc fileprivate func btnClick(sender: ZHCountdownButton) {
        ZHCountdownButton.countdown = true
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

