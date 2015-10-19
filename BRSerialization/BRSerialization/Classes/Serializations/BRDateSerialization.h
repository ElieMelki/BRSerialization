//
//  BRDateSerialization.h
//  BRJsonParser
//
//  Created by ELie Melki on 10/4/15.
//  Copyright © 2015 Elie Melki. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "BRISerialization.h"

@interface BRDateSerialization : NSObject<BRISerialization>

+ (instancetype) dateSerializationWith:(NSString *)theDateFormat;

- (id) initWithDateFormat:(NSString *)theDateFormat;

@property (nonatomic,readonly) NSString *dateFormat;

- (NSString *) serialize:(NSDate *)theObject;
- (NSDate *) deserialize:(NSString *)theData;

@end
