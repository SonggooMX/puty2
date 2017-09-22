//
//  EFSwitchCell.h
//  EdictForm
//
//  Created by 韦超才 on 2017/8/12.
//  Copyright © 2017年 韦超才. All rights reserved.
//

#import <UIKit/UIKit.h>


#import "EFBaseCell.h"
@interface EFSwitchCell : EFBaseCell


@property (weak, nonatomic) IBOutlet UILabel *titleLable;
@property (weak, nonatomic) IBOutlet UISwitch *mSwitch;

@property (nonatomic,assign)BOOL on;
@property (nonatomic,copy)void(^valueBlock)(BOOL value);

@end
