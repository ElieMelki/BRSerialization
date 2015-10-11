//
//  BRUUIDSerialization.h
//  BRJsonParser
//
//  Created by ELie Melki on 1/31/15.
//  Copyright (c) 2015 My. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "BRSerializer.h"
#import "BRDeserializer.h"

@interface BRUUIDSerialization : NSObject<BRSerializer,BRDeserializer>

+ (instancetype) UUIDSerialization;

@end