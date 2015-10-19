//
//  BROrderedSetSerialization.h
//  BRJsonParser
//
//  Created by ELie Melki on 10/4/15.
//  Copyright © 2015 Elie Melki. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "BRISerialization.h"

@interface BROrderedSetSerialization : NSObject<BRISerialization>

+ (instancetype)  orderedSetSerialization;

- (NSArray *) serialize:(NSOrderedSet *)theObject;
- (NSOrderedSet *) deserialize:(NSArray *)theData;

@end
