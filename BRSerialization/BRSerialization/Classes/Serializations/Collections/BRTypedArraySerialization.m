//
//  KVTypedArraySerializer.m
//  Rewardisment
//
//  Created by ELie Melki on 10/22/12.
//  Copyright (c) 2012 ELie Melki. All rights reserved.
//

#import "BRTypedArraySerialization.h"

@interface BRTypedArraySerialization()

@property (nonatomic, retain) id<BRSerializer,BRDeserializer> valueSerialization;

@end

@implementation BRTypedArraySerialization

@synthesize valueSerialization;

+ (instancetype) typedArraySerializationWith:(id<BRSerializer,BRDeserializer>)serialisation
{
    return [[self alloc] initWithValueSerialization:serialisation] ;
}


//------------------------------------
//Init & Dealloc
//------------------------------------
#pragma mark - Init & Dealloc

- (id) initWithValueSerialization:(id<BRSerializer,BRDeserializer>)serializaton
{
    self = [super init];
    if (self)
    {
        self.valueSerialization = serializaton;
    }
    return self;
}




#pragma mark - BRSerializer implementation

- (NSArray *) serialize:(NSArray *)theObject
{
    if ([theObject isKindOfClass:[NSArray class]])
    {
        NSMutableArray *_r = [NSMutableArray array];
        NSArray *_data = (NSArray *)theObject;
        for (id _elem in _data)
        {
            id _serializedElement = [valueSerialization serialize:_elem];
            [_r addObject:_serializedElement];
        }
        return _r;
    }
    else
    {
        //Todo throw an exception;
        return nil;
    }
}

#pragma mark - BRDeserializer implementation

- (NSArray *) deserialize:(NSArray *)theData
{
    if ([theData isKindOfClass:[NSArray class]])
    {
        NSMutableArray *_r = [NSMutableArray array];
        NSArray *_data = (NSArray *)theData;
        for (id _elem in _data)
        {
            id _deserializedElement = [valueSerialization deserialize:_elem];
            [_r addObject:_deserializedElement];
        }
        return _r;
    }
    else  if (theData != nil && ![theData isKindOfClass:[NSNull class]])
    {
        @throw [NSException exceptionWithName:NSInternalInconsistencyException
                                       reason:[NSString stringWithFormat:@"Expected an array  for %@ found [%@]", theData, [theData class]]
                                     userInfo:nil];
    }
    return nil;
}


@end
