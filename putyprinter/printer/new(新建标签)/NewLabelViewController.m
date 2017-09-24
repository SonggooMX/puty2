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
#import "BaseEdictFormViewController.h"
@interface NewLabelViewController ()

//新建标签
@property newLabel *nLabelView;

@property (weak, nonatomic) IBOutlet UILabel *lbElementPosInfo;

// 底部功能区
@property (weak, nonatomic) IBOutlet UIView *bottomFuncArea;

// 画板
//@property (weak, nonatomic) IBOutlet UIView *drawViewContent;

// 新建标签
@property(nonatomic,strong)UIView *subView;
// 标签
@property(nonatomic,strong)labelArea *editView;
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

//返回按钮
@property UIBarButtonItem *rebackButton;


@end






@implementation NewLabelViewController

-(void)updateTip:(NSString *)msg
{
    self.lbElementPosInfo.text=msg;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.navigationItem.title = @"新建标签";
    self.rebackButton = [[UIBarButtonItem alloc] init];
    self.rebackButton.image = [UIImage imageNamed:@"back_button_n"];
    self.rebackButton.target = self;
    self.rebackButton.action = @selector(reback);
    [self.navigationItem setLeftBarButtonItem:self.rebackButton];
    
    CGRect rect=[UIScreen mainScreen].bounds;
    
    //绘图区域 +40=左右两边有边距
    self.drawAreaView=[[drawArea alloc] initWithFrame:CGRectMake(0, 0, self.drawViewContent.frame.size.width+40, self.drawViewContent.frame.size.height)];
    self.drawAreaView.parent=self;
    [self.drawViewContent addSubview:self.drawAreaView];
    //[self.drawAreaView mas_makeConstraints:^(MASConstraintMaker *make) {
    //    make.top.bottom.left.right.equalTo(self.drawViewContent);
    //}];
    
    //新增界面
    self.nLabelView=[[newLabel alloc] initWithFrame:CGRectMake(0, 0, rect.size.width, 284)];
    self.nLabelView.parent=self;
    [self.bottomview addSubview:self.nLabelView]; //添加
    
    //元素属性
    [self setElementPropety:BaseEdictFormTypeLable withSelect:false];
    
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
    self.editView.parent=self;
    [self.bottomFuncArea addSubview:self.editView];
    
//    //绘图区域
    self.drawViewContent.layer.cornerRadius=5;
    
}

#pragma mark -设置顶部按钮
-(void) setTopIconButton
{
    self.navigationItem.title = @"";
    self.rebackButton.title=@" ";
    
    UIView *line = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 1, 26)];
    line.backgroundColor = [UIColor whiteColor];
    UIBarButtonItem *lineItem = [[UIBarButtonItem alloc] initWithCustomView:line];

     self.navigationItem.rightBarButtonItems = @[[self itemWithImage:@"print_button_n"],lineItem,[self itemWithImage:@"lock-object_button_n"],[self itemWithImage:@"delete_button_n"],[self itemWithImage:@"redo_buton_n"],[self itemWithImage:@"revoke_button_n"],[self itemWithImage:@"multiselect_button"]];
}

#pragma mark -隐藏顶部按钮
-(void) setTopIconButtonHidden
{
    self.navigationItem.title = @"新建标签";
    self.rebackButton.title=@"";
    self.navigationItem.rightBarButtonItems=@[];
}

- (UIBarButtonItem *)itemWithImage:(NSString *)img
{
    UIButton *btn = [UIButton buttonWithType:(UIButtonTypeCustom)];
    btn.frame = CGRectMake(0, 0, 32, 32);
    [btn setImage:[UIImage imageNamed:img] forState:(UIControlStateNormal)];
    UIBarButtonItem *item = [[UIBarButtonItem alloc] initWithCustomView:btn];
    return item;
}

#pragma mark -选中元素属性
-(void) setElementPropety:(int)type withSelect:(BOOL)isselected
{
    //属性界面
    BaseEdictFormViewController *vc=[BaseEdictFormViewController new];
    vc.type=type;
    self.propertyView=vc.view;
    [self addChildViewController:vc];
    
    [self.bottomFuncArea addSubview:self.propertyView]; //添加
    [vc didMoveToParentViewController:self];

    [self.propertyView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.bottom.left.right.equalTo(self.bottomFuncArea);
    }];
    
    if(isselected)
    {
        //选中属性
        UIButton *bt=[UIButton alloc];
        bt.tag=1003;
        [self btnSwitchView:bt];
    }
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
