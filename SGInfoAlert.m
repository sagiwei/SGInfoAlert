//
//  SGInfoAlert.m
//  Daily Carb
//
//  Created by Maxwell YQ003 on 3/1/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "SGInfoAlert.h"

@implementation SGInfoAlert


// 画出圆角矩形背景
static void addRoundedRectToPath(CGContextRef context, CGRect rect,
                                 float ovalWidth,float ovalHeight)
{
    float fw, fh;
    if (ovalWidth == 0 || ovalHeight == 0) { // 1
        CGContextAddRect(context, rect);
        return;
    }
    CGContextSaveGState(context); // 2
    CGContextTranslateCTM (context, CGRectGetMinX(rect), // 3
                           CGRectGetMinY(rect));
    CGContextScaleCTM (context, ovalWidth, ovalHeight); // 4
    fw = CGRectGetWidth (rect) / ovalWidth; // 5
    fh = CGRectGetHeight (rect) / ovalHeight; // 6
    CGContextMoveToPoint(context, fw, fh/2); // 7
    CGContextAddArcToPoint(context, fw, fh, fw/2, fh, 1); // 8
    CGContextAddArcToPoint(context, 0, fh, 0, fh/2, 1); // 9
    CGContextAddArcToPoint(context, 0, 0, fw/2, 0, 1); // 10
    CGContextAddArcToPoint(context, fw, 0, fw, fh/2, 1); // 11
    CGContextClosePath(context); // 12
    CGContextRestoreGState(context); // 13
}

- (id)initWithFrame:(CGRect)frame bgColor:(CGColorRef)color info:(NSString*)info{
    CGRect viewR = CGRectMake(0, 0, frame.size.width*1.2, frame.size.height*1.2);
    self = [super initWithFrame:viewR];
    if (self) {
        self.backgroundColor = [UIColor clearColor];
        bgcolor_ = color;
        info_ = info;
        fontSize_ = frame.size;
    }
    return self;
}

- (void)drawRect:(CGRect)rect{
    CGContextRef context = UIGraphicsGetCurrentContext();
    // 背景0.8透明度
    CGContextSetAlpha(context, .8);
    addRoundedRectToPath(context, rect, 4.0f, 4.0f);
    CGContextSetFillColorWithColor(context, bgcolor_);
    CGContextFillPath(context);
    
    // 文字1.0透明度
    CGContextSetAlpha(context, 1.0);
    CGContextSetShadowWithColor(context, CGSizeMake(0, -1), 1, [[UIColor whiteColor] CGColor]);
    CGContextSetFillColorWithColor(context, [[UIColor blackColor] CGColor]);
    float x = (rect.size.width - fontSize_.width) / 2.0;
    float y = (rect.size.height - fontSize_.height) / 2.0;
    CGRect r = CGRectMake(x, y, fontSize_.width, fontSize_.height);
    [info_ drawInRect:r withFont:[UIFont systemFontOfSize:kSGInfoAlert_fontSize] lineBreakMode:UILineBreakModeTailTruncation];
}

- (void)dealloc{
    [super dealloc];
}

// 从上层视图移除并释放
- (void)remove{
    [self removeFromSuperview];
}

// 渐变消失
- (void)fadeAway{
    [UIView beginAnimations:nil context:nil];
    [UIView setAnimationDuration:1.5f];
    self.alpha = .0;
    [UIView commitAnimations];
    [self performSelector:@selector(remove) withObject:nil afterDelay:1.5f];
}

+ (void)showInfo:(NSString *)info 
         bgColor:(CGColorRef)color
          inView:(UIView *)view{
//    CGSize size = [info sizeWithFont:[UIFont systemFontOfSize:kSGInfoAlert_fontSize]
//                            forWidth:kSGInfoAlert_width
//                       lineBreakMode:UILineBreakModeTailTruncation];
    CGSize size = [info sizeWithFont:[UIFont systemFontOfSize:kSGInfoAlert_fontSize]
                   constrainedToSize:kMax_ConstrainedSize];
    CGRect frame = CGRectMake(0, 0, size.width, size.height);
    SGInfoAlert *alert = [[SGInfoAlert alloc] initWithFrame:frame bgColor:color info:info];
    alert.center = CGPointMake(view.center.x, view.frame.size.height*.8);
    alert.alpha = 0;
    [view addSubview:alert];
    [alert release];
    [UIView beginAnimations:nil context:nil];
    [UIView setAnimationDuration:.3f];
    alert.alpha = 1.0;
    [UIView commitAnimations];
    [alert performSelector:@selector(fadeAway) withObject:nil afterDelay:1.5];
}

@end
