//
//  HomeBottomViewController.h
//  printer
//
//  Created by songgoo on 2017/7/12.
//  Copyright © 2017年 puty. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreBluetooth/CoreBluetooth.h>
#import <CoreBluetooth/CBService.h>


static NSString *const kWriteCharacteristicUUID = @"49535343-8841-43F4-A8D4-ECBE34729BB3";
static NSString *const kReadCharacteristicUUID = @"49535343-1E4D-4BD9-BA61-23C647249616";
static NSString *const kServiceUUID = @"49535343-FE7D-4AE5-8FA9-9FAFD205E455";

@interface HomeBottomViewController : UIViewController

@property CBCentralManager *centralManager;
@property CBPeripheral *activeDevice;
@property CBCharacteristic *activeWriteCharacteristic;
@property CBCharacteristic *activeReadCharacteristic;

@property NSMutableArray *deviceList;
@property UITableView *deviceListTableView;

//当前选择的打印机
@property (weak, nonatomic) IBOutlet UILabel *currentSelectPrinter;

-(void) alertMessage:(NSString *)msg;

@end
