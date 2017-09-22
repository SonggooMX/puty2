//
//  EFMultiButtonView.h
//  EdictForm
//
//  Created by 韦超才 on 2017/8/10.
//  Copyright © 2017年 韦超才. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ButtonModle.h"

@interface EFMultiButtonView : UIView

@property (nonatomic,assign)NSInteger numberOfItemPerLine;// defaule = 3
@property (nonatomic,assign)NSInteger numberOfLine; // defult = 1

@property (nonatomic,strong)NSArray <ButtonModle *>*itemStrs;

@property (nonatomic,strong)ButtonModle *currentModle;

@property (nonatomic,assign)NSInteger currentindex;

@property (nonatomic,copy)void(^selectedAction)(NSInteger result);


@end
