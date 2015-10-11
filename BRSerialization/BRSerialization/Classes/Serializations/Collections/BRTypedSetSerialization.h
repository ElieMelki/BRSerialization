//
//  BRTypedSetSerialization.h
//  BRJsonParser
//
//  Created by ELie Melki on 10/4/15.
//  Copyright © 2015 Elie Melki. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "BRObjectSerialization.h"

@interface BRTypedSetSerialization : NSObject<BRSerializer,BRDeserializer>

+ (instancetype) typedSetSerializationWith:(id<BRSerializer,BRDeserializer>)theSerializer;

- (id) initWithValueSerializer:(id<BRSerializer,BRDeserializer>)theValueSerializer;

- (NSArray *) serialize:(NSSet *)theObject;
- (NSSet *) deserialize:(NSArray *)theData;

@end
