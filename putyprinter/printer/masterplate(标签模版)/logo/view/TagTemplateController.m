
//
//  TagTemplateController.m
//  TianJinDL
//
//  Created by 王娜 on 2017/8/14.
//  Copyright © 2017年 troilamac. All rights reserved.
//

#import "TagTemplateController.h"
#import "TagLeftCell.h"
#import "SpecificUseLoginController.h"
#import "YunTempleteModel.h"
#import "SpecificUseModel.h"
#import "TagRightCell.h"
#import "NetworkManager.h"
#import "TianJinDLConfig.h"
#import "MeLoginTool.h"
#import "UIColor+ColorChange.h"
@interface TagTemplateController ()<UITableViewDelegate,UITableViewDataSource>

@end

@implementation TagTemplateController
{
    UITableView *leftTable;
    UITableView *localTable;//本地模版
    UITableView *rightTable;//云模版
    UITableView *specificTable;//专用模版
    NSMutableArray *yunArr;
    NSMutableArray *specificArr;
    NSMutableArray *headArr;
    NSMutableArray *flagArr;
}
-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:YES];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(InfoNotificationAction:) name:@"info" object:nil];
    
   }
// 2.实现收到通知触发的方法

- (void)InfoNotificationAction:(NSNotification *)notification{
    self.uid = [notification.userInfo objectForKey:@"uid"];
    self.checkcode = [notification.userInfo objectForKey:@"checkcode"];
    NSLog(@"%@",notification.userInfo);
    specificArr = [[NSMutableArray alloc]init];
    headArr = [[NSMutableArray alloc]init];
    flagArr = [[NSMutableArray alloc]init];
    NSLog(@"---接收到通知---");
    [[NetworkManager sharedInstance] HttpRequestWithType:@"GET" withURLString:[NSString stringWithFormat:@"http://119.23.125.153:8000/puty/api.ashx?action=getmytempletes&uid=%@&checkcode=%@",self.uid,self.checkcode] withParaments:nil progress:nil withCompleteBlock:^(NSError *error, id data) {
        NSLog(@"专用模版返回的数据 = %@",data);
        for(NSDictionary *dic in [data objectForKey:@"rows"]){
            SpecificUseModel *model = [[SpecificUseModel alloc]initWithDictionary:dic error:nil];
            model.imgNamed = @"spread_button";
            [headArr addObject:model];
            [flagArr addObject:@"0"];
            NSMutableArray *arr = [[NSMutableArray alloc]init];
            for(NSDictionary *dic in model.list){
                SpecificUseListModel *listmodel = [[SpecificUseListModel alloc]initWithDictionary:dic error:nil];
                [arr addObject:listmodel];
                
            }
            [specificArr addObject:arr];
        }
        //默认选中第一行
        NSIndexPath *ip=[NSIndexPath indexPathForRow:2 inSection:0];
        [leftTable selectRowAtIndexPath:ip animated:YES scrollPosition:UITableViewScrollPositionBottom];
        [rightTable removeFromSuperview];
        [localTable removeFromSuperview];
        [self.view addSubview:specificTable];
        [specificTable reloadData];
    }];

    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"标签模版";
    [self setNav];
    [self setSearchBar];
    [self setMain];
}
-(void)setNav{
    //返回键
    UIButton *btn = [[UIButton alloc]initWithFrame:CGRectMake(0, 0, 25, 25)];
    [btn setImage:[UIImage imageNamed:@"back_button_white"] forState:UIControlStateNormal];
    [btn addTarget:self action:@selector(back) forControlEvents:UIControlEventTouchUpInside];
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc]initWithCustomView:btn];
}
-(void)setSearchBar{
    UIView *view = [[UIView alloc]initWithFrame:CGRectMake(28, 7, SCREEN_WIDTH-100, 30)];
    view.layer.borderColor = ([UIColor lightGrayColor].CGColor);
    view.layer.borderWidth = 0.5;
    view.layer.cornerRadius = 5;
    [self.view addSubview:view];
    UIButton *confirm = [[UIButton alloc]initWithFrame:CGRectMake(SCREEN_WIDTH-56,7, 40, 30)];
    [confirm setTitle:@"确定" forState:UIControlStateNormal];
    [confirm setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [confirm.titleLabel setFont:[UIFont fontWithName:@"SourceHanSansCN-Normal" size:16]];
    [self.view addSubview:confirm];
    [confirm addTarget:self action:@selector(confimSearch) forControlEvents:UIControlEventTouchUpInside];
    UIImageView *img = [[UIImageView alloc]initWithFrame:CGRectMake(5, 7.5, 15, 15)];
    img.image  = [UIImage imageNamed:@"search_icon_grey"];
    [view addSubview:img];
    UIButton *code = [[UIButton alloc]initWithFrame:CGRectMake(view.frame.size.width-21, 7.5, 15, 15)];
    [code setBackgroundImage:[UIImage imageNamed:@"scan_grey_icon"] forState:UIControlStateNormal];
    [view addSubview:code];
    [code addTarget:self action:@selector(erWeiMa) forControlEvents:UIControlEventTouchUpInside];
    UITextField *search = [[UITextField alloc]initWithFrame:CGRectMake(25, 8, view.frame.size.width-50, 16)];
    search.placeholder = @"标签名称、标签尺寸";
    [search setValue:[UIFont boldSystemFontOfSize:14] forKeyPath:@"_placeholderLabel.font"];
    [view addSubview:search];
}
-(void)setMain{
    
    yunArr = [[NSMutableArray alloc]init];
    
    leftTable = [[UITableView alloc]initWithFrame:CGRectMake(0, 44, 130, SCREEN_HEIGHT-108) style:UITableViewStyleGrouped];
    leftTable.delegate = self;
    leftTable.dataSource = self;
    [self.view addSubview:leftTable];
    [leftTable registerClass:[TagLeftCell class] forCellReuseIdentifier:@"leftcell"];
    UIView *line = [[UIView alloc]initWithFrame:CGRectMake(130, 44, 0.3, SCREEN_HEIGHT-108)];
    line.backgroundColor = [UIColor lightGrayColor];
    [self.view addSubview:line];
    
    localTable = [[UITableView alloc]initWithFrame:CGRectMake(130.3, 44, SCREEN_WIDTH-130.3, SCREEN_HEIGHT-108) style:UITableViewStyleGrouped];
    localTable.delegate = self;
    localTable.dataSource = self;
    [localTable registerClass:[TagRightCell class] forCellReuseIdentifier:@"localcell"];
    [self.view addSubview:localTable];

    
    rightTable = [[UITableView alloc]initWithFrame:CGRectMake(130.3, 44, SCREEN_WIDTH-130.3, SCREEN_HEIGHT-108) style:UITableViewStyleGrouped];
    rightTable.delegate = self;
    rightTable.dataSource = self;
    [rightTable registerClass:[TagRightCell class] forCellReuseIdentifier:@"rightcell"];

    
    
    specificTable = [[UITableView alloc]initWithFrame:CGRectMake(130.3, 44, SCREEN_WIDTH-130.3, SCREEN_HEIGHT-108) style:UITableViewStyleGrouped];
    specificTable.delegate = self;
    specificTable.dataSource = self;
    [specificTable registerClass:[TagRightCell class] forCellReuseIdentifier:@"specificcell"];
   

    
}
#pragma mark -- Click
-(void)back{
    [self.navigationController popViewControllerAnimated:YES];
}
-(void)confimSearch{
    //
}
-(void)erWeiMa{
    
    
}
#pragma mark -- UITableView
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    if (tableView == specificTable) {
        return specificArr.count;
    }
    return 1;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if (tableView == specificTable) {
        NSArray *arr = specificArr[section];
        return  arr.count;
    }
    if (tableView==rightTable) {
        return yunArr.count;
    }
        return 3;
   
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (tableView == leftTable) {
        TagLeftCell *cell = [tableView dequeueReusableCellWithIdentifier:@"leftcell"];
        NSArray *titleArr = @[@"本地模版",@"云模版",@"专用模版"];
        [cell setData:titleArr[indexPath.row]];
        //默认选中第一行
        NSIndexPath *ip=[NSIndexPath indexPathForRow:0 inSection:0];
        [leftTable selectRowAtIndexPath:ip animated:YES scrollPosition:UITableViewScrollPositionBottom];
        return cell;
    }
    if (tableView == specificTable) {
        TagRightCell *specificcell = [tableView dequeueReusableCellWithIdentifier:@"specificcell"];
        specificcell.delete.hidden = YES;
        specificcell.share.hidden = YES;
        SpecificUseListModel *model = specificArr[indexPath.section][indexPath.row];
        [specificcell setSpecificData:model];
        specificcell.clipsToBounds = YES;
        specificcell.backgroundColor = [UIColor colorWithHexString:@"efeff4"];
        return specificcell;
    }
    if (tableView == rightTable) {
        TagRightCell *rightcell= [tableView dequeueReusableCellWithIdentifier:@"rightcell"];
        YunTempleteModel *yun = yunArr[indexPath.row];
        [rightcell setYunData:yun];
        return rightcell;
    }
   //本地模版
    TagRightCell *localcell= [tableView dequeueReusableCellWithIdentifier:@"localcell"];
    return localcell;
    
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (tableView == leftTable) {
         return 44;
    }
    if (tableView == specificTable) {
        if ([flagArr[indexPath.section] isEqualToString:@"0"]) {
            return 0;
        }else{
            return 96;
        }
    }
    return 96;
   
}
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    if (tableView == specificTable) {
        return 40;
    }
    return CGFLOAT_MIN;
}
-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return CGFLOAT_MIN;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
   
    if (tableView == leftTable) {
        if (indexPath.row == 0) {
            //本地模版
                [specificTable removeFromSuperview];
                [rightTable removeFromSuperview];
                [self.view addSubview:localTable];
           
            [rightTable reloadData];
        }
        if (indexPath.row == 1) {
            //获取云模版
            [specificTable removeFromSuperview];
            [localTable removeFromSuperview];
            [self.view addSubview:rightTable];
            if (yunArr.count == 0) {
                [[NetworkManager sharedInstance] HttpRequestWithType:@"GET" withURLString:@"http://119.23.125.153:8000/puty/api.ashx?Action=getctempletes" withParaments:nil progress:nil withCompleteBlock:^(NSError *error, id data) {
                    NSLog(@"云模版返回的数据＝ %@",data);
                    for(NSDictionary *dic in [data objectForKey:@"rows"]){
                        YunTempleteModel *model = [[YunTempleteModel alloc]initWithDictionary:dic error:nil];
                        [yunArr addObject:model];
                    }
                     [rightTable reloadData];
                }];
                
            }
            [rightTable reloadData];
        }
        if (indexPath.row == 2) {
            //专用模版
            if ([MeLoginTool isLogin]) {
                [rightTable removeFromSuperview];
                [localTable removeFromSuperview];
                [self.view addSubview:specificTable];
                NSString *uid = [MeLoginTool getUserName];
                NSString *checkcode = [MeLoginTool getCheckCode];
                if (specificArr.count == 0) {
                    specificArr = [[NSMutableArray alloc]init];
                    headArr = [[NSMutableArray alloc]init];
                    flagArr = [[NSMutableArray alloc]init];
                    NSLog(@"---接收到通知---");
                    [[NetworkManager sharedInstance] HttpRequestWithType:@"GET" withURLString:[NSString stringWithFormat:@"http://119.23.125.153:8000/puty/api.ashx?action=getmytempletes&uid=%@&checkcode=%@",uid,checkcode] withParaments:nil progress:nil withCompleteBlock:^(NSError *error, id data) {
                        NSLog(@"专用模版返回的数据 = %@",data);
                        for(NSDictionary *dic in [data objectForKey:@"rows"]){
                            SpecificUseModel *model = [[SpecificUseModel alloc]initWithDictionary:dic error:nil];
                            model.imgNamed = @"spread_button";
                            [headArr addObject:model];
                            [flagArr addObject:@"0"];
                            NSMutableArray *arr = [[NSMutableArray alloc]init];
                            for(NSDictionary *dic in model.list){
                                SpecificUseListModel *listmodel = [[SpecificUseListModel alloc]initWithDictionary:dic error:nil];
                                [arr addObject:listmodel];
                                
                            }
                            [specificArr addObject:arr];
                        }
                        [specificTable reloadData];
                    }];

                }
                [specificTable reloadData];


            }else{
                SpecificUseLoginController *vc = [SpecificUseLoginController new];
                [self.navigationController pushViewController:vc animated:YES];
              
            }
          
        }
        
    }
}
-(UIView*)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    if (tableView == specificTable) {
        SpecificUseModel *model = headArr[section];
        
         UIView *view = [[UIView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH-130, 40)];
        UIView *line = [[UIView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH-130, 0.3)];
        [line setBackgroundColor:[UIColor lightGrayColor]];
        [view addSubview:line];
        UILabel *titleLab = [[UILabel alloc]initWithFrame:CGRectMake((SCREEN_WIDTH-130)/2-20, 0.3, 40, 39.7)];
        titleLab.text = [NSString stringWithFormat:@"%ld",section+1];
        [titleLab setTextAlignment:NSTextAlignmentCenter];
        [titleLab setFont:[UIFont systemFontOfSize:14]];
        [view addSubview:titleLab];
        UIImageView *img = [[UIImageView alloc]initWithFrame:CGRectMake(SCREEN_WIDTH-130-35, 12.5, 15, 15)];
        
        [img setImage:[UIImage imageNamed:model.imgNamed]];
        [view addSubview:img];
        view.tag = 100+section;
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(sectionClick:)];
        [view addGestureRecognizer:tap];
        [view setBackgroundColor:[UIColor whiteColor]];
        return view;
    }
    return nil;
}
-(void)sectionClick:(UITapGestureRecognizer *)tap{
    int index = tap.view.tag%100;
    SpecificUseModel *model = headArr[index];
    NSMutableArray *indexArray = [[NSMutableArray alloc]init];
    NSArray *arr = specificArr[index];
    for (int i = 0; i<arr.count; i++) {
        NSIndexPath *path = [NSIndexPath indexPathForRow:i inSection:index];
        [indexArray addObject:path];
    }
    //展开
    if ([flagArr[index] isEqualToString:@"0"]) {
        flagArr[index] = @"1";
        model.imgNamed = @"pack_up_button";
        [specificTable reloadData];
        [specificTable reloadRowsAtIndexPaths:indexArray withRowAnimation:UITableViewRowAnimationBottom];
    }else{
        flagArr[index] =@"0";
        model.imgNamed = @"spread_button";
        [specificTable reloadData];
        [specificTable reloadRowsAtIndexPaths:indexArray withRowAnimation:UITableViewRowAnimationBottom];
    }
}
@end
