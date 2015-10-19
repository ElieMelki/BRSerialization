//
//  KVTypedArraySerializer.h
//  Rewardisment
//
//  Created by ELie Melki on 10/22/12.
//  Copyright (c) 2012 ELie Melki. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "BRISerialization.h"

@interface BRTypedArraySerialization : NSObject<BRISerialization>

+ (instancetype) typedArraySerializationWith:(id<BRDeserializer,BRDeserializer>)serialisation;

- (id) initWithValueSerialization:(id<BRDeserializer,BRDeserializer>)serializaton;


- (NSArray *) serialize:(NSArray *)theObject;
- (NSArray *) deserialize:(NSArray *)theData;

@end
