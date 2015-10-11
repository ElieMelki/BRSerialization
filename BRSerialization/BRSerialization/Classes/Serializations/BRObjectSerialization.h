//
//  KVObjectSerializer.h
//  Rewardisment
//
//  Created by ELie Melki on 10/22/12.
//  Copyright (c) 2012 ELie Melki. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "BRSerializer.h"
#import "BRDeserializer.h"


@interface BRObjectSerialization : NSObject<BRSerializer, BRDeserializer>

+ (instancetype) objectSerializationWith:(Class)theClass;

+ (instancetype) objectSerializationWith:(Class)theClass combinedWithfirst:(BRObjectSerialization *)objectSerialization second:(BRObjectSerialization *)objectSerialization;

- (id) initWithClass:(Class)theClass;

@property (nonatomic, readonly) Class classType;

@property (nonatomic, strong) NSDictionary *propertiesMapper;
@property (nonatomic, strong) NSDictionary *serializers;
@property (nonatomic, strong) NSDictionary *deserializers;

- (NSDictionary *) serialize:(id)theObject;
- (id) deserialize:(NSDictionary *)theData;

@end
