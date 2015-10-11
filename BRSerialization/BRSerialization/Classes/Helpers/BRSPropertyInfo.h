//
//  NSObject+Properties.h
//
//  Created by ELie Melki on 10/22/12.
//  Copyright (c) 2012 ELie Melki. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <objc/runtime.h>


@interface BRClassProperty : NSObject

@property (nonatomic,readonly) NSString *propertyType;
@property (nonatomic,readonly) NSString *propertyName;

@end


@interface BRSPropertyInfo : NSObject

+ (instancetype) propertyInfoWithClass:(Class)class;

- (id) initWithClass:(Class)class;

- (NSArray *) properties;
- (BRClassProperty *) propertyWithName:(NSString *)theName;

@end



@interface NSObject (BRClassProperty)

- (NSArray *) properties;
- (BRClassProperty *) propertyWithName:(NSString *)theName;

@end