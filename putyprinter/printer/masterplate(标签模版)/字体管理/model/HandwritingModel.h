//
//  HandwritingModel.h
//  TianJinDL
//
//  Created by 王娜 on 2017/8/14.
//  Copyright © 2017年 troilamac. All rights reserved.
//

#import "JSONModelLib.h"

@interface HandwritingModel : JSONModel
@property(nonatomic,strong) NSString *addtime;
@property (nonatomic,strong) NSString *id;
@property (nonatomic,strong) NSString *name;
@property (nonatomic,strong) NSString *path;
@property (nonatomic,strong) NSString *seq;
@end
