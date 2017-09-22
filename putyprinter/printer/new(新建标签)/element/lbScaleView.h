//
//  lbScaleView.h
//  printer
//
//  Created by songgoo on 2017/7/26.
//  Copyright © 2017年 puty. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface lbScaleView : UIView

@property CGPoint beginpoint;
@property UIView *parent;
@property UIView *pparent;


-(CGRect)getContentRect:(NSString*)content withWidth:(CGFloat)width;

@end
