//
//  EFMuiltiBtnModle.m
//  EdictForm
//
//  Created by 韦超才 on 2017/8/12.
//  Copyright © 2017年 韦超才. All rights reserved.
//

#import "EFMuiltiBtnModle.h"
#import "EFMuiltiButtonCell.h"
#import "lbView.h"

@implementation EFMuiltiBtnModle


+ (NSString *)cellId
{
    return NSStringFromClass([EFMuiltiButtonCell class]);
}

- (ButtonModle *)currentModle
{
    return self.itemStrs[self.currentindex];
}

- (void)setupWithCell:(EFBaseCell *)cell withBaseView:(baseView*)bview withNewLabel:(newLabel *)linfo
{
    EFMuiltiButtonCell *rcell = (EFMuiltiButtonCell*)cell;
    rcell.selectedAction = ^(NSInteger result) {
        self.currentindex = result;
        if (self.selectedAction) {
            self.selectedAction(result);
        }
        if([self.title isEqualToString:@"打印方向"])
        {
            linfo.printDirect=(int)result;
        }
        else if([self.title isEqualToString:@"纸张类型"])
        {
            linfo.pagetType=(int)result;
        }
        else if([self.title isEqualToString:@"对齐方式"])
        {
            lbView *lb=(lbView*)bview;
            lb.alignMode=(int)result;
            [lb setLineSpace:lb.rowSpaceHeight withMode:lb.rowSpaceMode];
        }
        else if([self.title isEqualToString:@"行间距"])
        {
            int mode=(int)result;
            
            lbView *lb=(lbView*)bview;
            
            float space=1.0f;
            switch ((int)result) {
                case 0:
                    space=1.0f;
                    break;
                case 1:
                    space=1.2f;
                    break;
                case 2:
                    space=1.5f;
                    break;
                default:
                    //自定义行高 弹出提示框
                    [self showRowSpaceHeight:lb withCell:rcell];
                    return;
            }
            
            [lb setLineSpace:space withMode:mode];
        }
    };
    rcell.itemStrs = self.itemStrs;
    rcell.titleLable.text = self.title;
    rcell.currentindex = self.currentindex;
}

-(void) showRowSpaceHeight:(lbView*)lb withCell:(EFMuiltiButtonCell*)cell
{
    UIAlertController *uvc=[UIAlertController alertControllerWithTitle:@"提示" message:@"请输入自定义行高" preferredStyle:UIAlertControllerStyleAlert];
    
    UIAlertAction *ok = [UIAlertAction actionWithTitle:@"确定" style:(UIAlertActionStyleDefault) handler:^(UIAlertAction * _Nonnull action) {
        //设置行高
        float rh=uvc.textFields.firstObject.text.floatValue;
        [lb setLineSpace:rh withMode:3];
        ((UIButton*)cell.muiltiBtnView.buttons[3]).titleLabel.text=[NSString stringWithFormat:@"%.2f",rh];
    }];
    UIAlertAction *cancel = [UIAlertAction actionWithTitle:@"取消" style:(UIAlertActionStyleDefault) handler:^(UIAlertAction * _Nonnull action) {
        
    }];
    
    [uvc addTextFieldWithConfigurationHandler:^(UITextField * _Nonnull textField) {
        textField.text = [NSString stringWithFormat:@"%.2f",lb.rowSpaceHeight];
    }];
    
    [uvc addAction:cancel];
    [uvc addAction:ok];
    
    [self.parent presentViewController:uvc animated:true completion:nil];
}

@end
