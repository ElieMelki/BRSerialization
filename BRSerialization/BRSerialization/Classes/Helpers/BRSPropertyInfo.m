//
//  NSObject+Properties.m
//  Rewardisment
//
//  Created by ELie Melki on 10/22/12.
//  Copyright (c) 2012 ELie Melki. All rights reserved.
//

#import "BRSPropertyInfo.h"

@implementation BRClassProperty

@synthesize propertyName,propertyType;

- (id) initWithPropertyName:(NSString *)thePropertyName propertyType:(NSString *)thePropertyType
{
    self = [super init];
    if (self)
    {
        propertyName = thePropertyName;
        propertyType = thePropertyType;;
    }
    return self;
}


@end


@interface BRSPropertyInfo()

@property (nonatomic) Class class;
@property (nonatomic, strong) NSMutableDictionary *propertiesDictionary;

@end

@implementation BRSPropertyInfo

+ (instancetype) propertyInfoWithClass:(Class)class
{
    return [[self alloc] initWithClass:class];
}

- (id) initWithClass:(Class)class
{
    self = [super init];
    if (self)
    {
        self.class = class;
        self.propertiesDictionary = [self getProperties];
    }
    return self;
}

#pragma mark - Public
- (NSArray *) properties
{
    return [self.propertiesDictionary allValues];
}

- (BRClassProperty *) propertyWithName:(NSString *)theName
{
    return [self.propertiesDictionary objectForKey:theName];
}


#pragma mark - Private

- (NSMutableDictionary *) getProperties
{
    NSMutableDictionary *props = [NSMutableDictionary dictionary];
    unsigned int outCount, i;
    objc_property_t *nproperties = class_copyPropertyList([self class], &outCount);
    for(i = 0; i < outCount; i++)
    {
        
        objc_property_t _property = nproperties[i];
        BRClassProperty *_kvProperty = [self getPropertyFor:_property];
        if (_kvProperty)
            [props setObject:_kvProperty forKey:_kvProperty.propertyName];
    }
    free(nproperties);
    return props;
}

- (BRClassProperty *) getPropertyFor:(objc_property_t)theProperty
{
    objc_property_t _property = theProperty;
    const char *_propName = property_getName(_property);
    
    if(_propName)
    {
        const char *_propType = getPropertyType(_property);
        NSString *_propertyName = [NSString stringWithCString:_propName encoding:NSUTF8StringEncoding];
        NSString *_propertyType =  [NSString stringWithCString:_propType  encoding:NSUTF8StringEncoding];
        
        return [[BRClassProperty alloc] initWithPropertyName:_propertyName propertyType:_propertyType];
    }
    return nil;
}



static const char *getPropertyType(objc_property_t property)
{
    const char *attributes = property_getAttributes(property);
    char buffer[1 + strlen(attributes)];
    strcpy(buffer, attributes);
    char *state = buffer, *attribute;
    while ((attribute = strsep(&state, ",")) != NULL) {
        if (attribute[0] == 'T') {
            return (const char *)[[NSData dataWithBytes:(attribute + 3) length:strlen(attribute) - 4] bytes];
        }
    }
    return "@";
}

@end

@implementation NSObject (BRClassProperty)

- (NSArray *) properties
{
    return [[BRSPropertyInfo propertyInfoWithClass:[self class]] properties];
}

- (BRClassProperty *) propertyWithName:(NSString *)theName
{
    return [[BRSPropertyInfo propertyInfoWithClass:[self class]] propertyWithName:theName];
}
@end
