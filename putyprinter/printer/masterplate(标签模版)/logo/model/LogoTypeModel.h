//
//  LogoTypeModel.h
//  TianJinDL
//
//  Created by 王娜 on 2017/8/14.
//  Copyright © 2017年 troilamac. All rights reserved.
//

#import "JSONModelLib.h"

@interface LogoTypeModel : JSONModel
@property (nonatomic,strong) NSString *id;
@property (nonatomic,strong) NSString *name;
@property (nonatomic,strong) NSArray *list;
@property (nonatomic,strong) NSString *imgNamed;

@end


@interface LogoTypeListModel : JSONModel
@property (nonatomic,strong) NSString *id;
@property (nonatomic,strong) NSString *name;
@property (nonatomic,strong) NSMutableArray *imgArr;
@end
