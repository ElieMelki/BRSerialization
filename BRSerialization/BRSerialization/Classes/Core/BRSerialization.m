//
//  BRSerialization.m
//  BRJsonParser
//
//  Created by ELie Melki on 10/11/15.
//  Copyright © 2015 @Me. All rights reserved.
//

#import "BRSerialization.h"

@implementation BRSerialization

+ (id) serializeObject:(id)object
            serialiser:(id<BRSerializer>)serializer
                 error:(__autoreleasing NSError  **)error
{
    @try
    {
        if (object == nil)
            return nil;
        else
            return [serializer serialize:object];
    }
    @catch (NSException *exception)
    {
        if (error != NULL)
        {
            *error = [NSError errorWithDomain:exception.reason code:-1  userInfo:nil] ;
            return nil;
        }
    }
}



+ (id) deserializeData:(id)data
          deserialiser:(id<BRDeserializer>)deserializer
                 error:(__autoreleasing NSError **)error
{
    @try
    {
        if (data == nil)
            return nil;
        else
            return [deserializer deserialize:data];
    }
    @catch (NSException *exception)
    {
        if (error != NULL)
        {
            *error = [NSError errorWithDomain:exception.reason code:-1  userInfo:nil] ;
            return nil;
        }
    }
}


@end
