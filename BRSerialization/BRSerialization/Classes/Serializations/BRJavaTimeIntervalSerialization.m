//
//  BRJavaTimeSerialization.m
//  BRJsonParser
//
//  Created by ELie Melki on 10/4/15.
//  Copyright © 2015 Elie Melki. All rights reserved.
//

#import "BRJavaTimeIntervalSerialization.h"

@implementation BRJavaTimeIntervalSerialization

+ (instancetype) javaTimeIntervalSerialization
{
    return [[self alloc] init];
}


#pragma mark - BRSerializer implementation

- (NSString *) serialize:(NSDate *)theObject
{
    if ([theObject isKindOfClass:[NSDate class]])
    {
        NSDate *date = (NSDate *)theObject;
        NSTimeInterval timeInterval = [date timeIntervalSince1970] * 1000;
        long long llTimeInterval = (long long)timeInterval;
        NSString *v = [NSString stringWithFormat:@"%@",  [NSNumber numberWithLongLong:llTimeInterval]];
        return v;
    }
    else
        return nil;
    
    
}

#pragma mark - BRDeserializer implementation

- (NSDate *) deserialize:(NSString *)theData
{
    if ([theData isKindOfClass:[NSString class]])
    {
        NSString *data = (NSString *)theData;
        long long llDate =  [data longLongValue];
        NSTimeInterval timeInterval = llDate/ 1000;
        
        NSDate * date = [NSDate dateWithTimeIntervalSince1970:timeInterval];
        return date;
    }
    else if (theData != nil && ![theData isKindOfClass:[NSNull class]])
        @throw [NSException exceptionWithName:NSInternalInconsistencyException
                                       reason:[NSString stringWithFormat:@"Expected an NSString for %@ found %@",theData, [theData class]]
                                     userInfo:nil];
    return nil;
}


@end