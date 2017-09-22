//
//  EdictBoxView.h
//  EdictForm
//
//  Created by 韦超才 on 2017/8/10.
//  Copyright © 2017年 韦超才. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface EdictBoxView : UIView


@property (weak, nonatomic) IBOutlet UILabel *xLable;

@property (weak, nonatomic) IBOutlet UILabel *yLable;


@property (weak, nonatomic) IBOutlet UILabel *widthLable;

@property (weak, nonatomic) IBOutlet UILabel *heightLable;


@property (weak, nonatomic) IBOutlet UIImageView *targetImage;

+ (instancetype)instance;

@end
