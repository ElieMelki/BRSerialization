//
//  Customer.m
//  BRSerialization
//
//  Created by ELie Melki on 10/19/15.
//  Copyright © 2015 Elie Melki. All rights reserved.
//

#import "Customer.h"

@implementation Customer

+ (id<BRISerialization>) serialization
{
    Class clazz = [self class];
    
    NSString *_nameProperty = NSStringFromSelector(@selector(name));
    NSString *_identifierProperty = NSStringFromSelector(@selector(identifier));
    NSString *_websiteURLProperty = NSStringFromSelector(@selector(websiteURL));
    NSString *_contactURLProperty = NSStringFromSelector(@selector(contactURL));
   
    
    BRObjectSerialization *_serialisation = [BRObjectSerialization objectSerializationWith:clazz
                                                                          propertiesMapper:@{
                                                                                             _identifierProperty : @"id",
                                                                                             _nameProperty : @"name",
                                                                                             _websiteURLProperty : @"websiteURL",
                                                                                             _contactURLProperty : @"contactURL"
                                                                                             
                                                                                             }];
    [_serialisation addSerialization:[BRAbsoluteURLSerialization absoluteURLSerialization] forProperty:_websiteURLProperty];
    [_serialisation addSerialization:[BRRelativeURLSerialization relativeSerializationWithBaseURL:[NSURL URLWithString:@"http://www.google.com"]]
                         forProperty:_contactURLProperty];
    
    return _serialisation;

}

@end
