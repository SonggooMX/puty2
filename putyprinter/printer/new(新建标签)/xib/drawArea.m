//
//  drawArea.m
//  printer
//
//  Created by songgoo on 2017/7/22.
//  Copyright © 2017年 puty. All rights reserved.
//

#import "drawArea.h"
#import "baseView.h"
#import "NewLabelViewController.h"

@implementation drawArea

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/


- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self initFrame:frame];
    }
    return self;
}

- (void) initFrame:(CGRect)frame
{
    NSArray *views=[[NSBundle mainBundle] loadNibNamed:@"drawArea" owner:self options:nil];
    self.contentView=[views objectAtIndex:0];
    self.contentView.frame=frame;
    self.contentView.layer.cornerRadius=5;
    [self addSubview:self.contentView];
}

#pragma mark -删除选中的元素
-(void) deleteElement
{
    NSMutableArray *arr=[NSMutableArray new];
    int len=(int)self.subviews.count;
    for(int i=1;i<len;i++)
    {
        baseView *bs=(baseView*)self.subviews[i];
        if(bs.isslected==1&&bs.isLock==0)
        {
            [arr addObject:bs];
        }
    }
    
    //删除
    while(arr.count>0)
    {
        UIView *v=arr[0];
        [v removeFromSuperview];
        [arr removeObject:v];
    }
    
    int type=7;
    UIView *sview=nil;
    if(self.subviews.count>1)
    {
        sview=self.subviews[self.subviews.count-1];
        baseView *bsv=(baseView*)sview;
        bsv.isslected=true;
        [bsv refresh];
        
        type=((baseView*)sview).elementType;
    }
    [((NewLabelViewController*)self.parent) setElementPropety:type withSelect:true withElement:sview];
}

#pragma mark -锁定元素
-(void) lockElement
{
    int len=(int)self.subviews.count;
    for(int i=1;i<len;i++)
    {
        baseView *bs=(baseView*)self.subviews[i];
        if(bs.isslected==1)
        {
            bs.isLock=bs.isLock==1?0:1;
            [bs refresh];
        }
    }
}

#pragma mark -取消所有选中
-(void) cancelAllSelected
{
    int len=(int)self.subviews.count;
    for(int i=1;i<len;i++)
    {
        baseView *bs=(baseView*)self.subviews[i];
        bs.isslected=0;
        [bs refresh];
    }
}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    [((NewLabelViewController*)self.parent) setElementPropety:7 withSelect:true withElement:nil];
    [super touchesBegan:touches withEvent:event];
    //取消所有选中
    int len=(int)self.subviews.count;
    for(int i=1;i<len;i++)
    {
        baseView *bs=(baseView*)self.subviews[i];
        bs.isslected=false;
        [bs refresh];
    }
}

- (void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event
{
    [super touchesMoved:touches withEvent:event];
}

-(void)touchesEnded:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    [super touchesEnded:touches withEvent:event];
}

@end
