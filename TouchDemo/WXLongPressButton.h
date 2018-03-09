//
//  WXLongPressButton.h
//  TouchDemo
//
//  Created by caikaixuan on 2018/3/6.
//  Copyright © 2018年 caikaixuan. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^CompleteBlock)(NSTimeInterval duration);

@interface WXLongPressButton : UIButton

/**
 拍摄时长 默认10s
 */
@property (nonatomic, assign) NSTimeInterval totalTimeInterval;

/**
 重置状态 还原到最初
 */
- (void)resetState;

/**
 拍摄完成回调  时长
 */
@property (nonatomic, copy) CompleteBlock complete;

@end
