//
//  KVObjectSerializer.m
//  Rewardisment
//
//  Created by ELie Melki on 10/22/12.
//  Copyright (c) 2012 ELie Melki. All rights reserved.
//

#import "BRObjectSerialization.h"
#import "OrderedDictionary.h"

@interface BRObjectSerialization()

@end

@implementation BRObjectSerialization


+ (instancetype) objectSerializationWith:(Class)theClass
{
    return [[self alloc] initWithClass:theClass] ;
}


+ (instancetype) objectSerializationWith:(Class)theClass combinedWithfirst:(BRObjectSerialization *)first second:(BRObjectSerialization *)second
{
    BRObjectSerialization *o = [[self class] objectSerializationWith:theClass];
    
    NSMutableDictionary *combinedProperties = [NSMutableDictionary dictionaryWithDictionary:first.propertiesMapper];
    [combinedProperties addEntriesFromDictionary:second.propertiesMapper];
    o.propertiesMapper = combinedProperties;
    
    NSMutableDictionary *combinedSerializer = [NSMutableDictionary dictionaryWithDictionary:first.serializers];
    [combinedSerializer addEntriesFromDictionary:second.serializers];
    o.serializers = combinedSerializer;
    
    
    NSMutableDictionary *combinedDeserializers = [NSMutableDictionary dictionaryWithDictionary:first.deserializers];
    [combinedDeserializers addEntriesFromDictionary:second.deserializers];
    o.deserializers = combinedDeserializers;
    
    return o;
}

//------------------------------------
//Init & Dealloc
//------------------------------------
#pragma mark - Init & Dealloc

- (id) initWithClass:(Class)theClass
{
    self = [super init];
    if (self)
    {
        _classType = theClass;
        _serializers = [NSDictionary new];
        _deserializers = [NSDictionary new];
        _propertiesMapper = [NSDictionary new];
    }
    return self;
}


#pragma mark - BRSerializer implementation

- (NSDictionary *) serialize:(id)theObject
{
    if ([theObject isKindOfClass:self.classType])
    {
        OrderedDictionary *_jsonDic = [OrderedDictionary dictionary];
        for (NSString *_property in [self.propertiesMapper allKeys])
        {
            NSString *_key = [self.propertiesMapper objectForKey:_property];
           
            id _value = [theObject valueForKey:_property];
            id<BRSerializer> _serializer = [self.serializers objectForKey:_property];
            
            if (_serializer)
                _value = [_serializer serialize:_value];
            if (_value)
                [_jsonDic setObject:_value forKey:_key];
            else if (_value == nil)
                [_jsonDic setObject:[NSNull null] forKey:_key];
        }
        return _jsonDic;
    }
    else return nil;
    
}


#pragma mark - BRDeSerializer implementation

- (id) deserialize:(NSDictionary *)theData
{
    if ([theData isKindOfClass:[NSDictionary class]])
    {
        NSDictionary *_json = (NSDictionary *)theData;
        id _instance = [[self.classType alloc] init];
       
        for (NSString *_property in [self.propertiesMapper allKeys])
        {      
            NSString *_jsonKey = [self.propertiesMapper objectForKey:_property];
        
            id _propertyValue = [_json objectForKey:_jsonKey];
        
            if (_propertyValue == nil || [_propertyValue isKindOfClass:[NSNull class]])
            {
                //Json key doesnt exits in object
            }
            else
            {
                id _serializer = [self.deserializers objectForKey:_property];
                if (_serializer && _propertyValue)
                    _propertyValue = [_serializer deserialize:_propertyValue];
                
                if (_propertyValue)
                    [_instance setValue:_propertyValue forKey:_property];
                else
                {
                    //Something aint right!!
                }
            }
         
        }
        return _instance;
    }
    else if (theData != nil && ![theData isKindOfClass:[NSNull class]])
    {
        @throw [NSException exceptionWithName:NSInternalInconsistencyException
                                       reason:[NSString stringWithFormat:@"Expected an NSDictionary [%@] found %@ in [%@]", self.classType, [theData class],theData ]
                                     userInfo:nil];
    }
    return nil;
}


@end
