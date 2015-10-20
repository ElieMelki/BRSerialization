# BRSerialization SDK

The BRSerialization SDK allow you to serialize and deserialise complex objects to basic data type (that can be valid to be a JSON objects or a plist) back and forth.

BRSerialization SDK has an extension to for direct serialization from JSON data to complex object back and forth. It can aslo be a basic entry for SOAP.

## Table of Contents

* [How it works?](#how-it-works)
* [Object Serialization](#object-serialization)
* [Installation](#installation)


## <a name="how-it-works"></a>How it works?


The main compoment of the SDK is Serializer and Deserializer and ISerialization.

```
@protocol BRDeserializer <NSObject>
- (id) deserialize:(id)theData;
@end

@protocol BRSerializer <NSObject>
- (id) serialize:(id)theObject;
@end

@protocol BRISerialization <BRDeserializer,BRSerializer>
@end

```

To create a serializer/deserializer, you create an object that conforms to either BRDeserializer,BRSerializer protocols or both by conforming to BRISerialization protocol. 

You override these methods

```
- (id) serialize:(id)theObject;
- (id) deserialize:(id)theData;
```

Take a look at the example below. Here we need to convert a complex NSUUID object to a basic data type where in this case is going to be an NSString. 

The serialize method expect to have an NSSUUID that gets converted to NSString while The deserialize method expect an NSString that gets converted to NSSUUID.

To illustrate lets take a look at the implementation of NSSUIDSerialization.

```
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
```

Once you have the serialization you use BRSerializationFacade to do the job for you. 

BRSerializationFacade has the following methods

```
+ (id) serializeObject:(id)object
            serialiser:(id<BRSerializer>)serializer
                 error:(__autoreleasing NSError **)error;

+ (id) deserializeData:(id)data
          deserialiser:(id<BRDeserializer>)deserializer
             error:(__autoreleasing NSError **)error;
                     
```


```
NSSUIDSerialization *serialization = [NSSUIDSerialization new];

//serialise NUUID to NSString
NSUUID *uuid = [NSUUID UUID];
NSString *uuidString = [BRSerializationFacade serializeObject:uuid serialiser:serialization error:nil];

//Deserialize NSString to NSUUID
NSUUID *newuuid = [BRSerializationFacade deserializeData:uuidString serialiser:serialization error:nil];
```

The SDK already comes with some handy Serializations classes for basic needs.  Major one BRObjectSerialization for object serialization, BRTypedArraySerialization for array of objects, etc... 

You can still add your own for any none handled complex objects.


## <a name="Object Serialization"></a>Object Serialization

BRObjectSerialization class converts complex objects to NSDictionary.

Take an example the Customer Object

```
@interface Customer : NSObject

@property (nonatomic, strong) NSString *identifier;
@property (nonatomic, strong) NSString *name;
@property (nonatomic, strong) NSURL *websiteURL;
@property (nonatomic, strong) NSURL *contactURL;

@end
```
Serializing an instance with the following value

```
   Customer *c = [[Customer alloc] init];
    c.identifier = @"1234";
    c.name = @"name";
    c.websiteURL = [NSURL URLWithString:@"http://www.google.com"];
    c.contactURL = [NSURL URLWithString:@"http://www.google.com/ContactUs"];

```

will result in the following NSDictionary

```
@{
	"id" : "1234",
    "name" : "name",
    "websiteURL" : "http://www.google.com",
    "contactURL" : "/ContactUs"
}

```

As you can see the Customer Object is transformed to NSDictionary. Properties with basic data types like identifier and name stays with same data type. Properties with NSURL complex datatype like websiteURL and contactURL ended up being converted to NSString.

 Deserializing The NSDictionary result will convert it back to complex object. 

This How to configure BRObjectSerialization to achieve the above result.

```
@implementation Customer

+ (BRObjectSerialization *) serialization
{
    Class clazz = [Customer class];
    
    NSString *nameProperty = NSStringFromSelector(@selector(name));
    NSString *identifierProperty = NSStringFromSelector(@selector(identifier));
    NSString *websiteURLProperty = NSStringFromSelector(@selector(websiteURL));
    NSString *contactURLProperty = NSStringFromSelector(@selector(contactURL));

    
    BRObjectSerialization *_serialisation = [BRObjectSerialization objectSerializationWith:clazz
                                             propertiesMapper:[OrderedDictionary dictionaryWithObjectsAndKeys:
                                                                                            @"id",identifierProperty,
                                                                                            @"name",nameProperty,
                                                                                            @"websiteURL", websiteURLProperty,
                                                                                            @"contactURL", contactURLProperty,
                                                                                            nil]];
    
    [_serialisation addSerialization:[BRAbsoluteURLSerialization absoluteURLSerialization] forProperty:websiteURLProperty];
    [_serialisation addSerialization:[BRRelativeURLSerialization relativeSerializationWithBaseURL:
    					  	[NSURL URLWithString:@"http://www.google.com"]]
                         forProperty:contactURLProperty];
    
    return _serialisation;

}
@end
```

BRObjectSerialization expect you to identify the class of the object and to provide a properties mapper. You map property you are interested to their specific key. You see that I have NSStringFromSelector just to keep things typed. In addition, each property that require special serialization you need to pass that to BRObjectSerialization by calling addSerialization.

If Customer has a property named owner of type Owner class.You will need a BRObjectSerialization for Owner that you pass it to Customer BRObjectSerialization serialization.

Take the above example and see the added code.

```
@interface Owner : NSObject
@property (nonatomic, strong) NSString *phoneNumber;

@end

@interface Customer : NSObject
...
@property (nonatomic,strong) Owner name

@end
```

Owner BRObjectSerialization

```
@implementation Owner

+ (BRObjectSerialization *) serialization
{
    Class clazz = [Owner class];
    
    NSString *phoneNumberProperty = NSStringFromSelector(@selector(phoneNumber));

    
    BRObjectSerialization *_serialisation = [BRObjectSerialization objectSerializationWith:clazz
       propertiesMapper:[OrderedDictionary dictionaryWithObjectsAndKeys:
       			@"phoneNumberProperty",phoneNumberProperty,
    return _serialisation;

}
@end
```

Customer BRObjectSerialization
```
+ (BRObjectSerialization *) serialization
{
    Class clazz = [Customer class];
    
    ...
    NSString *onwerProperty = NSStringFromSelector(@selector(owner));

    
    BRObjectSerialization *_serialisation = [BRObjectSerialization objectSerializationWith:clazz
                  propertiesMapper:[OrderedDictionary dictionaryWithObjectsAndKeys:
                                              ...
                                              @"owner", onwerProperty,
                                               nil]];
    
    ...
    [_serialisation addSerialization:[Owner serialization]
                         forProperty:onwerProperty];
    
    return _serialisation;

}
@end

```


## <a name="installation"></a>Installation

For now you can download the project and add the BRSerialization project as a sub project. You can also use cocoapod referring  git url directly. Later we will push the library to public cocoapod repo. 

```
pod BRSerialization, git => https://github.com/eliemelki/iOS-Serialization
```




