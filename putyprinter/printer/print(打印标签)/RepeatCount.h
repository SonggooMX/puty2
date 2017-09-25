//
//  RepeatCount.h
//  BTDemoCJ
//
//  Created by songgoo on 2017/4/25.
//
//

#import <Foundation/Foundation.h>

@interface RepeatCount : NSObject

@property(nonatomic, nonnull) NSString *value;
@property(nonatomic, nonnull) NSString *count;

- (void) init:(NSString*)value second:(NSString*)count;

@end
