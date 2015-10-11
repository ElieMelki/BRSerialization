//
//  BRRelativeURLSerialization.m
//  BRJsonParser
//
//  Created by ELie Melki on 10/4/15.
//  Copyright © 2015 Elie Melki. All rights reserved.
//

#import "BRRelativeURLSerialization.h"

@interface BRRelativeURLSerialization()

@property (nonatomic,copy) NSURL *baseURL;

@end

@implementation BRRelativeURLSerialization

+ (instancetype) relativeSerializationWithBaseURL:(NSURL *)theBaseURL
{
    return [[self alloc] initWithBaseURL:theBaseURL] ;
}

@synthesize baseURL;

- (id) initWithBaseURL:(NSURL *)theBaseURL
{
    self = [super init];
    
    if (self)
    {
        self.baseURL = theBaseURL;
    }
    return self;
}



#pragma mark - BRSerializer implementation

- (NSString *) serialize:(NSURL *)theObject
{
    if ([theObject isKindOfClass:[NSURL class]])
    {
        NSURL *_URL = (NSURL *)theObject;
        return [_URL relativeString];
    }
    else
        //Todo  probably throw an exception;
        return nil;
    
}

#pragma mark - BRDeserializer implementation

- (NSURL *) deserialize:(NSString *)theData
{
    if ([theData isKindOfClass:[NSString class]])
        return [NSURL URLWithString:theData relativeToURL:self.baseURL];
    else  if (theData != nil && ![theData isKindOfClass:[NSNull class]])
        @throw [NSException exceptionWithName:NSInternalInconsistencyException
                                       reason:[NSString stringWithFormat:@"Expected an NSString for %@", theData]
                                     userInfo:nil];
    return nil;
}

@end
