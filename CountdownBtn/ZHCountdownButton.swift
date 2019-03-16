//
//  ZHCountdownButton.swift
//  CountdownBtn
//
//  Created by 张淏 on 2018/7/26.
//  Copyright © 2018年 张淏. All rights reserved.
//

import UIKit

fileprivate class ZHCountdownManager: NSObject {
    
    fileprivate static var instance: ZHCountdownManager?
    fileprivate class func share() -> ZHCountdownManager {
        if ZHCountdownManager.instance == nil {
            ZHCountdownManager.instance = ZHCountdownManager.init()
        }
        return ZHCountdownManager.instance!
    }
    fileprivate var countdownButtons = [ZHCountdownButton]()
    fileprivate var sec = -1
    fileprivate var timer: Timer?
    fileprivate var maxSec = 60
    
    public func invalidate() {
        ZHCountdownManager.instance = nil
    }
    
    fileprivate var countdown = false {
        didSet {
            
            if countdown {
                
                for button in countdownButtons {
                    sec = sec == -1 ? maxSec : sec
                    button._currentTitle = button._currentTitle == nil ? button.title(for: .normal) : button._currentTitle
                    button.countdown_setTitle("\(sec)", for: .normal)
                    button.isUserInteractionEnabled = false
                }
                timer = ZHWeakTimer.scheduledTimer(withTimeInterval: 1, target: self, selector: #selector(countdowning), userInfo: nil, repeats: true)
            } else {
                if timer != nil {
                    for button in countdownButtons {
                        button.recovery()
                    }
                    if timer != nil {
                        timer?.invalidate()
                        timer = nil
                    }
                }
            }
        }
    }
    
    fileprivate var saveLastButton: ZHCountdownButton?
    
    
    @objc fileprivate func countdowning() {
        
        sec -= 1
        for button in countdownButtons {
            if sec < 0 {
                button.recovery()
                continue
            }
            button.countdown_setTitle("\(sec)", for: .normal)
        }
        
        if sec < 0 {
            countdown = false
            sec = -1
            saveLastButton = nil
            if timer != nil {
                timer?.invalidate()
                timer = nil
            }
        }
    }
    
    private override init() {
        super.init()
    }
    
    deinit {
        print("manager deinit")
    }
}

@objc class ZHCountdownButton: UIButton {
    
    
    var maxSec = 60 {
        didSet {
            ZHCountdownManager.share().maxSec = maxSec
        }
    }
    
    fileprivate var _currentTitle: String?
    
    static var countdown = false {
        didSet {
            ZHCountdownManager.share().countdown = countdown
        }
    }
    
    fileprivate func recovery() {
        
        isUserInteractionEnabled = true
        countdown_setTitle(_currentTitle ?? "", for: .normal)
    }
    
    override func didMoveToSuperview() {
        
        super.didMoveToSuperview()
        guard superview != nil else {
            return
        }
        
        let manager = ZHCountdownManager.share()
        
        if manager.countdown == true {
            
            _currentTitle = title(for: .normal)
            countdown_setTitle("\(manager.sec)", for: .normal)
            isUserInteractionEnabled = false
        }
        if manager.countdownButtons.contains(self) == false {
            manager.countdownButtons.append(self)
        }
    }
    
    override func removeFromSuperview() {
        let manager = ZHCountdownManager.share()
        
        if manager.countdownButtons.count == 1 && manager.countdown == true {
            manager.saveLastButton = manager.countdownButtons.first!
        }
        
        if let index = manager.countdownButtons.index(of: self) {
            manager.countdownButtons.remove(at: index)
            if manager.countdownButtons.count == 0 && manager.saveLastButton == nil {
                manager.timer?.invalidate()
                manager.timer = nil
                manager.invalidate()
            }
        }
        
        super.removeFromSuperview()
    }
    
    override func setTitle(_ title: String?, for state: UIControl.State) {
        super.setTitle(title, for: state)
        print("setTitle")
        if _currentTitle == nil, title != nil && title != "" {
            _currentTitle = title
        }
    }
    
    fileprivate func countdown_setTitle(_ title: String?, for state: UIControl.State) {
        super.setTitle(title, for: state)
        print("countdown_setTitle")
    }
    
    deinit {
        print("countdown button deinit")
        let manager = ZHCountdownManager.share()
        if manager.countdownButtons.count == 0 {
            manager.timer?.invalidate()
            manager.timer = nil
            manager.invalidate()
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
}
