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
        if([self.titleLable.text isEqualToString:@"标签宽度"])
        {
            float ft=walert.textFields.firstObject.text.floatValue;
            if(ft<=0.0f)
            {
                [self showMessage:@"标签宽度必须大于0"];
                return;
            }
            self.subTitleLable.text = [[NSString stringWithFormat:@"%.2f",walert.textFields.firstObject.text.floatValue] stringByAppendingFormat:@"mm"];
            //刷新标签
            [self.nl refresh:walert.textFields.firstObject.text withHeight:[NSString stringWithFormat:@"%.2f",self.nl.labelHeight]];
            return;
        }
        if([self.titleLable.text isEqualToString:@"标签高度"])
        {
            float ft=walert.textFields.firstObject.text.floatValue;
            if(ft<=0.0f)
            {
                [self showMessage:@"标签高度必须大于0"];
                return;
            }
            self.subTitleLable.text = [[NSString stringWithFormat:@"%.2f",walert.textFields.firstObject.text.floatValue] stringByAppendingFormat:@"mm"];
            //刷新标签
            [self.nl refresh:[NSString stringWithFormat:@"%.2f",self.nl.labelWidth] withHeight:walert.textFields.firstObject.text];
            return;
        }
        self.subTitleLable.text=walert.textFields.firstObject.text;
        //刷新数据
        CGRect rect=self.bv.frame;
        [self.bv initView:rect withImage:nil withNString:self.subTitleLable.text];
    }];
    UIAlertAction *action1 = [UIAlertAction actionWithTitle:@"取消" style:(UIAlertActionStyleDefault) handler:^(UIAlertAction * _Nonnull action) {}];
    
    [alert addAction:action1];
    [alert addAction:action];
    //多行
    if(!withMus)
    {
        [alert addTextFieldWithConfigurationHandler:^(UITextField * _Nonnull textField) {
            NSString *vl=self.subTitleLable.text;
            if([self.titleLable.text isEqualToString:@"标签宽度"]
               ||[self.titleLable.text isEqualToString:@"标签高度"])
            {
                vl=[vl stringByReplacingOccurrencesOfString:@"mm" withString:@""];
            }
            
            textField.text = vl;
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

-(void) showMessage:(NSString*)msg
{
    UIAlertController *uvc=[UIAlertController alertControllerWithTitle:@"提示" message:msg preferredStyle:(UIAlertControllerStyleAlert)];
    UIAlertAction *a1=[UIAlertAction actionWithTitle:@"确定" style:(UIAlertActionStyleDefault) handler:^(UIAlertAction * _Nonnull action) {
         self.showPickView([self alert:false]);
    }];
    [uvc addAction:a1];
    self.showPickView(uvc);
}


@end
