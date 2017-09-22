//
//  EFChangePageModle.h
//  EdictForm
//
//  Created by 韦超才 on 2017/8/12.
//  Copyright © 2017年 韦超才. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "EFBaseModle.h"
@interface EFChangePageModle : EFBaseModle

@property (nonatomic,assign)NSInteger maxPage; // 560 defult
@property (nonatomic,assign)NSInteger currentPage;
@property (nonatomic,copy)void(^changepageClosure)(NSInteger page);

@end
