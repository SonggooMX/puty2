//
//  drawArea.h
//  printer
//
//  Created by songgoo on 2017/7/22.
//  Copyright © 2017年 puty. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface drawArea : UIView


@property (strong, nonatomic) IBOutlet UIView *contentView;
@property UIViewController *parent;

#pragma mark -取消所有元素选中
-(void) cancelAllSelected;

@end
