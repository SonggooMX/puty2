//
//  lbView.h
//  printer
//
//  Created by songgoo on 2017/7/26.
//  Copyright © 2017年 puty. All rights reserved.
//

#import "baseView.h"

@interface lbView : baseView

-(void) initView:(CGRect)frame withContent:(NSString*)content;
-(void) initView:(CGRect)frame withImage:(UIImage*)image withNString:(NSString *)content;

@end
