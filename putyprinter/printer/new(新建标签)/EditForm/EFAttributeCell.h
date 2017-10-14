//
//  EFAttributeCell.h
//  EdictForm
//
//  Created by 韦超才 on 2017/8/12.
//  Copyright © 2017年 韦超才. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "EFBaseCell.h"

@interface EFAttributeCell : EFBaseCell

@property (weak, nonatomic) IBOutlet UIView *bView;
@property (weak, nonatomic) IBOutlet UIView *undenLineView;
@property (weak, nonatomic) IBOutlet UIView *deleteView;
@property (weak, nonatomic) IBOutlet UIView *iView;

@property baseView *baseV;

@property (nonatomic,assign)NSInteger currentIndex;

@property (nonatomic,copy)void(^selectedAction)(NSInteger index);

@end
