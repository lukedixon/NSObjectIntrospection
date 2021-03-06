//
//  DemoObject.m
//  NSObjectIntrospectionDemo
//
//  Created by confidence on 22/12/2012.
//  Copyright (c) 2012 confidence. All rights reserved.
//

#import "DemoObject.h"

@implementation DemoObject

@synthesize aString;
@synthesize aNumber;
@synthesize aFloat;
@synthesize aLeafObject;
@synthesize arrayOfLeaves;
@synthesize dictOfLeaves;

-(id)init{
    
    if (self=[super init]) {
        anIvarString=@"anIvarString";
    }

    return self;
}

-(void)aDeclaredMethod{
   NSLog(@"aDeclaredMethod was called");
}

-(void)anUnDeclaredMethod{
    NSLog(@"anUnDeclaredMethod was called");
}

@end
