//
//  EFChangePageCell.h
//  EdictForm
//
//  Created by 韦超才 on 2017/8/12.
//  Copyright © 2017年 韦超才. All rights reserved.
//

#import <UIKit/UIKit.h>


#import "EFBaseCell.h"
@interface EFChangePageCell : EFBaseCell
{
    NSInteger _maxPage;
}

@property (nonatomic,assign)NSInteger maxPage; // 560 defult
@property (nonatomic,assign)NSInteger currentPage;
@property (nonatomic,copy)void(^changepageClosure)(NSInteger page);

@property (weak, nonatomic) IBOutlet UILabel *pageLable;
@property (weak, nonatomic) IBOutlet UIButton *startBtn;

@property (weak, nonatomic) IBOutlet UIButton *preBtn;

@property (weak, nonatomic) IBOutlet UIButton *nextBtn;

@property (weak, nonatomic) IBOutlet UIButton *endBtn;


@end
