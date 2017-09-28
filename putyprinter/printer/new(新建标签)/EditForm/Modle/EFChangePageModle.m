//
//  EFChangePageModle.m
//  EdictForm
//
//  Created by 韦超才 on 2017/8/12.
//  Copyright © 2017年 韦超才. All rights reserved.
//

#import "EFChangePageModle.h"
#import "EFChangePageCell.h"

@implementation EFChangePageModle

+ (NSString *)cellId
{
    // subclass must overrid it
    return NSStringFromClass([EFChangePageCell class]);
}

- (void)setupWithCell:(EFBaseCell *)cell withBaseView:(baseView*)bview
{
    EFChangePageCell *rcell = (EFChangePageCell*)cell;
 
    
    rcell.currentPage = self.currentPage;
//    rcell.textLabel.text = self.title;
    rcell.maxPage = self.maxPage;
    rcell.changepageClosure = ^(NSInteger page) {
        self.currentPage = page;
        if (self.changepageClosure) {
            self.changepageClosure(page);
        }
    };
}

@end
