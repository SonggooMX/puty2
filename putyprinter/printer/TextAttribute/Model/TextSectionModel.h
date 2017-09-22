//
//  TextSectionModel.h
//  ceshi
//
//  Created by  on 2017/7/25.
//  Copyright © 2017年 . All rights reserved.
//

#import <UIKit/UIKit.h>
@class TextCellModel;
@interface TextSectionModel : NSObject
///标题
@property(nonatomic,copy)NSString* sectionHeaderText;
///高度
@property(nonatomic,assign)CGFloat sectionHeaderHeight;
///行数组
@property(nonatomic,copy)NSArray<TextCellModel*>*  sectionRows;
@end
