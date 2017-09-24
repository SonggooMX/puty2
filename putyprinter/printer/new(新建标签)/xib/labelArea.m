//
//  labelArea.m
//  printer
//
//  Created by songgoo on 2017/7/15.
//  Copyright © 2017年 puty. All rights reserved.
//

#import "labelArea.h"
#import "newLabel.h"
#import "TagTemplateController.h"

@implementation labelArea

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

- (IBAction)labelBtuClick:(UIButton *)sender {
    
    switch (sender.tag) {
        case 11:
            NSLog(@"新建");
            [self newlabel];
            break;
        case 12:
            NSLog(@"打开");
            [self openCloundTempeletes];
            break;
        case 13:
            NSLog(@"保存");
            break;
        case 14:
            NSLog(@"另存为");
            break;
        case 15:
            NSLog(@"拷贝");
            break;
        case 16:
            NSLog(@"多选");
            break;
        case 17:
            NSLog(@"锁定");
            break;
        case 18:
            NSLog(@"扫一扫");
            break;
            
        default:
            break;
    }
}

//打开云端模板
- (void) openCloundTempeletes
{
    TagTemplateController *vc = [[TagTemplateController alloc] init];
    [self.parent.navigationController pushViewController:vc animated:YES];
}

//创建新标签
- (void) newlabel
{
    //新增界面
    CGRect rect=[UIScreen mainScreen].bounds;
    newLabel *nl=[[newLabel alloc] initWithFrame:CGRectMake(0, 0, rect.size.width, 284)];
    nl.fromType=1;//来源
    nl.parent=self.parent;
    [self.parent.bottomview addSubview:nl]; //添加
    [self.parent setTopIconButtonHidden];
}

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        NSArray *views=[[NSBundle mainBundle] loadNibNamed:@"labelArea" owner:self options:nil];
        self.contentView=[views objectAtIndex:0];
        self.contentView.frame=frame;
        [self addSubview:self.contentView];
    }
    return self;
}

@end
