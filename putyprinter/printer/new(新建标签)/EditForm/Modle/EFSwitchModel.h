//
//  EFSwitchModel.h
//  EdictForm
//
//  Created by 韦超才 on 2017/8/12.
//  Copyright © 2017年 韦超才. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "EFBaseModle.h"
@interface EFSwitchModel : EFBaseModle

@property (nonatomic,assign)BOOL on;
@property (nonatomic,copy)void(^valueBlock)(BOOL value);

@end
