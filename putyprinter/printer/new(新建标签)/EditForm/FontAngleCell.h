//
//  FontAngleCell.h
//  EdictForm
//
//  Created by 韦超才 on 2017/8/12.
//  Copyright © 2017年 韦超才. All rights reserved.
//

#import <UIKit/UIKit.h>


#import "EFBaseCell.h"
@interface FontAngleCell : EFBaseCell


@property (weak, nonatomic) IBOutlet UIView *zeroView;

@property (weak, nonatomic) IBOutlet UIView *secondView;

@property (weak, nonatomic) IBOutlet UIView *thirdView;
@property (weak, nonatomic) IBOutlet UIView *fourthView;


@property (nonatomic,assign)NSInteger seletedIndex;


@property (nonatomic,copy)void(^selectedAcction)(NSInteger);


//旋转
-(void) rate;


@end
