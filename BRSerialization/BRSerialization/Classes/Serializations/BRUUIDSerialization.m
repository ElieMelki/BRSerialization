//
//  BRUUIDSerialization.m
//  BRJsonParser
//
//  Created by ELie Melki on 10/4/15.
//  Copyright © 2015 Elie Melki. All rights reserved.
//

#import "BRUUIDSerialization.h"

@implementation BRUUIDSerialization

+ (instancetype) UUIDSerialization
{
    return [[self alloc] init];
}

#pragma mark - BRSerializer implementation

- (NSString *) serialize:(NSUUID *)theObject
{
    if ([theObject isKindOfClass:[NSUUID class]])
    {
        NSUUID *uuid = (NSUUID *)theObject;
        return uuid.UUIDString;
    }
    else
        return nil;
    
    
}

#pragma mark - BRDeserializer implementation

- (NSUUID *) deserialize:(NSString *)theData
{
    if ([theData isKindOfClass:[NSString class]])
        return [[NSUUID alloc] initWithUUIDString:theData];
    else  if (theData != nil && ![theData isKindOfClass:[NSNull class]])
        @throw [NSException exceptionWithName:NSInternalInconsistencyException
                                       reason:[NSString stringWithFormat:@"Expected an NSString for %@ found %@", theData, [theData class]]
                                     userInfo:nil];
    return nil;
}

@end