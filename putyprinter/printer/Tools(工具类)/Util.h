//
//  Util.h
//  printer
//
//  Created by songgoo on 2017/10/10.
//  Copyright © 2017年 puty. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Util : NSObject

- (UIImage *)image:(UIImage *)image rotation:(UIImageOrientation)orientation;
-(UIImage*) PostScale:(UIImage*)temp withW:(float)pw withH:(float)ph;

@end
