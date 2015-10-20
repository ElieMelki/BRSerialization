//
//  BRTypedOrderedSetSerialization.h
//  BRJsonParser
//
//  Created by ELie Melki on 10/4/15.
//  Copyright © 2015 Elie Melki. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "BRTypedArraySerialization.h"

@interface BRTypedOrderedSetSerialization : NSObject<BRISerialization>

+ (instancetype) typedOrderedSetSerializationWith:(id<BRSerializer,BRDeserializer>)theSerializer;

- (id) initWithValueSerializer:(id<BRSerializer,BRDeserializer>)theValueSerializer;

- (NSArray *) serialize:(NSOrderedSet *)theObject;
- (NSOrderedSet *) deserialize:(NSArray *)theData;

@end



