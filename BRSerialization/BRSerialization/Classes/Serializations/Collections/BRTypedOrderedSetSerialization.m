//
//  BRTypedOrderedSetSerialization.m
//  BRJsonParser
//
//  Created by ELie Melki on 10/4/15.
//  Copyright © 2015 Elie Melki. All rights reserved.
//

#import "BRTypedOrderedSetSerialization.h"
#import "BRTypedArraySerialization.h"


@interface BRTypedOrderedSetSerialization()

@property (nonatomic, strong) BRTypedArraySerialization *typedArraySerialization;

@end

@implementation BRTypedOrderedSetSerialization

+ (instancetype) typedOrderedSetSerializationWith:(id<BRSerializer,BRDeserializer>)theSerializer
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

- (NSArray *) serialize:(NSOrderedSet *)theObject;
{
    if ([theObject isKindOfClass:[NSOrderedSet class]])
    {
        NSOrderedSet *_data = (NSOrderedSet *)theObject;
        return [self.typedArraySerialization serialize:[_data array]];
    }
    else
    {
        //Todo throw an exception;
        return nil;
    }
}

#pragma mark - BRDeserializer implementation

- (NSOrderedSet *) deserialize:(NSArray *)theData;
{
    NSArray *data = [self.typedArraySerialization deserialize:theData];
    if (data != nil)
    {
        return [NSOrderedSet orderedSetWithArray:data];
    }
    else
    {
        return nil;
    }
}


@end