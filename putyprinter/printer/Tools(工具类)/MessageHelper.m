//
//  MessageHelper.m
//  printer
//
//  Created by songgoo on 2017/10/15.
//  Copyright © 2017年 puty. All rights reserved.
//

#import "MessageHelper.h"
#import "MBProgressHUD.h"

@implementation MessageHelper

#pragma  makr - 显示信息
-(void) Toask:(UIView*)view showMessage:(NSString*)message delay:(double)t
{
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:view animated:YES];
    
    // Set the text mode to show only text.
    hud.mode = MBProgressHUDModeText;
    hud.label.text = message;
    // Move to bottm center.
    hud.offset = CGPointMake(0.f, MBProgressMaxOffset);
    
    [hud hideAnimated:YES afterDelay:t];
}

@end
