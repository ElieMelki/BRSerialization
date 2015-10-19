//
//  BRJavaTimeSerialization.h
//  BRJsonParser
//
//  Created by ELie Melki on 10/4/15.
//  Copyright © 2015 Elie Melki. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "BRISerialization.h"

@interface BRJavaTimeIntervalSerialization : NSObject<BRISerialization>

+ (instancetype) javaTimeIntervalSerialization;

- (NSString *) serialize:(NSDate *)theObject;
- (NSDate *) deserialize:(NSString *)theData;

@end