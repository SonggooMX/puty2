//
//  NewLabelViewController.m
//  printer
//
//  Created by songgoo on 2017/7/13.
//  Copyright © 2017年 puty. All rights reserved.
//

#import "NewLabelViewController.h"
#import "Masonry.h"
#import "insertArea.h"
#import "labelArea.h"
#import "newLabel.h"
#import "TextAttributeTableViewController.h"
@interface NewLabelViewController ()


// 整个底部功能区
@property (weak, nonatomic) IBOutlet UIView *bottomview;

@property (weak, nonatomic) IBOutlet UILabel *lbElementPosInfo;

// 底部功能区
@property (weak, nonatomic) IBOutlet UIView *bottomFuncArea;

// 画板
//@property (weak, nonatomic) IBOutlet UIView *drawViewContent;

// 新建标签
@property(nonatomic,strong)UIView *subView;
// 标签
@property(nonatomic,strong)UIView *editView;
@property (weak, nonatomic) IBOutlet UIView *editViewContainer;

// 插入
@property(nonatomic,strong)insertArea *insertView;
@property (weak, nonatomic) IBOutlet UIView *insertViewContainer;

// 对齐
@property(nonatomic,strong)UIView *alignmentView;
@property (weak, nonatomic) IBOutlet UIView *alignmentViewContainer;


// 属性
@property(nonatomic,strong)UIView *propertyView;
@property (weak, nonatomic) IBOutlet UIView *propertyViewContainer;

//新建标签
@property(nonatomic,strong)newLabel *nLabelView;

@end






@implementation NewLabelViewController

-(void)updateTip:(NSString *)msg
{
    self.lbElementPosInfo.text=msg;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.navigationItem.title = @"新建标签";
    UIBarButtonItem *button = [[UIBarButtonItem alloc] init];
    //button.title = @"返回";
    button.image = [UIImage imageNamed:@"back_button_n"];
    button.target = self;
    button.action = @selector(reback);
    [self.navigationItem setLeftBarButtonItem:button];
    
    CGRect rect=[UIScreen mainScreen].bounds;
    
    //绘图区域 +40=左右两边有边距
    self.drawAreaView=[[drawArea alloc] initWithFrame:CGRectMake(0, 0, self.drawViewContent.frame.size.width+40, self.drawViewContent.frame.size.height)];
    [self.drawViewContent addSubview:self.drawAreaView];
    //[self.drawAreaView mas_makeConstraints:^(MASConstraintMaker *make) {
    //    make.top.bottom.left.right.equalTo(self.drawViewContent);
    //}];
    
    //新增界面
    self.nLabelView=[[newLabel alloc] initWithFrame:CGRectMake(0, 0, rect.size.width, 284)];
    self.nLabelView.parent=self;
    [self.bottomview addSubview:self.nLabelView]; //添加
    
    
    //旋转界面
//    NSArray *proView = [[NSBundle mainBundle] loadNibNamed:@"property" owner:self options:nil]; //通过这个方法,取得我们的视图
//    self.propertyView = [proView objectAtIndex:0];
    TextAttributeTableViewController* textAttVC = [TextAttributeTableViewController new];
    self.propertyView = textAttVC.view;
    [self addChildViewController:textAttVC];
    [self.bottomFuncArea addSubview:self.propertyView]; //添加
    [textAttVC didMoveToParentViewController:self];
    [self.propertyView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.bottom.left.right.equalTo(self.bottomFuncArea);
    }];
    
    //对齐界面
    NSArray *alignView = [[NSBundle mainBundle] loadNibNamed:@"alignment" owner:self options:nil]; //通过这个方法,取得我们的视图
    self.alignmentView = [alignView objectAtIndex:0];
    [self.bottomFuncArea addSubview:self.alignmentView]; //添加
    [self.alignmentView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.bottom.left.right.equalTo(self.bottomFuncArea);
    }];
    
    //插入界面
    self.insertView=[[insertArea alloc] initWithFrame:CGRectMake(0, 0, rect.size
                                                                 .width, 240)];
    self.insertView.parent=self;
    [self.bottomFuncArea addSubview:self.insertView];
    
    //标签界面
    self.editView=[[labelArea alloc] initWithFrame:CGRectMake(0, 0, rect.size
                                                              .width, 240)];
    [self.bottomFuncArea addSubview:self.editView];
    
//    //绘图区域
    self.drawViewContent.layer.cornerRadius=5;
    
}

#pragma mark - 切换编辑标签的界面
- (IBAction)btnSwitchView:(id)sender {
    UIButton *btn=(UIButton*)sender;
    switch (btn.tag) {
        case 1001://标签
            [self.bottomFuncArea bringSubviewToFront:self.editView];
            [self.insertViewContainer setBackgroundColor:[UIColor colorWithRed:0.0 green:(124.0/255) blue:226.0/255 alpha:1.0 ]];
            [self.propertyViewContainer setBackgroundColor:[UIColor colorWithRed:0.0 green:(124.0/255) blue:226.0/255 alpha:1.0 ]];
            [self.alignmentViewContainer setBackgroundColor:[UIColor colorWithRed:0.0 green:(124.0/255) blue:226.0/255 alpha:1.0 ]];
            [self.editViewContainer setBackgroundColor:[UIColor colorWithRed:0.0 green:(102.0/255) blue:185.0/255 alpha:1.0 ]];
            break;
        case 1002://插入
            [self.bottomFuncArea bringSubviewToFront:self.insertView];
            [self.editViewContainer setBackgroundColor:[UIColor colorWithRed:0.0 green:(124.0/255) blue:226.0/255 alpha:1.0 ]];
            [self.propertyViewContainer setBackgroundColor:[UIColor colorWithRed:0.0 green:(124.0/255) blue:226.0/255 alpha:1.0 ]];
            [self.alignmentViewContainer setBackgroundColor:[UIColor colorWithRed:0.0 green:(124.0/255) blue:226.0/255 alpha:1.0 ]];
            [self.insertViewContainer setBackgroundColor:[UIColor colorWithRed:0.0 green:(102.0/255) blue:185.0/255 alpha:1.0 ]];
            break;
        case 1003://属性
            [self.bottomFuncArea bringSubviewToFront:self.propertyView];
            [self.insertViewContainer setBackgroundColor:[UIColor colorWithRed:0.0 green:(124.0/255) blue:226.0/255 alpha:1.0 ]];
            [self.editViewContainer setBackgroundColor:[UIColor colorWithRed:0.0 green:(124.0/255) blue:226.0/255 alpha:1.0 ]];
            [self.alignmentViewContainer setBackgroundColor:[UIColor colorWithRed:0.0 green:(124.0/255) blue:226.0/255 alpha:1.0 ]];
            [self.propertyViewContainer setBackgroundColor:[UIColor colorWithRed:0.0 green:(102.0/255) blue:185.0/255 alpha:1.0 ]];
            break;
        case 1004://对齐
            [self.bottomFuncArea bringSubviewToFront:self.alignmentView];
            [self.insertViewContainer setBackgroundColor:[UIColor colorWithRed:0.0 green:(124.0/255) blue:226.0/255 alpha:1.0 ]];
            [self.propertyViewContainer setBackgroundColor:[UIColor colorWithRed:0.0 green:(124.0/255) blue:226.0/255 alpha:1.0 ]];
            [self.editViewContainer setBackgroundColor:[UIColor colorWithRed:0.0 green:(124.0/255) blue:226.0/255 alpha:1.0 ]];
            [self.alignmentViewContainer setBackgroundColor:[UIColor colorWithRed:0.0 green:(102.0/255) blue:185.0/255 alpha:1.0 ]];
            break;
        default:
            break;
    }
}

#pragma mark - 返回
-(void) reback
{
    [self.navigationController popViewControllerAnimated:YES];
}


@end
