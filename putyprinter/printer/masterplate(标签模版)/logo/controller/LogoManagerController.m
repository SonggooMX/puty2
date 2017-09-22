
//
//  LogoManagerController.m
//  TianJinDL
//
//  Created by 王娜 on 2017/8/14.
//  Copyright © 2017年 troilamac. All rights reserved.
//

#import "LogoManagerController.h"
#import "LogoTypeModel.h"
#import "LogoImageModel.h"
#import "LeftTableCell.h"
#import "RightTableCell.h"
#import "TianJinDLConfig.h"
#import "NetworkManager.h"
@interface LogoManagerController ()<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic,strong) NSMutableArray *flagArray;
@end

@implementation LogoManagerController
{
    NSMutableArray *leftData;
    NSMutableArray *rightData;
    NSMutableArray *imageArr;
    UITableView *leftTable;
    UITableView *rightTable;
    UIView *view;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"LOGO管理";
    [self setNav];
    [self getData];
    [self setMain];
    
}
-(void)setNav{
    //返回键
    UIButton *btn = [[UIButton alloc]initWithFrame:CGRectMake(0, 0, 25, 25)];
    [btn setImage:[UIImage imageNamed:@"back_button_white"] forState:UIControlStateNormal];
    [btn addTarget:self action:@selector(back) forControlEvents:UIControlEventTouchUpInside];
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc]initWithCustomView:btn];
}
-(void)setMain{
    leftTable = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, 130, SCREEN_HEIGHT-64) style:UITableViewStyleGrouped];
    leftTable.dataSource = self;
    leftTable.delegate = self;
    [self.view addSubview:leftTable];
    [leftTable registerClass:[LeftTableCell class] forCellReuseIdentifier:@"leftcell"];
    UIView *line = [[UIView alloc]initWithFrame:CGRectMake(130, 0, 0.3, SCREEN_HEIGHT-64)];
    line.backgroundColor = [UIColor lightGrayColor];
    [self.view addSubview:line];
    rightTable = [[UITableView alloc]initWithFrame:CGRectMake(130.3, 0, SCREEN_WIDTH-130.3, SCREEN_HEIGHT-64) style:UITableViewStyleGrouped ];
    rightTable.delegate = self;
    rightTable.dataSource =self;
    [rightTable registerClass:[RightTableCell class] forCellReuseIdentifier:@"rightcell"];
    [self.view addSubview:rightTable];
    
}
-(void)back{
    [self.navigationController popViewControllerAnimated:YES];
}
#pragma mark -- UITableView 
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (tableView==leftTable) {
        NSArray *arr = rightData[section];
        return arr.count;
    }
    NSLog(@"imgarr.count = %@",imageArr);
    return imageArr.count;
}
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    if (tableView == leftTable) {
      return leftData.count;
    }
      return 1;

}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (tableView==leftTable) {
        LeftTableCell *cell = [tableView dequeueReusableCellWithIdentifier:@"leftcell"];
        [cell resetData:rightData[indexPath.section][indexPath.row]];
        return cell;
    }
    RightTableCell *rcell = [tableView dequeueReusableCellWithIdentifier:@"rightcell"];
    [rcell resetData:imageArr[indexPath.row]];
    return rcell;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (tableView==leftTable) {
        if ([_flagArray[indexPath.section] isEqualToString:@"0"]) {
            return 0;
        }else{
            return 44.0;
        }
    }
    return 90;
  
}
-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    if (tableView == leftTable) {
        LogoTypeModel *model = leftData[section];
        view = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 130, 44)];
        view.backgroundColor = [UIColor whiteColor];
        UIImageView *img = [[UIImageView alloc]initWithFrame:CGRectMake(20, 15, 14, 14)];
        img.image = [UIImage imageNamed:model.imgNamed];
        UILabel *lab = [[UILabel alloc]initWithFrame:CGRectMake(50, 0, 90, 44)];
        lab.text = model.name;
        [lab setFont:[UIFont systemFontOfSize:14]];
        [view addSubview:img];
        [view addSubview:lab];
        view.tag = 100 + section;
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(sectionClick:)];
        [view addGestureRecognizer:tap];

        return view;

    }
    return nil;
   }
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    if (tableView == leftTable) {
        return 44.0;
    }
    return CGFLOAT_MIN;
    
}
-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 1.0;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if (tableView == leftTable) {
        [self httpRequest:indexPath];
    }
}
#pragma mark ---Click
-(void)sectionClick:(UITapGestureRecognizer *)tap{
    int index = tap.view.tag % 100;
    LogoTypeModel *model = leftData[index];
    NSMutableArray *indexArray = [[NSMutableArray alloc]init];
    NSArray *arr = rightData[index];
    for (int i = 0; i < arr.count; i ++) {
        NSIndexPath *path = [NSIndexPath indexPathForRow:i inSection:index];
        [indexArray addObject:path];
    }
    //展开
    if ([_flagArray[index] isEqualToString:@"0"]) {
        _flagArray[index] = @"1";
         model.imgNamed = @"subtraction";
        [leftTable reloadData];
        [leftTable reloadRowsAtIndexPaths:indexArray withRowAnimation:UITableViewRowAnimationBottom];  //使用下面注释的方法就 注释掉这一句
        //默认选中第一行
        NSIndexPath *ip=[NSIndexPath indexPathForRow:0 inSection:index];
        imageArr = [[NSMutableArray alloc]init];
        LogoTypeListModel *model = rightData[index][0];
        imageArr = model.imgArr;
        [rightTable reloadData];
        [leftTable selectRowAtIndexPath:ip animated:YES scrollPosition:UITableViewScrollPositionBottom];
   
    } else { //收起
        _flagArray[index] = @"0";
         model.imgNamed = @"Add_key_black";
        [leftTable reloadData];
        [leftTable reloadRowsAtIndexPaths:indexArray withRowAnimation:UITableViewRowAnimationTop]; //使用下面注释的方法就 注释掉这一句
        
    }
}
#pragma mark -- Data
-(void)getData{
    leftData = [[NSMutableArray alloc]init];
    rightData = [[NSMutableArray alloc]init];
    _flagArray = [[NSMutableArray alloc]init];
    [[NetworkManager sharedInstance] HttpRequestWithType:@"GET" withURLString:@"http://119.23.125.153:8000/puty/api.ashx?Action=getLogoTypes" withParaments:nil progress:nil withCompleteBlock:^(NSError *error, id data) {
        for(NSDictionary *dic in [data objectForKey:@"rows"]){
            LogoTypeModel *model = [[LogoTypeModel alloc]initWithDictionary:dic error:nil];
            model.imgNamed = @"Add_key_black";
            NSLog(@"左边的数据 = %@",model);
            [leftData addObject:model];
            [_flagArray addObject:@"0"];
            NSMutableArray *detailData = [[NSMutableArray alloc]init];
            for(NSDictionary *dic in model.list){
                LogoTypeListModel *listmodel = [[LogoTypeListModel alloc]initWithDictionary:dic error:nil];
                [detailData addObject:listmodel];
                NSLog(@"右边的数据 = %@",listmodel);
                
                /*-----------------------------------------------------*/
                
                NSString *url =[NSString stringWithFormat:@"http://119.23.125.153:8000/puty/api.ashx?action=getLogos&id=%@",listmodel.id];
                [[NetworkManager sharedInstance] HttpRequestWithType:@"GET" withURLString:url withParaments:nil progress:nil withCompleteBlock:^(NSError *error, id data) {
                    listmodel.imgArr = [NSMutableArray array];
                    for(NSDictionary *dic in [data objectForKey:@"rows"]){
                        LogoImageModel *imgmodel = [[LogoImageModel alloc]initWithDictionary:dic error:nil];
                        [listmodel.imgArr addObject:imgmodel];
                        
                    }
                    
                }];
                
            }
            [rightData addObject:detailData];
        }
        [leftTable reloadData];
        
    }];
}
-(void)httpRequest:(NSIndexPath*)indexpath{
    imageArr = [[NSMutableArray alloc]init];
    LogoTypeListModel *model = rightData[indexpath.section][indexpath.row];
    imageArr = model.imgArr;
    [rightTable reloadData];
}


@end
