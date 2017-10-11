//
//  SSKProgressHUD.h
//  printer
//
//  Created by songgoo on 2017/10/10.
//  Copyright © 2017年 puty. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SSKProgressHUD : UIView

@property (weak, nonatomic) IBOutlet UILabel *lbMessage;

@property (strong, nonatomic) IBOutlet UIView *contentView;

-(void) showMessage:(NSString*)message;

@end
