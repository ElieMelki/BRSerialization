//
//  BRSerializationTests.m
//  BRSerializationTests
//
//  Created by ELie Melki on 10/11/15.
//  Copyright © 2015 Elie Melki. All rights reserved.
//

#import <XCTest/XCTest.h>
#import <BRSerialization/BRSerialization.h>
#import "Customer.h"

@interface BRSimpleTests : XCTestCase

@end

@implementation BRSimpleTests

- (void)setUp {
    [super setUp];
    // Put setup code here. This method is called before the invocation of each test method in the class.
}

- (void)tearDown {
    // Put teardown code here. This method is called after the invocation of each test method in the class.
    [super tearDown];
}

- (void)testDeserialize {
    
    Customer *c = [self deserializeSample];
    XCTAssertTrue([c.identifier isEqualToString:@"1234"]);
    XCTAssertTrue([c.name isEqualToString:@"name"]);
    XCTAssertTrue([[c.websiteURL absoluteString] isEqualToString:@"http://www.google.com"]);
    XCTAssertTrue([[c.contactURL absoluteString] isEqualToString:@"http://www.google.com/ContactUs"]);
    
}

- (void)testSerialize {
    
    NSData *data = [self serializeSample];
    
    NSString *path = [[NSBundle bundleForClass:[self class]] pathForResource:@"customer" ofType:@"json"];
    NSData *fileData = [NSData dataWithContentsOfFile:path];
    
    NSString *serialized = [[[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding] stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
    
    NSString *file = [[NSString alloc] initWithData:fileData encoding:NSUTF8StringEncoding];
    NSArray* words = [file componentsSeparatedByCharactersInSet :[NSCharacterSet whitespaceAndNewlineCharacterSet]];
    file = [words componentsJoinedByString:@""];

    
    XCTAssertTrue([serialized isEqualToString:file]);
    
}

- (void)testPerformanceDeserializeExample {
    // This is an example of a performance test case.
    [self measureBlock:^{
        for (int i = 0; i < 1000; i++)
            [self deserializeSample];
    }];
}

- (void)testPerformanceSserializeExample {
    // This is an example of a performance test case.
    [self measureBlock:^{
        for (int i = 0; i < 1000; i++)
            [self serializeSample];
    }];
}


- (Customer *) deserializeSample
{
    NSString *path = [[NSBundle bundleForClass:[self class]] pathForResource:@"customer" ofType:@"json"];
    NSData *data = [NSData dataWithContentsOfFile:path];
    return [NSJSONSerialization JSONObjectWithData:data deserializer:[Customer serialization] options:0 error:nil];
}


- (NSData *) serializeSample
{
    Customer *c = [[Customer alloc] init];
    c.identifier = @"1234";
    c.name = @"name";
    c.websiteURL = [NSURL URLWithString:@"http://www.google.com"];
    c.contactURL = [NSURL URLWithString:@"http://www.google.com/ContactUs"];

    return  [NSJSONSerialization dataWithJSONObject:c serializer:[Customer serialization] options:0 error:nil];
}

@end
