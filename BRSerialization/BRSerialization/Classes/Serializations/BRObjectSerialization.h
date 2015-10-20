//
//  KVObjectSerializer.h
//  Rewardisment
//
//  Created by ELie Melki on 10/22/12.
//  Copyright (c) 2012 ELie Melki. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "BRISerialization.h"

@interface BRObjectSerialization : NSObject<BRISerialization>

+ (instancetype) objectSerializationWith:(Class)theClass propertiesMapper:(NSDictionary *)propertiesMapper;

+ (instancetype) objectSerializationWith:(Class)theClass combinedWithfirst:(BRObjectSerialization *)objectSerialization second:(BRObjectSerialization *)objectSerialization;

- (id) initWithClass:(Class)theClass propertiesMapper:(NSDictionary *)propertiesMapper;

@property (nonatomic, readonly) Class classType;

- (void) addSerialization:(id<BRISerialization>)serialization forProperty:(NSString *)property;
- (void) removeSerializationForProperty:(NSString *)property;

- (NSDictionary *) serialize:(id)theObject;
- (id) deserialize:(NSDictionary *)theData;

@end
