//
//  BRTypedSetSerialization.m
//  LXProxSeeSDK
//
//  BRJsonParser
//
//  Created by ELie Melki on 10/4/15.
//  Copyright © 2015 Elie Melki. All rights reserved.
//

#import "BRTypedSetSerialization.h"
#import "BRTypedArraySerialization.h"

@interface BRTypedSetSerialization()

@property (nonatomic, strong) BRTypedArraySerialization *typedArraySerialization;

@end

@implementation BRTypedSetSerialization

+ (instancetype) typedSetSerializationWith:(id<BRSerializer,BRDeserializer>)theSerializer
{
    return [[self alloc] initWithValueSerializer:theSerializer] ;
}


//------------------------------------
//Init & Dealloc
//------------------------------------
#pragma mark - Init & Dealloc

- (id) initWithValueSerializer:(id<BRSerializer,BRDeserializer>)theValueSerializer
{
    self = [super init];
    if (self)
    {
        self.typedArraySerialization = [BRTypedArraySerialization typedArraySerializationWith:theValueSerializer];
    }
    return self;
}



#pragma mark - BRSerializer implementation

- (NSArray *) serialize:(NSSet *)theObject
{
    if ([theObject isKindOfClass:[NSSet class]])
    {
        NSSet *_data = (NSSet *)theObject;
        return [self.typedArraySerialization serialize:[_data allObjects]];
    }
    else
    {
        //Todo throw an exception;
        return nil;
    }
}


#pragma mark - BRDeserializer implementation

- (NSSet *) deserialize:(NSArray *)theData
{
    NSArray *data = [self.typedArraySerialization deserialize:theData];
    if (data != nil) {
        return [NSSet setWithArray:data];
    }else
    {
        return nil;
    }
}

@end
