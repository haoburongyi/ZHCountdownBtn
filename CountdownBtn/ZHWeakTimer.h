//
//  ZHWeakTimer.h
//  FindingCar
//
//  Created by VIP Mac on 2018/7/6.
//  Copyright © 2018年 张淏. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void (^ZHTimerHandler)(id userInfo);

@interface ZHWeakTimer : NSObject

+ (NSTimer *) scheduledTimerWithTimeInterval:(NSTimeInterval)interval
target:(id)aTarget
selector:(SEL)aSelector
									userInfo:(id)userInfo
									 repeats:(BOOL)repeats;

+ (NSTimer *)scheduledTimerWithTimeInterval:(NSTimeInterval)interval
									  block:(ZHTimerHandler)block
								   userInfo:(id)userInfo
									repeats:(BOOL)repeats;

@end
