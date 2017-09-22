//
//  EFAttributeModle.h
//  EdictForm
//
//  Created by 韦超才 on 2017/8/12.
//  Copyright © 2017年 韦超才. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "EFBaseModle.h"
@interface EFAttributeModle : EFBaseModle

@property (nonatomic,assign)NSInteger currentIndex;
@property (nonatomic,copy)void(^selectedAction)(NSInteger index);

@end
