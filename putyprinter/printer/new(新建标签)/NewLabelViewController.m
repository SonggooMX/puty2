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
#import "MessageHelper.h"
#import "UIView+Toast.h"

extern LabelInfo *TEMP_LABEL_INFO;
extern drawArea *TEMP_DRAW_AREA;
extern UIImage *TEMP_BITMAP;
extern NSString *TEMP_LABEL_MESSAGE;

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
@property BaseEdictFormViewController *vc;

@property MessageHelper *mhelper;

@end


@implementation NewLabelViewController

-(void)updateTip:(NSString *)msg
{
    self.lbElementPosInfo.text=msg;
}

-(void) createLabelInfo
{
    self.CURRENT_LABEL_INFO=[LabelInfo new];
    self.CURRENT_LABEL_INFO.labelName=@"新建标签1";
    self.CURRENT_LABEL_INFO.printDirect=1;//打印方向
    self.CURRENT_LABEL_INFO.pagetType=2;//间隙纸
    self.CURRENT_LABEL_INFO.printDes=6;//打印浓度
    self.CURRENT_LABEL_INFO.printSpeed=3;//打印速度
    self.CURRENT_LABEL_INFO.labelWidth=70;
    self.CURRENT_LABEL_INFO.labelHeight=50;
    TEMP_LABEL_INFO=self.CURRENT_LABEL_INFO;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    //消息提示帮助
    self.mhelper=[MessageHelper new];
    
    //初始化标签信息
    [self createLabelInfo];
    
    self.navigationItem.title = @"新建标签";
    self.rebackButton = [[UIBarButtonItem alloc] init];
    self.rebackButton.image = [UIImage imageNamed:@"back_button_n"];
    self.rebackButton.target = self;
    self.rebackButton.action = @selector(reback);
    [self.navigationItem setLeftBarButtonItem:self.rebackButton];
    
    CGRect rect=[UIScreen mainScreen].bounds;
    
    //绘图区域 +40=左右两边有边距
    self.drawAreaView=[[drawArea alloc] initWithFrame:CGRectMake(0, 0, self.drawViewContent.frame.size.width, self.drawViewContent.frame.size.height)];
    self.drawAreaView.parent=self;
    [self.drawViewContent addSubview:self.drawAreaView];
    [self.drawAreaView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.bottom.left.right.equalTo(self.drawViewContent);
    }];
    TEMP_DRAW_AREA=self.drawAreaView;
    
    //新增界面
    self.nLabelView=[[newLabel alloc] initWithFrame:CGRectMake(0, 0, rect.size.width, 284)];
    self.nLabelView.parent=self;
    [self.bottomview addSubview:self.nLabelView]; //添加
    [self.nLabelView setLabelInfowithFrom:0 withVC:self];
    
    //元素属性
    [self setElementPropety:BaseEdictFormTypeLable withSelect:false withElement:nil];
    
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
    
    NSString *multi=@"Radio_button";
    if(self.munSelectMode==1)
    {
        multi=@"multiselect_button";
    }

     self.navigationItem.rightBarButtonItems = @[[self itemWithImage:@"print_button_n" withIndex:0],lineItem,[self itemWithImage:@"lock-object_button_n" withIndex:1],[self itemWithImage:@"delete_button_n" withIndex:2],[self itemWithImage:@"redo_buton_n" withIndex:3],[self itemWithImage:@"revoke_button_n" withIndex:4],[self itemWithImage:multi withIndex:5]];
}
-(void) setTopIconButton:(BOOL)islock
{
    self.navigationItem.title = @"";
    self.rebackButton.title=@" ";
    
    UIView *line = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 1, 26)];
    line.backgroundColor = [UIColor whiteColor];
    UIBarButtonItem *lineItem = [[UIBarButtonItem alloc] initWithCustomView:line];
    
    NSString *multi=@"Radio_button";
    if(self.munSelectMode==1)
    {
        multi=@"multiselect_button";
    }
    
    NSString *lock=@"lock-object_button_n";
    if(islock)
    {
        lock=@"multiselect_button";
    }
    
    self.navigationItem.rightBarButtonItems = @[[self itemWithImage:@"print_button_n" withIndex:0],lineItem,[self itemWithImage:lock withIndex:1],[self itemWithImage:@"delete_button_n" withIndex:2],[self itemWithImage:@"redo_buton_n" withIndex:3],[self itemWithImage:@"revoke_button_n" withIndex:4],[self itemWithImage:multi withIndex:5]];
}

#pragma mark -隐藏顶部按钮
-(void) setTopIconButtonHidden
{
    self.navigationItem.title = @"新建标签";
    self.rebackButton.title=@"";
    self.navigationItem.rightBarButtonItems=@[];
}

- (UIBarButtonItem *)itemWithImage:(NSString *)img withIndex:(int)tag
{
    UIButton *btn = [UIButton buttonWithType:(UIButtonTypeCustom)];
    btn.tag=tag;
    [btn addTarget:self action:@selector(buttonItemClick:) forControlEvents:(UIControlEventTouchUpInside)];
    btn.frame = CGRectMake(0, 0, 32, 32);
    [btn setImage:[UIImage imageNamed:img] forState:(UIControlStateNormal)];
    UIBarButtonItem *item = [[UIBarButtonItem alloc] initWithCustomView:btn];
    return item;
}
#pragma mark -顶部按钮点击
-(void) buttonItemClick:(UIButton*)sender
{
    int tag=(int)sender.tag;
    switch (tag) {
        case 5://多选
            [self openMunSelect];
            break;
        case 4://撤销
            break;
        case 3://重做
            break;
        case 2://删除
            [self.drawAreaView deleteElement];
            break;
        case 1://锁定元素
            [self.drawAreaView lockElement];
            break;
        default://打印
            //显示标签属性
            [self setElementPropety:BaseEdictFormTypeLable withSelect:false withElement:nil];
            //取消所有选中
            [self.drawAreaView cancelAllSelected];
            PrintViewController *_printView=[[PrintViewController alloc] init];
            
            _printView.printSpeed=_CURRENT_LABEL_INFO.printSpeed;
            _printView.printDes=_CURRENT_LABEL_INFO.printDes;
            _printView.printDirect=_CURRENT_LABEL_INFO.printDirect;
            
            _printView.labelWidth=_CURRENT_LABEL_INFO.labelWidth;
            _printView.labelHeight=_CURRENT_LABEL_INFO.labelHeight;
            
            _printView.parent=self.parent;
            self.drawAreaView.contentView.layer.cornerRadius=0;//取消圆角
            _printView.pv=[self convertViewToImage:self.drawAreaView];
            self.drawAreaView.contentView.layer.cornerRadius=5;//打开圆角
            _printView.labelInfo=[NSString stringWithFormat:@"X:00mm  Y:00mm  宽:%.2fmm  高:%.2fmm",_CURRENT_LABEL_INFO.labelWidth,_CURRENT_LABEL_INFO.labelHeight];
            [self.navigationController pushViewController:_printView animated:YES];
            break;
    }
}

-(void) viewWillDisappear:(BOOL)animated
{
    //取消所有选中
    [self.drawAreaView cancelAllSelected];
    self.drawAreaView.contentView.layer.cornerRadius=0;//取消圆角
    TEMP_BITMAP=[self convertViewToImage:self.drawAreaView];
    self.drawAreaView.contentView.layer.cornerRadius=5;//打开圆角
    TEMP_LABEL_MESSAGE=[NSString stringWithFormat:@"X:00mm  Y:00mm  宽:%.2fmm  高:%.2fmm",_CURRENT_LABEL_INFO.labelWidth,_CURRENT_LABEL_INFO.labelHeight];
    //self.parent.tempDrawArea=self.drawAreaView;
    //self.parent.tempLabelInfo=self.CURRENT_LABEL_INFO;

}

#pragma mark - 开启多选模式
-(void) openMunSelect
{
    NSString *message=@"";
    self.munSelectMode=self.munSelectMode==1?0:1;
    if(self.munSelectMode==1)
    {
        message=@"多选模式已开启";
        self.editView.mulImageView.image=[UIImage imageNamed:@"multiselect_blue_button-n"];
    }
    else
    {
        message=@"多选模式已关闭";
        self.editView.mulImageView.image=[UIImage imageNamed:@"radio_blue_button_n"];
    }
    
    //重置顶部操作按钮
    [self setTopIconButton];
    //显示提示信息
    //[self.mhelper Toask:self.view showMessage:message delay:2.0];
    [self showMessage:message];
}

-(void) showMessage:(NSString*)message
{
    [self.view makeToast:message];
}

#pragma mark -获取打印的图片
-(UIImage*) getPrintImageView
{
    return [self convertViewToImage:self.drawAreaView];
}

#pragma mark -选中元素属性
-(void) setElementPropety:(int)type withSelect:(BOOL)isselected withElement:(UIView *)view
{
    //属性界面
    self.vc =[BaseEdictFormViewController new];
    self.vc.type=type;
    self.vc.currentSelectView=(baseView*)view;
    self.vc.lbInfo=self.nLabelView;
    self.propertyView=self.vc.view;
    [self addChildViewController:self.vc];
    
    [self.bottomFuncArea addSubview:self.propertyView]; //添加
    [self.vc didMoveToParentViewController:self];

    [self.propertyView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.bottom.left.right.equalTo(self.bottomFuncArea);
    }];
    
    if(self.vc.currentSelectView!=nil&&self.vc.currentSelectView.isLock)
    {
        [self setTopIconButton:YES];
    }
    else
    {
        [self setTopIconButton:NO];
    }
    
    if(isselected)
    {
        //选中属性
        UIButton *bt=[UIButton alloc];
        bt.tag=1003;
        [self btnSwitchView:bt];
    }
}

#pragma mark uiview 转图片
-(UIImage*)convertViewToImage:(UIView*)v{
    CGSize s = v.bounds.size;
    s=CGSizeMake(s.width-1, s.height-1);
    // 下面方法，第一个参数表示区域大小。第二个参数表示是否是非透明的。如果需要显示半透明效果，需要传NO，否则传YES。第三个参数就是屏幕密度了
    UIGraphicsBeginImageContextWithOptions(s, YES, [UIScreen mainScreen].scale);
    [v.layer renderInContext:UIGraphicsGetCurrentContext()];
    UIImage*image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return image;
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


#pragma mark - 设置对齐
- (IBAction)btnAlignment:(UIButton*)sender {
    switch (sender.tag) {
        case 0://水平左对齐
            [self.drawAreaView alignmentLeftH];
            break;
        case 1://垂直顶对齐
            [self.drawAreaView alignmentTopV];
            break;
        case 4://水平中对齐
            [self.drawAreaView alignmentCenterH];
            break;
        case 5://垂直中对齐
            [self.drawAreaView alignmentCenterV];
            break;
        case 8://水平右对齐
            [self.drawAreaView alignmentRightH];
            break;
        case 9://垂直底对齐
            [self.drawAreaView alignmentBottomV];
            break;
        default:
            break;
    }
}



@end
