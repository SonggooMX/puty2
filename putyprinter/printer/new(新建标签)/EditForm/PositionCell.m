//
//  PositionCell.m
//  EdictForm
//
//  Created by 韦超才 on 2017/8/12.
//  Copyright © 2017年 韦超才. All rights reserved.
//

#import "PositionCell.h"

@implementation PositionCell

- (void)awakeFromNib {
    [super awakeFromNib];
    self.xBtn.changeActin = self.xchangeActin;
    self.yBtn.changeActin = self.ychangeActin;
    self.widthBtn.changeActin = self.widthchangeActin;
    self.heightBtn.changeActin = self.heightchangeActin;
    self.unit = self.unit;
}

- (void)setXchangeActin:(void (^)(NSString *, NSInteger))xchangeActin
{
    _xchangeActin = xchangeActin;
    self.xBtn.changeActin = xchangeActin;
}

- (void)setYchangeActin:(void (^)(NSString *, NSInteger))ychangeActin
{
    _ychangeActin =ychangeActin;
    self.yBtn.changeActin = ychangeActin;
}

- (void)setWidthchangeActin:(void (^)(NSString *, NSInteger))widthchangeActin
{
    _widthchangeActin = widthchangeActin;
    self.widthBtn.changeActin = widthchangeActin;
}

- (void)setHeightchangeActin:(void (^)(NSString *, NSInteger))heightchangeActin
{
    _heightchangeActin = heightchangeActin;
    self.heightBtn.changeActin = heightchangeActin;
}



- (void)setUnit:(NSString *)unit
{
    _unit = unit;
    self.xBtn.unit = unit;
    self.yBtn.unit =unit;
    self.widthBtn.unit = unit;
    self.heightBtn.unit = unit;
}

@end
