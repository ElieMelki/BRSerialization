//
//  NSJSONSerialization+BRS.m
//  BRJsonParser
//
//  Created by ELie Melki on 10/11/15.
//  Copyright © 2015 @Me. All rights reserved.
//

#import "NSJSONSerialization+BRS.h"
#import "BRSerializationFacade.h"

@implementation NSJSONSerialization (BRS)

+ (NSData *) dataWithJSONObject:(id)obj
                     serializer:(id<BRSerializer>)serializer
                        options:(NSJSONWritingOptions)opt
                          error:(__autoreleasing NSError **)error
{
    NSError *serializationError = nil;
    
    id _primitive = [BRSerializationFacade serializeObject:obj
                                                       serialiser:serializer
                                                            error:&serializationError];
    
    if (serializationError)
    {
        if (error)
            *error = serializationError;
        
        return nil;
    }
    else
    {
        return [self dataWithJSONObject:_primitive options:opt error:error];
    }
}

+ (id) JSONObjectWithData:(NSData *)data
             deserializer:(id<BRDeserializer>)deserializer
                  options:(NSJSONReadingOptions)opt
                    error:(NSError **)error
{
    NSError *jsonError = NULL;
    id _primitive = [self JSONObjectWithData:data options:opt error:&jsonError];
    
    if (jsonError) {
        if (error)
            *error = jsonError;
        
        return nil;
    }
    else
    {
        return [BRSerializationFacade deserializeData:_primitive deserialiser:deserializer error:error];
    }
}



@end
