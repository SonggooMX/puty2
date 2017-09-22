//
//  EFPickButton.m
//  EdictForm
//
//  Created by 韦超才 on 2017/8/10.
//  Copyright © 2017年 韦超才. All rights reserved.
//

#import "EFPickButton.h"

#define kdarkLine      [UIColor colorWithRed:233/255.0 green:233/255.0 blue:233/255.0 alpha:1.0]

@implementation EFPickButton

-(void)awakeFromNib
{
    [super awakeFromNib];
    
    self.layer.borderWidth = 1.0;
    self.layer.cornerRadius = 2.0f;
    self.clipsToBounds = true;
    self.layer.borderColor = kdarkLine.CGColor;
    self.curentIndex = 0;
}

- (void)setItemTitles:(NSArray<NSString *> *)itemTitles
{
    _itemTitles = itemTitles;
    self.curentIndex = 0;
}

- (NSString *)result
{
    if (self.unit) {
        return [NSString stringWithFormat:@"%@%@",self.itemTitles[self.curentIndex],self.unit];
    }
    return self.itemTitles[self.curentIndex];
}

- (void)setCurentIndex:(NSInteger)curentIndex
{
    _curentIndex = curentIndex;
    if (_curentIndex > 0 && _curentIndex >= self.itemTitles.count) {
        _curentIndex = 0;
    }
    
    if (_curentIndex < 0) {
        _curentIndex = self.itemTitles.count -1;
    }
    self.titleLable.text = [self result];
    if (self.changeActin) {
        self.changeActin([self result],curentIndex);
    }
    
}

- (IBAction)addAction:(id)sender {
    self.curentIndex++;
}
- (IBAction)reduceAction:(id)sender {
    self.curentIndex--;
}

@end
