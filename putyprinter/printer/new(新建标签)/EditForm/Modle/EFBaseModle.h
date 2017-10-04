//
//  EFBaseModle.h
//  EdictForm
//
//  Created by 韦超才 on 2017/8/12.
//  Copyright © 2017年 韦超才. All rights reserved.
//

#import <Foundation/Foundation.h>

#import <UIKit/UIKit.h>
#import "baseView.h"
#import "newLabel.h"

typedef NS_ENUM(NSUInteger, EFCellType) {
    EFCellTypeMuiltiBtn,
    EFCellTypePickView,
    EFCellTypeChangePage,
    EFCellTypeFontSize,
    EFCellTypeAttribute,
    EFCellTypeAngle,
    EFCellTypeSwitch,
    EFCellTypeSlider,
    EFCellTypePosition,
    EFCellTypeButtonCell
};

@class EFBaseCell;


@interface EFBaseModle : NSObject

@property UIViewController *parent;

@property (nonatomic,assign)EFCellType type;

@property (nonatomic,strong)NSString *title;

@property (nonatomic,copy)void(^selectedAction)();

@property (nonatomic,assign)CGFloat rowHeight;

+ (NSString *)cellId;

+ (NSString *)cellIdWithType:(EFCellType)type;

+ (instancetype)modleWithType:(EFCellType)type;

- (void)setupWithCell:(EFBaseCell *)cell withBaseView:(baseView*)bview withNewLabel:(newLabel*)linfo;


@end
