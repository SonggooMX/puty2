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
#import <CoreBluetooth/CoreBluetooth.h>
#import <CoreBluetooth/CBService.h>

#pragma mark -蓝牙相关
static CBCentralManager *centralManager;
static CBPeripheral *peripheral;

static CBPeripheral *activeDevice;
static CBCharacteristic *activeWriteCharacteristic;
static CBCharacteristic *activeReadCharacteristic;

static NSString *const kWriteCharacteristicUUID = @"49535343-8841-43F4-A8D4-ECBE34729BB3";
static NSString *const kReadCharacteristicUUID = @"49535343-1E4D-4BD9-BA61-23C647249616";
static NSString *const kServiceUUID = @"49535343-FE7D-4AE5-8FA9-9FAFD205E455";

@interface NewLabelViewController : UIViewController

@property float LabelSacle;

@property drawArea *drawAreaView;
@property (weak, nonatomic) IBOutlet UIView *drawViewContent;
// 整个底部功能区
@property (weak, nonatomic) IBOutlet UIView *bottomview;

-(void)updateTip:(NSString*)msg;

-(void) reback;

- (IBAction)btnSwitchView:(id)sender;

#pragma mark -选中元素属性
-(void) setElementPropety:(int)type withSelect:(BOOL)isselected;
#pragma mark -设置顶部按钮
-(void) setTopIconButton;
#pragma mark -隐藏顶部按钮
-(void) setTopIconButtonHidden;

#pragma mark -获取打印的图片
-(UIImage*) getPrintImageView;

@end
