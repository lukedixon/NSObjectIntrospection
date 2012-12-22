//
//  NSObject+introspect.m
//  CJFoundation
//
//  Created by confidence on 13/12/2012.
//  Copyright (c) 2012 confidence. All rights reserved.
//

#import "NSObject+introspect.h"
#import <objc/runtime.h>

@implementation NSObject (dump)

-(NSDictionary*) propertiesDict {
    NSMutableDictionary *dict = [[NSMutableDictionary alloc] init];
    
    unsigned int outCount;
    
    objc_property_t *properties = class_copyPropertyList([self class], &outCount);
    
    for(int i = 0; i < outCount; i++) {
        objc_property_t property = properties[i];
        const char *propName = property_getName(property);
        NSString *propertyNameString = [NSString stringWithUTF8String:propName];
        NSValue *propertyValue = [self valueForKey:propertyNameString];
        if (propertyValue){
            [dict setValue:propertyValue forKey:propertyNameString];
        }
        else {
            [dict setObject:[NSNull null] forKey:propertyNameString];
        }
    }
    
    free(properties);
    
    return dict;
}

-(NSDictionary *)iVarsDict{
    NSMutableDictionary *dict = [[NSMutableDictionary alloc] init];
    unsigned int outCount;

    Ivar* ivars = class_copyIvarList([self class], &outCount);
    for (int i = 0; i < outCount ; i++){
        Ivar ivar=ivars[i];
        const char* ivarName = ivar_getName(ivar);
        NSString *ivarNameString = [NSString stringWithUTF8String:ivarName];
        NSValue *value = [self valueForKey:ivarNameString];
        
        if (value) {
            [dict setValue:value forKey:ivarNameString];
        }
        
        else {
            [dict setValue:[NSNull null] forKey:ivarNameString];
        }
    }

    free(ivars);
    
    return dict;
}

-(NSDictionary *)methodsDict{
    unsigned int count;
    
    NSMutableDictionary *dict = [[NSMutableDictionary alloc] initWithCapacity:0];
    
    Method* methods = class_copyMethodList([self class], &count);
    
    for (int i=0; i<count; i++) {
        Method method = methods[i];
        SEL selector = method_getName(method);
        NSString *methodNameString = NSStringFromSelector(selector);
        
        if (selector) {
            [dict setValue:methodNameString forKey:methodNameString];
        }
    }
    
    free(methods);

    return dict;
}

-(NSDictionary *)objectIntrospectDictionary{
    NSArray *obs=[[NSArray alloc] initWithObjects:[self propertiesDict],[self iVarsDict],[self methodsDict], nil];
    NSArray *keys=[[NSArray alloc] initWithObjects:@"properties",@"iVars",@"methods",nil];
    
    NSDictionary *dict=[NSDictionary dictionaryWithObjects:obs forKeys:keys];
    
    NSLog(@"%@",dict.description);
        
    return dict;
}


@end
