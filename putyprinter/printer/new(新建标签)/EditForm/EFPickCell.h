//
//  EFPickCell.h
//  EdictForm
//
//  Created by 韦超才 on 2017/8/12.
//  Copyright © 2017年 韦超才. All rights reserved.
//

#import <UIKit/UIKit.h>


#import "EFBaseCell.h"
@interface EFPickCell : EFBaseCell

@property (weak, nonatomic) IBOutlet UILabel *titleLable;

@property (weak, nonatomic) IBOutlet UILabel *subTitleLable;


@property (nonatomic,copy)void(^showPickView)(UIAlertController *alert);

@end
