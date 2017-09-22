//
//  BaseEdictFormViewController.h
//  EdictForm
//
//  Created by 韦超才 on 2017/8/10.
//  Copyright © 2017年 韦超才. All rights reserved.
//

#import <UIKit/UIKit.h>


typedef NS_ENUM(NSUInteger, BaseEdictFormType) {
    BaseEdictFormTypeBarCode = 0,
    BaseEdictFormTypeQRCode,
    BaseEdictFormTypeImage,
    BaseEdictFormTypeForm,
    BaseEdictFormTypeLine,
    BaseEdictFormTypeRectangle,
    BaseEdictFormTypeLogo,
    BaseEdictFormTypeLable
};


#import "EFResultModle.h"

@interface BaseEdictFormViewController : UIViewController

@property (nonatomic,assign)BaseEdictFormType type; // 必须设置

@property (weak, nonatomic) IBOutlet UITableView *tableView;


@property (nonatomic,copy)void(^resultClosure)(EFResultModle *result);

@end
