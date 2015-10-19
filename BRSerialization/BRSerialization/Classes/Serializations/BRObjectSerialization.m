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

@property (nonatomic, strong) NSMutableDictionary *serialization;
@property (nonatomic, strong) NSDictionary *propertiesMapper;

@end

@implementation BRObjectSerialization


+ (instancetype) objectSerializationWith:(Class)theClass propertiesMapper:(NSDictionary *)propertiesMapper
{
    return [[self alloc] initWithClass:theClass propertiesMapper:propertiesMapper] ;
}


+ (instancetype) objectSerializationWith:(Class)theClass combinedWithfirst:(BRObjectSerialization *)first second:(BRObjectSerialization *)second
{
    
    NSMutableDictionary *combinedProperties = [NSMutableDictionary dictionaryWithDictionary:first.propertiesMapper];
    [combinedProperties addEntriesFromDictionary:second.propertiesMapper];
    BRObjectSerialization *o = [[self class] objectSerializationWith:theClass propertiesMapper:combinedProperties];
    
    
    NSMutableDictionary *combinedSerializations = [NSMutableDictionary dictionaryWithDictionary:first.serialization];
    [combinedSerializations addEntriesFromDictionary:second.serialization];
    o.serialization = combinedSerializations;
    
    return o;
}

//------------------------------------
//Init & Dealloc
//------------------------------------
#pragma mark - Init & Dealloc

- (id) initWithClass:(Class)theClass propertiesMapper:(NSDictionary *)propertiesMapper
{
    self = [super init];
    if (self)
    {
        _classType = theClass;
        _serialization = [NSMutableDictionary dictionary];
        _propertiesMapper = propertiesMapper;
    }
    return self;
}

#pragma mark - Public

- (void) addSerialization:(id<BRISerialization>)serialization forProperty:(NSString *)property
{
    [_serialization setObject:serialization forKey:property];
}

- (void) removeSerializationForProperty:(NSString *)property
{
    [_serialization removeObjectForKey:property];
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
            id<BRSerializer> _serializer = [self.serialization objectForKey:_property];
            
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
                id _serializer = [self.serialization objectForKey:_property];
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
