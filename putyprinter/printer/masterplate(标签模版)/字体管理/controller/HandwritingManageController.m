
//
//  HandwritingManageController.m
//  TianJinDL
//
//  Created by apple on 17/8/13.
//  Copyright © 2017年 troilamac. All rights reserved.
//

#import "HandwritingManageController.h"
#import "HandwritingModel.h"
#import "HandwritingCell.h"
#import "MCDownloadManager.h"
#import "MCWiFiManager.h"
#import "NetworkManager.h"
#import "TianJinDLConfig.h"
@interface HandwritingManageController ()<UITableViewDelegate,UITableViewDataSource,HandwritingCellDelegate>
@property (nonatomic,weak) UIButton *selectedBtn;
@end

@implementation HandwritingManageController
{
    NSMutableArray *dataArr;
    UITableView *handtable;
}
-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:YES];
    [handtable reloadData];
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"字体管理";
    [self setNav];
    [self getData];
    [self setMain];
    MCWiFiManager *wifiManager = [[MCWiFiManager alloc]init];
    [wifiManager scanNetworksWithCompletionHandler:^(NSArray<MCWiFi *> * _Nullable networks, MCWiFi * _Nullable currentWiFi, NSError * _Nullable error) {
        NSLog(@"name = %@,mac = %@",currentWiFi.wifiName,currentWiFi.wifiBSSID);
    }];
    NSLog(@"网关:%@",[wifiManager getGatewayIpForCurrentWiFi]);

}
-(void)getData{
    dataArr = [[NSMutableArray alloc]init];
    [[NetworkManager sharedInstance] HttpRequestWithType:@"GET" withURLString:@"http://119.23.125.153:8000/puty/api.ashx?action=getfonts" withParaments:nil progress:nil withCompleteBlock:^(NSError *error, id data) {
        
        for (NSDictionary *dic in [data objectForKey:@"rows"]) {
            HandwritingModel *model = [[HandwritingModel alloc]initWithDictionary:dic error:nil];
            [dataArr addObject:model];
            NSLog(@"handwritingmodel = %@",model);
        }
        [handtable reloadData];
        
    }];
}
-(void)setNav{
    //返回键
    UIButton *btn = [[UIButton alloc]initWithFrame:CGRectMake(0, 0, 25, 25)];
    [btn setImage:[UIImage imageNamed:@"back_button_white"] forState:UIControlStateNormal];
    [btn addTarget:self action:@selector(back) forControlEvents:UIControlEventTouchUpInside];
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc]initWithCustomView:btn];
}
-(void)setMain{
    handtable = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT-64) style:UITableViewStyleGrouped];
    handtable.dataSource = self;
    handtable.delegate =self;
    [self.view addSubview:handtable];
}
-(void)back{
    [self.navigationController popViewControllerAnimated:YES];
}
#pragma mark -- UITableView
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return dataArr.count;
}
-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    HandwritingCell *cell;
    if (cell==nil) {
        cell = [[NSBundle mainBundle] loadNibNamed:@"HandWritingCell" owner:self options:nil].firstObject;
    }
    cell.delegate = self;
    HandwritingModel *model = dataArr[indexPath.row];
    [cell resetModel:model];
 
    cell.url =[NSString stringWithFormat:@"http://119.23.125.153:8000/puty/%@",model.path];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    return cell;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 44.0;
}
-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return CGFLOAT_MIN;
}
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return CGFLOAT_MIN;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
}
- (void)cell:(HandwritingCell *)cell didClickedBtn:(UIButton *)btn {
    if (_selectedBtn!=btn) {
        self.selectedBtn.selected = NO;
        self.selectedBtn = btn;
    }
    btn.selected = YES;
}
@end
