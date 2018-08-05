//
//  ZHWeakTimer.m
//  FindingCar
//
//  Created by VIP Mac on 2018/7/6.
//  Copyright © 2018年 张淏. All rights reserved.
//

#import "ZHWeakTimer.h"

@interface ZHWeakTimerTarget : NSObject
@property (nonatomic, weak) id target;
@property (nonatomic, assign) SEL selector;
@property (nonatomic, weak) NSTimer* timer;
@end

@implementation ZHWeakTimerTarget
- (void) fire:(NSTimer *)timer {
	if(self.target) {
#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Warc-performSelector-leaks"
		[self.target performSelector:self.selector withObject:timer.userInfo afterDelay:0.0f];
#pragma clang diagnostic pop
	} else {
		[self.timer invalidate];
	}
}
@end



@implementation ZHWeakTimer

+ (NSTimer *) scheduledTimerWithTimeInterval:(NSTimeInterval)interval
									  target:(id)aTarget
									selector:(SEL)aSelector
									userInfo:(id)userInfo
									 repeats:(BOOL)repeats{
	ZHWeakTimerTarget* timerTarget = [[ZHWeakTimerTarget alloc] init];
	timerTarget.target = aTarget;
	timerTarget.selector = aSelector;

	timerTarget.timer = [NSTimer scheduledTimerWithTimeInterval:interval
														 target:timerTarget
													   selector:@selector(fire:)
													   userInfo:userInfo
														repeats:repeats];
	return timerTarget.timer;
}

+ (NSTimer *)scheduledTimerWithTimeInterval:(NSTimeInterval)interval
									  block:(ZHTimerHandler)block
								   userInfo:(id)userInfo
									repeats:(BOOL)repeats {
	NSMutableArray *userInfoArray = [NSMutableArray arrayWithObject:[block copy]];
	if (userInfo != nil) {
		[userInfoArray addObject:userInfo];
	}
	return [self scheduledTimerWithTimeInterval:interval
										 target:self
									   selector:@selector(_timerBlockInvoke:)
									   userInfo:[userInfoArray copy]
										repeats:repeats];
	
}

+ (void)_timerBlockInvoke:(NSArray*)userInfo {
	ZHTimerHandler block = userInfo[0];
	id info = nil;
	if (userInfo.count == 2) {
		info = userInfo[1];
	}
	if (block) {
		block(info);
	}
}

@end
