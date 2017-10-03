//
//  BaseEdictFormViewController.m
//  EdictForm
//
//  Created by 韦超才 on 2017/8/10.
//  Copyright © 2017年 韦超才. All rights reserved.
//

#import "BaseEdictFormViewController.h"
#import "EdictBoxView.h"
#import "EFToolBar.h"
#import "EFChangePageCell.h"
#import "EFMultiButtonView.h"
#import "EFPickCell.h"
#import "EFPickButton.h"
#import "EFMuiltiButtonCell.h"
#import "EFSliderCell.h"
#import "EFFontSizeCell.h"
#import "EFAttributeCell.h"
#import "EFSwitchCell.h"
#import "EFBaseCell.h"
#import "EFMuiltiBtnModle.h"
#import "PickViewModle.h"
#import "EFChangePageModle.h"
#import "EFFontSizeModle.h"
#import "EFAttributeModle.h"
#import "EFAngleModel.h"
#import "EFSwitchModel.h"
#import "EFSliderModel.h"
#import "EFPositionModel.h"
#import "EFButtonCellModle.h"



#define kheightBlue    [UIColor colorWithRed:0 green:124/255.0 blue:224/255.0 alpha:1.0]
#define kdarkBlue      [UIColor colorWithRed:68/255.0 green:155/255.0 blue:227/255.0 alpha:1.0]
#define kdarkLine      [UIColor colorWithRed:233/255.0 green:233/255.0 blue:233/255.0 alpha:1.0]



#define kdarkLine      [UIColor colorWithRed:233/255.0 green:233/255.0 blue:233/255.0 alpha:1.0]


@interface BaseEdictFormViewController ()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic,strong)EFMuiltiBtnModle *codeAttribuModle;

@property (nonatomic,strong)NSArray <NSArray <EFBaseModle *>*>*modles;

@property (nonatomic,strong)EFMuiltiBtnModle *textPositionModle;



@property (nonatomic,strong)EFMuiltiBtnModle *dataTyepModle;

@property (nonatomic,strong)PickViewModle *currentContentModle;

@property (nonatomic,strong)PickViewModle *datanameModle;

@property (nonatomic,strong)EFChangePageModle *pageModle;


@property (nonatomic,strong)PickViewModle *fontNameModle;

@property (nonatomic,strong)EFFontSizeModle *fontsizeModle;

@property (nonatomic,strong)EFMuiltiBtnModle *aligModle;

@property (nonatomic,strong)EFAttributeModle *attributeModle;


@property (nonatomic,strong)EFPositionModel *positionModle;

@property (nonatomic,strong)EFAngleModel *angleModle;

@property (nonatomic,strong)EFSwitchModel *switchModle;
@property (nonatomic,strong)EFSwitchModel *switchModle2;


@end

@implementation BaseEdictFormViewController



- (void)viewDidLoad {
    [super viewDidLoad];
    self.automaticallyAdjustsScrollViewInsets = NO;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    if (section == self.modles.count - 1) {
        return 22;
    }
    return 44;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, 44)];
    
    UILabel *lab = [UILabel new];
    [view addSubview:lab];
    if (section < self.titles.count) {
        lab.text = [self titles][section];
    }
    
    [lab sizeToFit];
    
    lab.frame  = CGRectMake(12,view.bounds.size.height- lab.bounds.size.height - 5, lab.bounds.size.width, lab.bounds.size.height + 5);
    
    view.backgroundColor = kdarkLine;
    return  view;
    
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    self.navigationController.navigationBar.barTintColor = kheightBlue;
    
    
    UIBarButtonItem *item = [UIBarButtonItem appearance];
    NSMutableDictionary *norAtt = [NSMutableDictionary new];
    norAtt[NSFontAttributeName] = [UIFont systemFontOfSize:16];
    norAtt[NSForegroundColorAttributeName]  = [UIColor whiteColor];
    [item setTitleTextAttributes:norAtt forState:(UIControlStateNormal)];
    
    NSMutableDictionary *lightAtt = [NSMutableDictionary new];
    lightAtt[NSFontAttributeName] = [UIFont systemFontOfSize:16];
    lightAtt[NSForegroundColorAttributeName] = kdarkLine;
    [item setTitleTextAttributes:lightAtt forState:UIControlStateHighlighted];
    
    UINavigationBar *bar = [UINavigationBar appearance];
    
    NSMutableDictionary *attribute = [NSMutableDictionary new];
    attribute[NSFontAttributeName] = [UIFont systemFontOfSize:16];
    attribute[NSForegroundColorAttributeName] = [UIColor whiteColor];
    attribute[NSShadowAttributeName]  = nil;
    bar.titleTextAttributes = attribute;
    
    
    UIView *line = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 1, 26)];
    line.backgroundColor = [UIColor whiteColor];
    UIBarButtonItem *lineItem = [[UIBarButtonItem alloc] initWithCustomView:line];
    
    
 
 
    self.navigationItem.rightBarButtonItems = @[[self itemWithImage:@"print_button_n"],lineItem,[self itemWithImage:@"lock-object_button_n"],[self itemWithImage:@"delete_button_n"],[self itemWithImage:@"redo_buton_n"],[self itemWithImage:@"revoke_button_n"],[self itemWithImage:@"multiselect_button"]];
    
}

- (UIBarButtonItem *)itemWithImage:(NSString *)img
{
    UIButton *btn = [UIButton buttonWithType:(UIButtonTypeCustom)];
    btn.frame = CGRectMake(0, 0, 32, 32);
    [btn setImage:[UIImage imageNamed:img] forState:(UIControlStateNormal)];
    UIBarButtonItem *item = [[UIBarButtonItem alloc] initWithCustomView:btn];
    return item;
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.modles[section].count;
}

- (NSArray *)titles
{
    switch (self.type) {
        case BaseEdictFormTypeBarCode:
        {
           return @[@"一维码",@"数据内容",@"字体",@"位置大小",@"旋转角度"];
        }
            break;
        case BaseEdictFormTypeQRCode:
        {
           return @[@"二维码",@"数据内容",@"位置大小",@"旋转角度"];
        }
            break;
        case BaseEdictFormTypeImage:
        {
            return @[@"图片",@"位置大小",@"旋转角度"];
        }
            break;
        case BaseEdictFormTypeForm:
        {
           return @[@"表格",@"位置大小",@"旋转角度"];
        }
            break;
        case BaseEdictFormTypeLine:
        {
           return @[@"线条",@"位置大小",@"旋转角度"];
        }
            break;
        case BaseEdictFormTypeRectangle:
        {
            return @[@"矩形",@"位置大小",@"旋转角度"];
        }
            break;
        case BaseEdictFormTypeLogo:
        {
           return @[@"LOGO",@"位置大小",@"旋转角度"];
        }
            break;
        case BaseEdictFormTypeTxt:
            return @[@"文本",@"数据内容",@"字体",@"位置大小",@"旋转角度"];
        default:
            return @[@"标签属性",@"Exel内容",@"背景图片",@"打印参数",@"打印偏移"];
            break;
    }

    
    
}

- (EFMuiltiBtnModle *)muitlModleWithItems:(NSArray *)items tile:(NSString *)title
{
    EFMuiltiBtnModle *q_dataTyepModle = [[EFMuiltiBtnModle alloc] init];
    q_dataTyepModle.title = title;
    q_dataTyepModle.itemStrs = items;
    q_dataTyepModle.selectedAction = ^(NSInteger index){
        
    };
    return q_dataTyepModle;
}

- (EFFontSizeModle *)fontsizeModleWithTitle:(NSString *)title
{
    EFFontSizeModle *modle = [EFFontSizeModle modleWithType:(EFCellTypeFontSize)];
    modle.title = title;
    return modle;
}

- (PickViewModle *)pickMOdleWithTitle:(NSString *)title sub:(NSString *)sub
{
    PickViewModle *path = [PickViewModle modleWithType:(EFCellTypePickView)];
    path.title = title;
    path.subTitle = sub ? sub : @"";
    __weak typeof(self)wself = self;
    path.showPickView = ^(UIAlertController *alert) {
        [wself presentViewController:alert animated:YES completion:nil];
    };
    return path;
}

- (NSArray<NSArray<EFBaseModle *> *> *)modles
{
    if (!_modles ) {
        switch (self.type) {
            case BaseEdictFormTypeBarCode:
            {
                NSArray *firArr = @[self.codeAttribuModle,self.textPositionModle];
                NSArray *secArr = @[self.dataTyepModle,self.currentContentModle,self.datanameModle,self.pageModle];
                NSArray *thir = @[self.fontNameModle,self.fontsizeModle,self.aligModle,self.attributeModle];
                _modles = @[firArr,secArr,thir,@[self.positionModle],@[self.angleModle],@[self.switchModle]];
            }
                break;
            case BaseEdictFormTypeQRCode:
            {
                self.codeAttribuModle.title = @"二维码类型";
                self.codeAttribuModle.itemStrs = @[@"QRCode",@"Data Matrix",@"PDF417",@"Code one",@"Code 49",@"Code 16k",@"Maxicode"];
                self.textPositionModle.title = @"纠错级别";
                self.textPositionModle.itemStrs = @[@"低",@"中",@"高",@"强"];
                EFMuiltiBtnModle *codeType = [self muitlModleWithItems:@[@"Auto",@"UTF-8",@"GBK",@"ISO-8"]tile:@"编码方式"];
                NSArray *firArr = @[self.codeAttribuModle,self.textPositionModle,codeType];
                
                self.dataTyepModle.itemStrs = @[@"手工录入",@"递变数据",@"Excel数据"];
                NSArray *secArr = @[self.dataTyepModle,self.currentContentModle,self.datanameModle,self.pageModle];
                _modles = @[firArr,secArr,@[self.positionModle],@[self.angleModle],@[self.switchModle]];
            }
                break;
            case BaseEdictFormTypeImage:
            {
               
                EFSliderModel *slider = [EFSliderModel modleWithType:(EFCellTypeSlider)];
                slider.title = @"灰度阀门";
                
                EFSwitchModel *switch1 = [EFSwitchModel modleWithType:(EFCellTypeSwitch)];
                switch1.title = @"黑白显示";
                
                PickViewModle *path = [PickViewModle modleWithType:(EFCellTypePickView)];
                path.title = @"图片路径";
                path.subTitle = @"a122fdjshk.png";
                __weak typeof(self)wself = self;
                path.showPickView = ^(UIAlertController *alert) {
                    [wself presentViewController:alert animated:YES completion:nil];
                };
                
                EFSwitchModel *switch2 = [EFSwitchModel modleWithType:(EFCellTypeSwitch)];
                switch2.title = @"图片缩放";
                
                NSArray *firArr = @[slider,switch1,path,switch2];
                _modles = @[firArr,@[self.positionModle],@[self.angleModle],@[self.switchModle]];
            }
                break;
            case BaseEdictFormTypeForm:
            {
                EFFontSizeModle *lineWidth = [self fontsizeModleWithTitle:@"线条宽度"];
                EFFontSizeModle *lineWidth2 = [self fontsizeModleWithTitle:@"行数"];
                EFFontSizeModle *lineWidth3 = [self fontsizeModleWithTitle:@"第1行高度"];
                EFFontSizeModle *lineWidth4 = [self fontsizeModleWithTitle:@"列数"];
                EFFontSizeModle *lineWidth5 = [self fontsizeModleWithTitle:@"第1行宽度"];
                EFFontSizeModle *lineWidth6 = [self fontsizeModleWithTitle:@"第2行宽度"];
                
                NSArray *firArr = @[lineWidth,lineWidth2,lineWidth3,lineWidth4,lineWidth5,lineWidth6];
               
                _modles = @[firArr,@[self.positionModle],@[self.angleModle],@[self.switchModle]];
            }
                break;
            case BaseEdictFormTypeLine:
            {
                EFMuiltiBtnModle *bm = [self muitlModleWithItems:@[@"实线",@"虚线；"] tile:@"线条样式"];
//                EFFontSizeModle *lineWidth = [self fontsizeModleWithTitle:@"线条样式"];
                EFFontSizeModle *lineWidth2 = [self fontsizeModleWithTitle:@"线条长度"];
                EFFontSizeModle *lineWidth3 = [self fontsizeModleWithTitle:@"线条宽度"];
                EFFontSizeModle *lineWidth4 = [self fontsizeModleWithTitle:@"虚线间隔"];
               
                
                NSArray *firArr = @[bm,lineWidth2,lineWidth3,lineWidth4];
//                NSArray *firArr = @[self.codeAttribuModle,self.textPositionModle];
//                NSArray *secArr = @[self.dataTyepModle,self.currentContentModle,self.datanameModle,self.pageModle];
//                NSArray *thir = @[self.fontNameModle,self.fontsizeModle,self.aligModle,self.attributeModle];
                _modles = @[firArr,@[self.positionModle],@[self.angleModle],@[self.switchModle]];
            }
                break;
            case BaseEdictFormTypeRectangle:
            {
                EFMuiltiBtnModle *bm = [self muitlModleWithItems:@[@"直角",@"圆角",@"椭圆",@"圆"] tile:@"矩形形状"];
                EFSwitchModel *switch1 = [EFSwitchModel modleWithType:(EFCellTypeSwitch)];
                switch1.title = @"内部填充";
                
                EFFontSizeModle *lineWidth = [self fontsizeModleWithTitle:@"线条宽度"];
                
                
                NSArray *firArr = @[bm,switch1,lineWidth];
                _modles = @[firArr,@[self.positionModle],@[self.angleModle],@[self.switchModle]];
            }
                break;
            case BaseEdictFormTypeLogo:
            {
                EFSwitchModel *switch1 = [EFSwitchModel modleWithType:(EFCellTypeSwitch)];
                switch1.title = @"图片缩放";
                
                PickViewModle *path = [self pickMOdleWithTitle:nil sub:nil];
                path.title = @"LOGO路径";
                path.subTitle = @"a122fdjshk.png";
                //__weak typeof(self)wself = self;
                path.showPickView = ^(UIAlertController *alert) {
                    [self presentViewController:alert animated:YES completion:nil];
                };
                _modles = @[@[path,switch1],@[self.positionModle],@[self.angleModle],@[self.switchModle]];
            }
                break;
            case BaseEdictFormTypeLable:
            {
                NSString *lbName=self.lbInfo.labelName;
                NSString *lbWidth=[NSString stringWithFormat:@"%.2fmm",self.lbInfo.labelWidth];
                NSString *lbHeight=[NSString stringWithFormat:@"%.2fmm",self.lbInfo.labelHeight];
                PickViewModle *path = [self pickMOdleWithTitle:@"标签名称" sub:lbName];
                PickViewModle *path1 = [self pickMOdleWithTitle:@"标签宽度" sub:lbWidth];
                PickViewModle *path2 =[self pickMOdleWithTitle:@"标签高度" sub:lbHeight];
                EFMuiltiBtnModle *mb0 = [self muitlModleWithItems:@[@"0",@"90",@"180",@"270"] tile:@"打印方向"];
                //设置打印方向
                [mb0 setCurrentindex:self.lbInfo.printDirect];
                
                EFMuiltiBtnModle *mb111 = [self muitlModleWithItems:@[@"连续孔",@"定位孔",@"间接纸",@"黑标纸"] tile:@"纸张类型"];
                [mb111 setCurrentindex:self.lbInfo.pagetType];
                
                PickViewModle *data = [self pickMOdleWithTitle:@"Excel数据" sub:nil];
                data.title = @"Excel数据";
                data.subTitle = @"";
                
                EFButtonCellModle *btn = [EFButtonCellModle modleWithType:(EFCellTypeButtonCell)];
                btn.titles = @[@"选择文件",@"清除数据"];

                PickViewModle *data1 = [self pickMOdleWithTitle:@"标签高度" sub:nil];
                data1.title = @"标签名称";
                data1.subTitle = @"";
                
                
                PickViewModle *data11 =[self pickMOdleWithTitle:@"标签高度" sub:nil];
                data11.title = @"图片名称";
                data11.subTitle = @"文件位置";
                
                EFButtonCellModle *btn1 = [EFButtonCellModle modleWithType:(EFCellTypeButtonCell)];
                btn1.titles = @[@"更换图片",@"清除背景"];
                
                
                EFFontSizeModle *print11 = [self fontsizeModleWithTitle:@"打印浓度"];
                print11.itemTitles=@[@"1(最淡)",@"2",@"3",@"4(较淡)",@"5",@"6(正常)",@"7",@"8",@"9",@"10",@"11(较浓)",@"12",@"13",@"14",@"15(最浓)"];
                print11.curentIndex=self.lbInfo.printDesnty-1;
                
                EFFontSizeModle *print12 = [self fontsizeModleWithTitle:@"打印速度"];
                print12.itemTitles=@[@"1(最慢)",@"2",@"3(正常)",@"4",@"5(最快)"];
                print12.curentIndex=self.lbInfo.printSpeed-1;
                
                EFFontSizeModle *print21 = [self fontsizeModleWithTitle:@"水平打印偏移量"];
                
                NSMutableArray *arr = [NSMutableArray new];
                for (double i = 0.0;i < 50.0;i+=0.1) {
                    [arr addObject:[NSString stringWithFormat:@"%.2f",i]];
                }
                print21.itemTitles=arr;
                for(int i=0;i<print21.itemTitles.count;i++)
                {
                    if(print21.itemTitles[i].floatValue==self.lbInfo.printHpadding)
                    {
                        print21.curentIndex=i;
                        break;
                    }
                }
                
                EFFontSizeModle *print22 = [self fontsizeModleWithTitle:@"垂直打印偏移量"];
                print22.itemTitles=arr;
                for(int i=0;i<print22.itemTitles.count;i++)
                {
                    if(print22.itemTitles[i].floatValue==self.lbInfo.printVpadding)
                    {
                        print22.curentIndex=i;
                        break;
                    }
                }
                
                _modles = @[@[path,path1,path2,mb0,mb111],@[data,btn,data1,self.pageModle],@[data11,btn1],@[print11,print12],@[print21,print22],@[self.switchModle2]];
                
            }
                break;
            case BaseEdictFormTypeTxt:
            {
                EFMuiltiBtnModle *bm = [self muitlModleWithItems:@[@"自动",@"1.2倍",@"1.5倍",@"自定义"] tile:@"行间距"];
                
                EFFontSizeModle *lineWidth = [self fontsizeModleWithTitle:@"字符间距"];
                NSMutableArray *arr = [NSMutableArray new];
                for (double i = 0.0;i < 50.0;i+=0.1) {
                    [arr addObject:[NSString stringWithFormat:@"%.2f",i]];
                }
                lineWidth.itemTitles=arr;
                for(int i=0;i<lineWidth.itemTitles.count;i++)
                {
                    if(lineWidth.itemTitles[i].floatValue==((lbView*)self.currentSelectView).charSpaceWidth)
                    {
                        lineWidth.curentIndex=i;
                        break;
                    }
                }
                
                EFSwitchModel *switch1 = [EFSwitchModel modleWithType:(EFCellTypeSwitch)];
                switch1.on=true;
                switch1.title = @"自动换行";
                
                
                NSArray *firArr = @[switch1,bm,lineWidth];
                _modles = @[firArr,@[self.dataTyepModle,self.currentContentModle,self.datanameModle,self.pageModle],@[self.fontNameModle,self.fontsizeModle,self.aligModle],@[self.positionModle],@[self.angleModle],@[self.switchModle]];
            }
                break;
            default:
                break;
        }
        
        
        
    }
    return _modles;
}

- (EFResultModle *)getResult
{
    EFResultModle *modle = [EFResultModle new];
    modle.codeType = self.codeAttribuModle.currentModle.str;
    modle.textPosition = self.textPositionModle.currentModle.str;
    modle.dataType = self.dataTyepModle.currentModle.str;
    modle.currentTxt = self.currentContentModle.subTitle;
    modle.dataName = self.datanameModle.subTitle;
    modle.page = self.pageModle.currentPage;
    modle.fontSize = self.fontNameModle.subTitle;
    modle.aligment = self.aligModle.currentModle.str;
    modle.attributeType = self.attributeModle.currentIndex;
    modle.x = [self.positionModle.x doubleValue];
    modle.y = [self.positionModle.y doubleValue];
    modle.width = [self.positionModle.width doubleValue];
    modle.height = [self.positionModle.height doubleValue];
    modle.angleType = self.angleModle.seletedIndex;
    modle.isPrint = self.switchModle.on;
    return modle;
}


// 编码属性
- (EFMuiltiBtnModle *)codeAttribuModle
{
    if (!_codeAttribuModle) {
        _codeAttribuModle = [[EFMuiltiBtnModle alloc] init];
        _codeAttribuModle.itemStrs = @[@"自动",@"TIF25",@"39",@"128",@"酷德巴码",@"EAN-8",@"EAN-13",@"UPC",@"MSI",@"ISBN"];
        _codeAttribuModle.title = @"编码属性";
        _codeAttribuModle.rowHeight = 118;
        _codeAttribuModle.selectedAction = ^(NSInteger result) {
            
            
            
        };
    }
    return _codeAttribuModle;
}

- (EFMuiltiBtnModle *)dataTyepModle
{
    if (!_dataTyepModle) {
        _dataTyepModle = [[EFMuiltiBtnModle alloc] init];
        _dataTyepModle.title = @"数据类型";
        _dataTyepModle.itemStrs = @[@"手工输入",@"递变数据",@"Excel数据"];
        _datanameModle.selectedAction = ^{
            
        };
    }
    return _dataTyepModle;
}

- (PickViewModle *)currentContentModle
{
    if (!_currentContentModle) {
        _currentContentModle = [self pickMOdleWithTitle:@"标签高度" sub:nil];;
        _currentContentModle.title = @"当前内容";
        _currentContentModle.subTitle = self.currentSelectView.content;
    }
    return _currentContentModle;
}

- (PickViewModle *)datanameModle
{
    if (!_datanameModle) {
        _datanameModle = [self pickMOdleWithTitle:@"标签高度" sub:nil];;
        _datanameModle.title = @"数据列名";
        _datanameModle.subTitle = @"物料仓库";
    }
    return _datanameModle;
}

- (EFChangePageModle *)pageModle
{
    if (!_pageModle) {
        _pageModle = (EFChangePageModle*)[EFBaseModle modleWithType:(EFCellTypeChangePage)];
        _pageModle.currentPage = 0;
        _pageModle.maxPage = 560;
        _pageModle.changepageClosure = ^(NSInteger page) {
            
        };
    }
    return _pageModle;
}

- (EFMuiltiBtnModle *)textPositionModle
{
    if (!_textPositionModle) {
        _textPositionModle = [[EFMuiltiBtnModle alloc] init];
        _textPositionModle.itemStrs = @[@"无文字",@"条码上方",@"条码下方"];
        _textPositionModle.title = @"文字位置";
        _textPositionModle.rowHeight = 44;
        _textPositionModle.selectedAction = ^(NSInteger result) {
            
        };
    }
    return _textPositionModle;
}



- (PickViewModle *)fontNameModle
{
    if (!_fontNameModle) {
        _fontNameModle  = [self pickMOdleWithTitle:@"标签高度" sub:nil];
        _fontNameModle.title = @"字体名称";
        _fontNameModle.subTitle = @"黑体";
        
    }
    return _fontNameModle;
}


- (EFFontSizeModle *)fontsizeModle
{
    if (!_fontsizeModle) {
        _fontsizeModle = (EFFontSizeModle*)[EFBaseModle modleWithType:(EFCellTypeFontSize)];
        _fontsizeModle.title = @"文字大小";
        _fontsizeModle.itemTitles = @[@"小五",@"五号",@"小四",@"四号"];
        
    }
    return _fontsizeModle;
}

- (EFMuiltiBtnModle *)aligModle
{
    if (!_aligModle) {
        _aligModle = (EFMuiltiBtnModle*)[EFBaseModle modleWithType:(EFCellTypeMuiltiBtn)];
        _aligModle.title = @"水平对其";
        _aligModle.itemStrs = @[@"居左",@"居右",@"居中",@"拉伸"];
        _aligModle.selectedAction = ^(NSInteger result) {
            
        };
    }
    return _aligModle;
}

- (EFAttributeModle *)attributeModle
{
    if (!_attributeModle) {
        _attributeModle = [EFAttributeModle modleWithType:(EFCellTypeAttribute)];
        _attributeModle.rowHeight = 120;
        _attributeModle.selectedAction = ^(NSInteger index) {
            
        };
    }
    return _attributeModle;
}


- (EFPositionModel *)positionModle
{
    if (!_positionModle) {
        _positionModle = (EFPositionModel*)[EFBaseModle modleWithType:(EFCellTypePosition)];
        
        NSMutableArray *arr = [NSMutableArray new];
        for (double i = 1.0;i < 999.99;i+=0.1) {
            [arr addObject:[NSString stringWithFormat:@"%.2f",i]];
        }
        _positionModle.itemsArr = arr;
        
        _positionModle.unit = @"mm";
        _positionModle.rowHeight = 90;
    }
    return _positionModle;
}

- (EFAngleModel *)angleModle
{
    if (!_angleModle) {
        _angleModle = [EFAngleModel modleWithType:(EFCellTypeAngle)];
        _angleModle.rowHeight = 115;
    }
    return _angleModle;
}

- (EFSwitchModel *)switchModle
{
    if (!_switchModle) {
        _switchModle = (EFSwitchModel*)[EFBaseModle modleWithType:(EFCellTypeSwitch)];
        _switchModle.title = @"参与打印";
        _switchModle.on = YES;
        _switchModle.valueBlock = ^(BOOL value) {
            
        };
    }
    return _switchModle;
}

- (EFSwitchModel *)switchModle2
{
    if (!_switchModle) {
        _switchModle = (EFSwitchModel*)[EFBaseModle modleWithType:(EFCellTypeSwitch)];
        _switchModle.title = @"是否锁定";
        _switchModle.on = YES;
        _switchModle.valueBlock = ^(BOOL value) {
            
        };
    }
    return _switchModle;
}


- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return self.modles.count;
}



- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    EFBaseModle *modle = self.modles[indexPath.section][indexPath.row];
    EFBaseCell *cell = [EFBaseCell cellWithType:modle.type tableView:tableView];
    [modle setupWithCell:cell withBaseView:self.currentSelectView withNewLabel:self.lbInfo];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    EFBaseModle *modle = self.modles[indexPath.section][indexPath.row];
    if (modle.selectedAction) {
        modle.selectedAction = ^{
            
        };
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    EFBaseModle *modle = self.modles[indexPath.section][indexPath.row];
    return modle.rowHeight ? modle.rowHeight : 44;
}


@end
