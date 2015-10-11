//
//  BRLocaleSerialization.m
//  BRJsonParser
//
//  Created by ELie Melki on 10/4/15.
//  Copyright © 2015 Elie Melki. All rights reserved.
//

#import "BRLocaleSerialization.h"

@implementation BRLocaleSerialization

+ (instancetype) localeSerialization
{
    return [[self alloc] init] ;
}


#pragma mark - BRSerializer implementation

- (NSString *) serialize:(NSLocale *)theObject
{
    if ([theObject isKindOfClass:[NSLocale class]])
    {
        NSLocale *_locale = (NSLocale *)theObject;
        return _locale.localeIdentifier;
    }
    else
        return nil;

    
}

#pragma mark - BRDeserializer implementation

- (NSLocale *) deserialize:(NSString *)theData
{
    if ([theData isKindOfClass:[NSString class]])
        return [[NSLocale alloc] initWithLocaleIdentifier:theData] ;
    else  if (theData != nil && ![theData isKindOfClass:[NSNull class]])
        @throw [NSException exceptionWithName:NSInternalInconsistencyException
                                       reason:[NSString stringWithFormat:@"Expected an NSString for %@ found %@", theData, [theData class]]
                                     userInfo:nil];
    return nil;
}


@end
