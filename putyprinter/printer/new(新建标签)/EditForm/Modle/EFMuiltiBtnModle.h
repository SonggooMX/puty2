//
//  EFMuiltiBtnModle.h
//  EdictForm
//
//  Created by 韦超才 on 2017/8/12.
//  Copyright © 2017年 韦超才. All rights reserved.
//

#import <Foundation/Foundation.h>
@class ButtonModle;

#import "EFBaseModle.h"

@interface EFMuiltiBtnModle : EFBaseModle

@property (nonatomic,strong,readonly)ButtonModle *currentModle;
@property (nonatomic,assign)NSInteger currentindex;
@property (nonatomic,copy)void(^selectedAction)(NSInteger result);

@property (nonatomic,strong)NSArray <ButtonModle *>*itemStrs;

@end
