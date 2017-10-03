//
//  qrView.h
//  printer   矩形元素
//
//  Created by songgoo on 2017/7/25.
//  Copyright © 2017年 puty. All rights reserved.
//

#import "baseView.h"

@interface tableView : baseView

//线宽
@property float lineWidth;

//行数
@property int rows;

//列数
@property int cols;

//每行高度
@property NSArray *rowsArr;

//每列高度
@property NSArray *colsArr;


@end
