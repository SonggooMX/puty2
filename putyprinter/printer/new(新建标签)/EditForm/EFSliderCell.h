//
//  EFSliderCell.h
//  EdictForm
//
//  Created by 韦超才 on 2017/8/12.
//  Copyright © 2017年 韦超才. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "EFBaseCell.h"
@interface EFSliderCell : EFBaseCell

@property (weak, nonatomic) IBOutlet UILabel *title;
@property (weak, nonatomic) IBOutlet UISlider *slider;

@property (nonatomic,copy)void(^valueBlock)(CGFloat value);

@end
