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
            [self.parent.drawAreaView copySelectView];
            break;
        case 16:
            NSLog(@"多选");
            [self.parent openMunSelect];
            break;
        case 17:
            NSLog(@"锁定");
            [self lockLabel];
            break;
        case 18:
            NSLog(@"扫一扫");
            break;
            
        default:
            break;
    }
}

//锁定标签
-(void) lockLabel
{
    self.parent.CURRENT_LABEL_INFO.isLock=self.parent.CURRENT_LABEL_INFO.isLock?NO:YES;

    NSString *message=@"";
    if(self.parent.CURRENT_LABEL_INFO.isLock)
    {
        message=@"标签已锁定";
        self.lockImageView.image=[UIImage imageNamed:@"locking_button_n"];
    }
    else
    {
        message=@"标签已解锁";
        self.lockImageView.image=[UIImage imageNamed:@"not_locking_button_n"];
    }
    
    [self.parent showMessage:message];
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
    [nl setLabelInfowithFrom:1 withVC:self.parent];
    
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
        
        if(self.parent.CURRENT_LABEL_INFO.isLock)
        {
            self.lockImageView.image=[UIImage imageNamed:@"locking_button_n"];
        }
        else
        {
            self.lockImageView.image=[UIImage imageNamed:@"not_locking_button_n"];
        }
    }
    return self;
}

@end
