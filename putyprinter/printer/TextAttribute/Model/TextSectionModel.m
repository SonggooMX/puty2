//
//  TextSectionModel.m
//  ceshi
//
//  Created by  on 2017/7/25.
//  Copyright © 2017年 . All rights reserved.
//

#import "TextSectionModel.h"
#import "TextCellModel.h"
@implementation TextSectionModel
+ (NSDictionary *)modelContainerPropertyGenericClass {
    return @{@"sectionRows" : [TextCellModel class]};
}
@end
