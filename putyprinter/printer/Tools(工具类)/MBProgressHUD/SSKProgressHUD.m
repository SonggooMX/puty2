//
//  SSKProgressHUD.m
//  printer
//
//  Created by songgoo on 2017/10/10.
//  Copyright © 2017年 puty. All rights reserved.
//

#import "SSKProgressHUD.h"

@implementation SSKProgressHUD

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self initFrame:frame];
    }
    return self;
}

- (void) initFrame:(CGRect)frame
{
    //e5e5e5
    UIColor *borderColor=[UIColor colorWithRed:229.0/255 green:229.0/255 blue:229.0/255 alpha:1.000];
    
    NSArray *views=[[NSBundle mainBundle] loadNibNamed:@"SSKProgressHUD" owner:self options:nil];
    self.contentView=[views objectAtIndex:0];
    self.contentView.frame=frame;
    self.contentView.layer.cornerRadius=5;
    self.contentView.layer.borderWidth=0.5;
    self.contentView.layer.borderColor=borderColor.CGColor;
    [self addSubview:self.contentView];
}

-(void) showMessage:(NSString*)message
{
    self.lbMessage.text=message;
}

@end
