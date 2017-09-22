//
//  EFChangePageCell.m
//  EdictForm
//
//  Created by 韦超才 on 2017/8/12.
//  Copyright © 2017年 韦超才. All rights reserved.
//

#import "EFChangePageCell.h"

@implementation EFChangePageCell

- (void)awakeFromNib {
    [super awakeFromNib];
    
    [self setupPageLable];
}


- (void)setMaxPage:(NSInteger)maxPage
{
    _maxPage = maxPage;
    [self setupPageLable];
}

- (void)setupPageLable
{
    if (self.currentPage < 0) {
        _currentPage = 0;
    }
    
    self.pageLable.text = [NSString stringWithFormat:@"%ld/%ld",self.currentPage+1,self.maxPage];
}

- (void)setCurrentPage:(NSInteger)currentPage
{
    _currentPage = currentPage;
    if (_currentPage < 0) {
        _currentPage = 0;
    }
    if (_currentPage >= self.maxPage) {
        _currentPage = self.maxPage - 1;
    }
    
    [self setupPageLable];
    if (self.changepageClosure) {
        self.changepageClosure(currentPage);
    }
}

- (NSInteger)maxPage
{
    if (_maxPage) {
        _maxPage = 560;
    }
    return _maxPage;
}

- (IBAction)startAction:(id)sender {
    self.currentPage = 0;
}
- (IBAction)preAction:(id)sender {
    self.currentPage--;
}
- (IBAction)nextAction:(id)sender {
    self.currentPage++;
}
- (IBAction)endAction:(id)sender {
    self.currentPage = self.maxPage -1;
}

@end
