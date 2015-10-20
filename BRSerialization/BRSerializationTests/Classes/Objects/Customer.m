//
//  Customer.m
//  BRSerialization
//
//  Created by ELie Melki on 10/19/15.
//  Copyright © 2015 Elie Melki. All rights reserved.
//

#import "Customer.h"
#import "OrderedDictionary.h"
@implementation Customer

+ (id<BRISerialization>) serialization
{
    Class clazz = [self class];
    
    NSString *nameProperty = NSStringFromSelector(@selector(name));
    NSString *identifierProperty = NSStringFromSelector(@selector(identifier));
    NSString *websiteURLProperty = NSStringFromSelector(@selector(websiteURL));
    NSString *contactURLProperty = NSStringFromSelector(@selector(contactURL));

    
    BRObjectSerialization *_serialisation = [BRObjectSerialization objectSerializationWith:clazz
                                                                          propertiesMapper:[OrderedDictionary dictionaryWithObjectsAndKeys:
                                                                                            @"id",identifierProperty,
                                                                                            @"name",nameProperty,
                                                                                             @"websiteURL", websiteURLProperty,
                                                                                            @"contactURL", contactURLProperty ,
                                                                                            nil]];
    
    [_serialisation addSerialization:[BRAbsoluteURLSerialization absoluteURLSerialization] forProperty:websiteURLProperty];
    [_serialisation addSerialization:[BRRelativeURLSerialization relativeSerializationWithBaseURL:[NSURL URLWithString:@"http://www.google.com"]]
                         forProperty:contactURLProperty];
    
    return _serialisation;

}

@end
