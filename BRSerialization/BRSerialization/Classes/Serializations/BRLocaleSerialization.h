//
//  BRLocaleSerialization.h
//  BRJsonParser
//
//  Created by ELie Melki on 10/4/15.
//  Copyright © 2015 Elie Melki. All rights reserved.
//


#import <Foundation/Foundation.h>
#import "BRSerializer.h"
#import "BRDeserializer.h"

@interface BRLocaleSerialization : NSObject<BRSerializer,BRDeserializer>

+ (instancetype) localeSerialization;

- (NSString *) serialize:(NSLocale *)theObject;
- (NSLocale *) deserialize:(NSString *)theData;

@end
