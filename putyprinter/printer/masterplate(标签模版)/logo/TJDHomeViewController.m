

#import "TJDHomeViewController.h"
#import "HandwritingManageController.h"
#import "LogoManagerController.h"
#import "TagTemplateController.h"
#import "TianJinDLConfig.h"
@interface TJDHomeViewController ()
@end

@implementation TJDHomeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor=[UIColor whiteColor];
    [self createUI];
}
#pragma mark -- UI
-(void)createUI{
    NSArray *titleArr = @[@"字体",@"logo",@"模版"];
    for(int i = 0 ;i<3;i++)
    {
        
        
        UIButton *btn = [[UIButton alloc]initWithFrame:CGRectMake(SCREEN_WIDTH*3/8, 100*i+120, SCREEN_WIDTH/4, 40)];
        [btn setTitle:titleArr[i] forState:UIControlStateNormal];
        [btn setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
        [self.view addSubview:btn];
        btn.tag = i;
        [btn addTarget:self action:@selector(goPage:) forControlEvents:UIControlEventTouchUpInside];
        
    }
}
-(void)goPage:(UIButton*)sender{
    if (sender.tag == 0) {
        //字体
        HandwritingManageController *vc = [HandwritingManageController new];
        [self.navigationController pushViewController:vc animated:YES];
    }
    if (sender.tag == 1) {
        //logo
        LogoManagerController *vc = [LogoManagerController new];
       [self.navigationController pushViewController:vc animated:YES];
        
    }
    if (sender.tag ==2) {
        //模版
        TagTemplateController *vc = [TagTemplateController new];
       [self.navigationController pushViewController:vc animated:YES];
    }

}

@end
