//
//  TextCellModel.h
//  ceshi
//
//  Created by  on 2017/7/25.
//  Copyright © 2017年 . All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TextCellModel : NSObject
///标题
@property(nonatomic,copy)NSString* title;
///类型
@property(nonatomic,copy)NSString* type;
///行高
@property(nonatomic,assign)CGFloat rowHeight;
///标签数组
@property(nonatomic,copy)NSArray* tagArray;
///右边文本
@property(nonatomic,copy)NSString* rightText;

@end
