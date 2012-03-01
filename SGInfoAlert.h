//
//  SGInfoAlert.h
//  Daily Carb
//
//  Created by Maxwell YQ003 on 3/1/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>

#define kSGInfoAlert_fontSize       15
#define kSGInfoAlert_width          200
#define kMax_ConstrainedSize        CGSizeMake(200, 100)

@interface SGInfoAlert : UIView{
    CGColorRef bgcolor_;
    NSString *info_;
    CGSize fontSize_;
}

// info为提示信息，frame为提示框大小，view是为消息框的superView（推荐Tabbarcontroller.view）
+ (void)showInfo:(NSString*)info 
         bgColor:(CGColorRef)color
          inView:(UIView*)view;

@end
