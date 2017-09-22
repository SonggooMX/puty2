//
//  PickViewModle.h
//  EdictForm
//
//  Created by 韦超才 on 2017/8/12.
//  Copyright © 2017年 韦超才. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "EFBaseModle.h"
@interface PickViewModle : EFBaseModle

//@property (nonatomic,strong)NSString *title;

@property (nonatomic,strong)NSString *subTitle;

@property (nonatomic,strong)NSArray *subTitleArray;


@property (nonatomic,copy)void(^showPickView)(UIAlertController *alert);

@end
