//
//  NewLabelViewController.h
//  printer
//
//  Created by songgoo on 2017/7/13.
//  Copyright © 2017年 puty. All rights reserved.
//


#import "drawArea.h"
#import <UIKit/UIKit.h>
#import "PrintViewController.h"
#import "HomeBottomViewController.h"
#import "LabelInfo.h"

@interface NewLabelViewController : UIViewController


@property HomeBottomViewController *parent;
//标签信息
@property LabelInfo *CURRENT_LABEL_INFO;

@property float LabelSacle;

@property drawArea *drawAreaView;

//开启多选模式
@property int munSelectMode;

@property (weak, nonatomic) IBOutlet UIView *drawViewContent;
// 整个底部功能区
@property (weak, nonatomic) IBOutlet UIView *bottomview;


-(void)updateTip:(NSString*)msg;

-(void) reback;

- (IBAction)btnSwitchView:(id)sender;

#pragma mark -选中元素属性
-(void) setElementPropety:(int)type withSelect:(BOOL)isselected withElement:(UIView*)view;
#pragma mark -设置顶部按钮
-(void) setTopIconButton;
#pragma mark -隐藏顶部按钮
-(void) setTopIconButtonHidden;

#pragma mark -获取打印的图片
-(UIImage*) getPrintImageView;
#pragma mark - 开启多选模式
-(void) openMunSelect;
-(void) showMessage:(NSString*)message;

@end
