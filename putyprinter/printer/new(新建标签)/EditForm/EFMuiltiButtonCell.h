//
//  EFMuiltiButtonCell.h
//  EdictForm
//
//  Created by 韦超才 on 2017/8/12.
//  Copyright © 2017年 韦超才. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "EFMultiButtonView.h"


#import "EFBaseCell.h"
@interface EFMuiltiButtonCell : EFBaseCell


@property (weak, nonatomic) IBOutlet UILabel *titleLable;

@property (weak, nonatomic) IBOutlet EFMultiButtonView *muiltiBtnView;

@property (nonatomic,strong,readonly)ButtonModle *currentModle;

@property (nonatomic,strong)NSArray <ButtonModle *>*itemStrs;

@property (nonatomic,assign)NSInteger currentindex;

@property (nonatomic,copy)void(^selectedAction)(NSInteger result);

@end
