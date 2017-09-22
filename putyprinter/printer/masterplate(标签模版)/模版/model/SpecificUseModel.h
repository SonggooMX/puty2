//
//  SpecificUseModel.h
//  TianJinDL
//
//  Created by apple on 17/8/14.
//  Copyright © 2017年 troilamac. All rights reserved.
//

#import "JSONModelLib.h"

@interface SpecificUseModel : JSONModel
@property (nonatomic,strong) NSString *id;
@property (nonatomic,strong) NSString *name;
@property (nonatomic,strong) NSArray *list;
@property (nonatomic,strong) NSString *imgNamed;
@end


@interface SpecificUseListModel : JSONModel
@property (nonatomic,strong) NSString *addtime;
@property (nonatomic,strong) NSString *density;
@property (nonatomic,strong) NSString *direct;
@property (nonatomic,strong) NSString *gaplenght;
@property (nonatomic,strong) NSString *gaptype;
@property (nonatomic,strong) NSString *height;
@property (nonatomic,strong) NSString *id;
@property (nonatomic,strong) NSString *image;
@property (nonatomic,strong) NSString *name;
@property (nonatomic,strong) NSString *quantity;
@property (nonatomic,strong) NSString *seq;
@property (nonatomic,strong) NSString *speed;
@property (nonatomic,strong) NSString *width;
@end
