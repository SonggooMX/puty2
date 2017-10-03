//
//  EFBaseModle.m
//  EdictForm
//
//  Created by 韦超才 on 2017/8/12.
//  Copyright © 2017年 韦超才. All rights reserved.
//

#import "EFBaseModle.h"

#import "EFMuiltiBtnModle.h"
#import "PickViewModle.h"
#import "EFChangePageModle.h"
#import "EFFontSizeModle.h"
#import "EFAttributeModle.h"
#import "EFAngleModel.h"
#import "EFSwitchModel.h"
#import "EFSliderModel.h"
#import "EFPositionModel.h"
#import "EFButtonCellModle.h"
@implementation EFBaseModle




+ (NSString *)cellIdWithType:(EFCellType)type
{
    return [[self classWithType:type] cellId];
}

+ (instancetype)modleWithType:(EFCellType)type
{
    EFBaseModle *modle = [[self classWithType:type] new];
    modle.type = type;
    return modle;
}

- (instancetype)initWithType:(EFCellType)type
{
    if (self = [super init]) {
        _type = type;
    }
    return self;
}

+ (Class)classWithType:(EFCellType)type
{
    
    switch (type) {
        case EFCellTypeMuiltiBtn:
        {
            return [EFMuiltiBtnModle class];
        }
            break;
        case EFCellTypePickView:
        {
            return [PickViewModle class];
        }
            break;
        case EFCellTypeChangePage:
        {
            return [EFChangePageModle class];
        }
            break;
        case EFCellTypeFontSize:
        {
            return [EFFontSizeModle class];
        }
            break;
        case EFCellTypeAttribute:
        {
            return [EFAttributeModle class];
        }
            break;
        case EFCellTypeAngle:
        {
            return [EFAngleModel class];
        }
            break;
        case EFCellTypeSwitch:
        {
            return [EFSwitchModel class];
        }
            break;
        case EFCellTypeSlider:
        {
            return [EFSliderModel class];
        }
            break;
        case EFCellTypePosition:
        {
            return [EFPositionModel class];
        }
            break;
        case EFCellTypeButtonCell:
        {
            return [EFButtonCellModle class];
        }
        default:
            break;
    }
    return [self class];
}


+ (NSString *)cellId
{
    // subclass must overrid it
    return @"cell";
}

- (void)setupWithCell:(EFBaseCell *)cell withBaseView:(baseView*)bview withNewLabel:(newLabel *)linfo
{
    
}

@end
