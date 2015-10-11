//
//  BRAbsoluteURLSerialization.m
//  BRJsonParser
//
//  Created by ELie Melki on 10/4/15.
//  Copyright © 2015 Elie Melki. All rights reserved.
//

#import "BRAbsoluteURLSerialization.h"

@implementation BRAbsoluteURLSerialization

+ (instancetype) absoluteURLSerialization
{
    return [[self alloc] init] ;
}


#pragma mark - BRSerializer implementation

- (NSString *) serialize:(NSURL *)theObject
{
    if ([theObject isKindOfClass:[NSURL class]])
    {
        NSURL *_URL = (NSURL *)theObject;
        return [_URL absoluteString];
    }
    else
        return nil;

}

#pragma mark - BRDeserializer implementation

- (NSURL *) deserialize:(NSString *)theData
{
    if ([theData isKindOfClass:[NSString class]])
        return [NSURL URLWithString:theData];
    else if (theData != nil && ![theData isKindOfClass:[NSNull class]])
        @throw [NSException exceptionWithName:NSInternalInconsistencyException
                                       reason:[NSString stringWithFormat:@"Expected an NSString for %@", theData]
                                     userInfo:nil];
    return nil;
}


@end
