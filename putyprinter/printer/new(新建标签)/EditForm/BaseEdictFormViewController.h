//
//  BaseEdictFormViewController.h
//  EdictForm
//
//  Created by 韦超才 on 2017/8/10.
//  Copyright © 2017年 韦超才. All rights reserved.
//

#import <UIKit/UIKit.h>


typedef NS_ENUM(NSUInteger, BaseEdictFormType) {
    BaseEdictFormTypeBarCode = 0,//一维码 0
    BaseEdictFormTypeQRCode,//二维码 1
    BaseEdictFormTypeImage,//图片 2
    BaseEdictFormTypeForm,//表格 3
    BaseEdictFormTypeLine,//线 4
    BaseEdictFormTypeRectangle,//框 5
    BaseEdictFormTypeLogo,//logo 6
    BaseEdictFormTypeLable, //标签属性 7
    BaseEdictFormTypeTxt //文本属性 8
};


#import "EFResultModle.h"
#import "baseView.h"

@interface BaseEdictFormViewController : UIViewController

@property (nonatomic,assign)BaseEdictFormType type; // 必须设置

@property (weak, nonatomic) IBOutlet UITableView *tableView;

//当前选中的元素
@property UIView *currentSelectView;

@property (nonatomic,copy)void(^resultClosure)(EFResultModle *result);

@end
