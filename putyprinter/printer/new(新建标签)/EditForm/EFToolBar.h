//
//  EFToolBar.h
//  EdictForm
//
//  Created by 韦超才 on 2017/8/10.
//  Copyright © 2017年 韦超才. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface EFToolBar : UIView
@property (weak, nonatomic) IBOutlet UIButton *firItem;
@property (weak, nonatomic) IBOutlet UIButton *secItem;
@property (weak, nonatomic) IBOutlet UIButton *thrItem;
@property (weak, nonatomic) IBOutlet UIButton *forItem;

@property (nonatomic,copy)void(^selectedAction)(NSInteger);
@property (nonatomic,assign)NSInteger currentIndex;

+ (instancetype)instance;

@end
