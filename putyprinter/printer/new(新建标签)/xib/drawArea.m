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

-(void) cancelAllSelected
{
    //取消所有选中
    int len=(int)self.subviews.count;
    for(int i=1;i<len;i++)
    {
        baseView *bs=(baseView*)self.subviews[i];
        bs.isslected=false;
        [bs refresh];
    }
    [((NewLabelViewController*)self.parent) setElementPropety:7 withSelect:true withElement:nil];
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
