//
//  BRTypedDictionarySerialization.m
//  BRJsonParser
//
//  Created by ELie Melki on 10/4/15.
//  Copyright © 2015 Elie Melki. All rights reserved.
//

#import "BRTypedDictionarySerialization.h"

@interface BRTypedDictionarySerialization()

@property (nonatomic, retain) id<BRDeserializer,BRSerializer> valueSerialization;;

@end

@implementation BRTypedDictionarySerialization

@synthesize valueSerialization;

+ (instancetype) typedDictionarySerializationWith:(id<BRDeserializer,BRSerializer>)serialization;
{
    return [[self alloc] initWithSerialization:serialization];
}

- (id) initWithSerialization:(id<BRDeserializer,BRSerializer>)serialization
{
    self = [super init];
    if (self)
    {
        self.valueSerialization = serialization;
    }
    return self;
}

#pragma mark - BRSerializer implementation

- (NSDictionary *) serialize:(NSDictionary *)theObject
{
    if ([theObject isKindOfClass:[NSDictionary class]])
    {
        NSMutableDictionary *_r = [NSMutableDictionary dictionary];
        NSDictionary *_data = (NSDictionary *)theObject;
        for (NSString *_key in [_data allKeys])
        {
            id _value = [_data objectForKey:_key];
            id _serializedElement = [self.valueSerialization serialize:_value];
            [_r setObject:_serializedElement forKey:_key];
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


- (NSDictionary *) deserialize:(NSDictionary *)theData
{
    if ([theData isKindOfClass:[NSDictionary class]])
    {
        NSMutableDictionary *_r = [NSMutableDictionary dictionary];
        NSDictionary *_data = (NSDictionary *)theData;
        for (NSString *_key in [_data allKeys])
        {
            id _value = [_data objectForKey:_key];
            id _deserializedElement = [self.valueSerialization deserialize:_value];
            [_r setObject:_deserializedElement forKey:_key];
        }
                return _r;
    }
    else  if (theData != nil && ![theData isKindOfClass:[NSNull class]])
    {
        @throw [NSException exceptionWithName:NSInternalInconsistencyException
                                       reason:[NSString stringWithFormat:@"Expected a dictionary"]
                                     userInfo:nil];
    }
    return nil;
}

@end


