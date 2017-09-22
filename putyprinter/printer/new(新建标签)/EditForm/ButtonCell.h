//
//  ButtonCell.h
//  EdictForm
//
//  Created by 韦超才 on 2017/8/12.
//  Copyright © 2017年 韦超才. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ButtonCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIButton *firBtn;
@property (weak, nonatomic) IBOutlet UIButton *secBtn;

@property (nonatomic,strong)NSArray *titles;

@end
