//
//  EFPickCell.m
//  EdictForm
//
//  Created by 韦超才 on 2017/8/12.
//  Copyright © 2017年 韦超才. All rights reserved.
//

#import "EFPickCell.h"

@implementation EFPickCell

- (void)awakeFromNib {
    [super awakeFromNib];
    
}


- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    if (self.showPickView) {
        self.showPickView([self alert:false]);
    }
}

- (UIAlertController *)alert:(BOOL)withMus
{
    UIAlertController *alert  = [UIAlertController alertControllerWithTitle:[NSString stringWithFormat:@"%@",self.titleLable.text] message:[NSString stringWithFormat:@"请输入%@",self.titleLable.text] preferredStyle:(UIAlertControllerStyleAlert)];
    __weak typeof(alert)walert = alert;
    UIAlertAction *action = [UIAlertAction actionWithTitle:@"确定" style:(UIAlertActionStyleDefault) handler:^(UIAlertAction * _Nonnull action) {
        self.subTitleLable.text = walert.textFields.firstObject.text;
        //刷新数据
        CGRect rect=self.bv.frame;
        [self.bv initView:rect withImage:nil withNString:self.subTitleLable.text];
    }];
    UIAlertAction *action1 = [UIAlertAction actionWithTitle:@"取消" style:(UIAlertActionStyleDefault) handler:^(UIAlertAction * _Nonnull action) {}];
    
    [alert addAction:action1];
    [alert addAction:action];
    if(!withMus)
    {
        [alert addTextFieldWithConfigurationHandler:^(UITextField * _Nonnull textField) {
            textField.text = self.subTitleLable.text;
        }];
    }
    else
    {
        UITextView *uv=[[UITextView alloc] init];
        uv.text=self.subTitleLable.text;
        [alert.view addSubview:uv];
    }
    return alert;
}


@end
