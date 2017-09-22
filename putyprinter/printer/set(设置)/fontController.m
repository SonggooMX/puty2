//
//  fontController.m
//  printer
//
//  Created by 周宏全 on 2017/7/20.
//  Copyright © 2017年 puty. All rights reserved.
//

#import "fontController.h"
#import "ZXFontModel.h"
#import "ZXFontTableViewCell.h"
@interface fontController ()<UITableViewDelegate,UITableViewDataSource>
@property(nonatomic,copy)NSArray<ZXFontModel*>* modelList;
@property(nonatomic,weak)UITableView *fontTb;
@end

@implementation fontController
static NSString* fontCell = @"fontCell";
- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.navigationItem.title = @"字体管理";
    UIBarButtonItem *button = [[UIBarButtonItem alloc] init];
    button.image = [UIImage imageNamed:@"back_button_n"];
    button.target = self;
    button.action = @selector(reback);
    [self.navigationItem setLeftBarButtonItem:button];
    [self getDataList];
    UITableView *fontTb = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height) style:UITableViewStylePlain];
    fontTb.dataSource = self;
    [self.view addSubview:fontTb];
    _fontTb = fontTb;
    [fontTb registerNib:[UINib nibWithNibName:@"ZXFontTableViewCell" bundle:nil] forCellReuseIdentifier:fontCell];
}

#pragma mark - 数据源
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.modelList.count;
}

- (UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    ZXFontTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:fontCell forIndexPath:indexPath];
    cell.fontModel = self.modelList[indexPath.row];
    return cell;
}
#pragma mark - 返回
-(void) reback
{
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)getDataList{
    [KhttpManager reqeustWith:getFonts method:RequestGET parameters:nil callBack:^(id response) {
        if (response != nil) {
            self.modelList = [NSArray yy_modelArrayWithClass:[ZXFontModel class] json:response[@"rows"]];
            [self.fontTb reloadData];
        }
    }];
}


@end
