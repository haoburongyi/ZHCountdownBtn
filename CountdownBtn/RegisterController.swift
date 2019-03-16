//
//  RegisterController.swift
//  CountdownBtn
//
//  Created by 张淏 on 2018/7/26.
//  Copyright © 2018年 张淏. All rights reserved.
//

import UIKit

class RegisterController: UIViewController {
    
    fileprivate let btn = ZHCountdownButton.init()

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        title = "注册"
        view.backgroundColor = UIColor.white
        
        view.addSubview(btn)
        
        navigationItem.rightBarButtonItem = UIBarButtonItem.init(title: "下一页", style: .done, target: self, action: #selector(gotoNextController))
        
        
        
        
        btn.maxSec = 5
        btn.setTitle("获取验证码2", for: .normal)
        btn.setTitleColor(UIColor.red, for: .normal)
        btn.sizeToFit()
        btn.frame.origin = CGPoint.init(x: 100, y: 100)
        btn.addTarget(self, action: #selector(btnClick(sender:)), for: .touchUpInside)
        
    }
    
    @objc fileprivate func btnClick(sender: ZHCountdownButton) {
        ZHCountdownButton.countdown = true
    }
    
    @objc fileprivate func gotoNextController() {
        
        navigationController?.pushViewController(RegisterController(), animated: true)
    }
    
    
    deinit {
        print("RegisterController deinit")
    }

}
