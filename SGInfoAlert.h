//
//  SGInfoAlert.m
//
//  Created by Azure_Sagi on 3/1/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>

#define kSGInfoAlert_fontSize       14
#define kSGInfoAlert_width          200
#define kMax_ConstrainedSize        CGSizeMake(200, 100)

@interface SGInfoAlert : UIView{
    CGColorRef bgcolor_;
    NSString *info_;
    CGSize fontSize_;
}

// info为提示信息，frame为提示框大小，view是为消息框的superView（推荐Tabbarcontroller.view)
// vertical 为垂直方向上出现的位置 从 取值 0 ~ 1。
+ (void)showInfo:(NSString*)info 
         bgColor:(CGColorRef)color
          inView:(UIView*)view 
        vertical:(float)height;

@end
