//
//  MessageModel.h
//  TianJinDL
//
//  Created by apple on 17/8/15.
//  Copyright © 2017年 troilamac. All rights reserved.
//

#import "JSONModelLib.h"

@interface MessageModel : JSONModel
@property (nonatomic,assign)NSNumber* error;
@property (nonatomic,strong)NSString *msg;
@property (nonatomic,strong)NSString *username;
@property (nonatomic,strong)NSString *password;
@property (nonatomic,assign) BOOL autoLogin;
@end
