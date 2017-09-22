//
//  TextAttributeTableViewController.m
//  ceshi
//
//  Created by  on 2017/7/25.
//  Copyright © 2017年 . All rights reserved.
//

#import "TextAttributeTableViewController.h"
#import "TextSectionModel.h"
#import "TextCellModel.h"
#import "TextSectionSwitchCell.h"
#import "TextAttArrayCell.h"
#import "TextAttAcceryCell.h"

#define kScreenBounds [UIScreen mainScreen].bounds
#define kScreenWidth [UIScreen mainScreen].bounds.size.width
#define kScreenHeight [UIScreen mainScreen].bounds.size.height
typedef enum : NSUInteger {
    ///文本
    textAttText,
    ///数据内容
    textAttData,
    ///字体
    textAttFont,
    ///位置大小
    textAttLocation,
    ///旋转角度
    textAttRotaion,
    ///参与打印
    textAttPrint
} textAtt;

@interface TextAttributeTableViewController ()
@property(nonatomic,copy)NSArray<TextSectionModel*>* textSectionModelArray;
@end
static NSString* resNormal = @"resNormal";
static NSString* resSwitch = @"resSwitch";
static NSString* resArray = @"resArray";
static NSString* resAccery = @"resAccery";
@implementation TextAttributeTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    
    [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:resNormal];
    [self.tableView registerClass:[TextSectionSwitchCell class] forCellReuseIdentifier:resSwitch];
    [self.tableView registerClass:[TextAttArrayCell class] forCellReuseIdentifier:resArray];
    [self.tableView registerClass:[TextAttAcceryCell class] forCellReuseIdentifier:resAccery];
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {

    return self.textSectionModelArray.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return self.textSectionModelArray[section].sectionHeaderHeight;
}
- (UIView*)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    CGFloat sectionHeight = self.textSectionModelArray[section].sectionHeaderHeight;
    UIView* titleView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, sectionHeight)];
    titleView.backgroundColor = [UIColor groupTableViewBackgroundColor];
    
    UILabel* titleLabel = [UILabel new];
    [titleView addSubview:titleLabel];
    [titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.offset(15);
        make.bottom.offset(-5);
    }];
    titleLabel.text = self.textSectionModelArray[section].sectionHeaderText;
    titleLabel.font = [UIFont systemFontOfSize:14];
    return titleView;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {

    return self.textSectionModelArray[section].sectionRows.count;
}

- (UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    if ([self.textSectionModelArray[indexPath.section].sectionRows[indexPath.row].type isEqualToString:@"normal"]) {
         UITableViewCell* cell = [tableView dequeueReusableCellWithIdentifier:resNormal forIndexPath:indexPath];
        cell.textLabel.text = self.textSectionModelArray[indexPath.section].sectionRows[indexPath.row].title;
        cell.textLabel.font = [UIFont systemFontOfSize:14];
         return cell;
    }else if ([self.textSectionModelArray[indexPath.section].sectionRows[indexPath.row].type isEqualToString:@"switch"]){
        TextSectionSwitchCell* cell = [tableView dequeueReusableCellWithIdentifier:resSwitch forIndexPath:indexPath];
        cell.titleLabel.text = self.textSectionModelArray[indexPath.section].sectionRows[indexPath.row].title;
        return cell;
    }
    else if ([self.textSectionModelArray[indexPath.section].sectionRows[indexPath.row].type isEqualToString:@"array"]){
        TextAttArrayCell* cell = [tableView dequeueReusableCellWithIdentifier:resArray forIndexPath:indexPath];
        cell.titleLabel.text = self.textSectionModelArray[indexPath.section].sectionRows[indexPath.row].title;
        cell.tagArray = self.textSectionModelArray[indexPath.section].sectionRows[indexPath.row].tagArray;
        NSLog(@"%@",cell.tagArray);
        return cell;
    }
    
    else if ([self.textSectionModelArray[indexPath.section].sectionRows[indexPath.row].type isEqualToString:@"accery"]){
        TextAttAcceryCell* cell = [tableView dequeueReusableCellWithIdentifier:resAccery forIndexPath:indexPath];
        cell.titleLabel.text = self.textSectionModelArray[indexPath.section].sectionRows[indexPath.row].title;
        cell.rightLabel.text = self.textSectionModelArray[indexPath.section].sectionRows[indexPath.row].rightText;
     
        return cell;
    }
    return nil;
   
}

- (NSArray<TextSectionModel *> *)textSectionModelArray{
    if (!_textSectionModelArray) {
        NSArray* array = [NSArray arrayWithContentsOfFile:[[NSBundle mainBundle]pathForResource:@"textAtt.plist" ofType:nil]];
     
        _textSectionModelArray = [NSArray yy_modelArrayWithClass:[TextSectionModel class] json:array];
    }
    return _textSectionModelArray;
}

@end
