//
//  EFResultModle.h
//  EdictForm
//
//  Created by 韦超才 on 2017/8/12.
//  Copyright © 2017年 韦超才. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface EFResultModle : NSObject

@property (nonatomic,strong)NSString *codeType;

@property (nonatomic,strong)NSString *textPosition;

@property (nonatomic,strong)NSString *dataType;

@property (nonatomic,strong)NSString *currentTxt;
@property (nonatomic,strong)NSString *dataName;
@property (nonatomic,assign)NSInteger page;

@property (nonatomic,strong)NSString *fontType;

@property (nonatomic,strong)NSString *fontSize;

@property (nonatomic,strong)NSString *aligment;

@property (nonatomic,assign)NSInteger attributeType;

@property (nonatomic,assign)double x;

@property (nonatomic,assign)double y;

@property (nonatomic,assign)double width;

@property (nonatomic,assign)double height;

@property (nonatomic,assign)NSInteger angleType;

@property (nonatomic,assign)BOOL isPrint;



@end
