//
//  KVTypedArraySerializer.h
//  Rewardisment
//
//  Created by ELie Melki on 10/22/12.
//  Copyright (c) 2012 ELie Melki. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "BRSerializer.h"
#import "BRDeserializer.h"

@interface BRTypedArraySerialization : NSObject<BRSerializer,BRDeserializer>

+ (instancetype) typedArraySerializationWith:(id<BRDeserializer,BRDeserializer>)serialisation;

- (id) initWithValueSerialization:(id<BRDeserializer,BRDeserializer>)serializaton;


- (NSArray *) serialize:(NSArray *)theObject;
- (NSArray *) deserialize:(NSArray *)theData;

@end
