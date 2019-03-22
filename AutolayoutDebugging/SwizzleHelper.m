//
//  SwizzleHelper.m
//  AutolayoutDebugging
//
//  Created by von Webel, Max Florian on 21.03.19.
//  Copyright © 2019 von Webel, Max Florian. All rights reserved.
//

#import "SwizzleHelper.h"
#import <objc/runtime.h>

@implementation SwizzleHelper

+ (void)swizzle:(Class)swizzleClass
{
    NSString *swizzleClassName = NSStringFromClass(swizzleClass);
    NSString *suffix = @"_swizzled";
    NSAssert(swizzleClassName.length > suffix.length, @"wrong class name!");
    NSString *originalClassName = [swizzleClassName substringToIndex:swizzleClassName.length - suffix.length];
    NSAssert([swizzleClassName hasSuffix:suffix], @"wrong suffix!");
    Class originalClass = NSClassFromString(originalClassName);
    
    unsigned int methodCount = 0;
    Method *methods = class_copyMethodList(swizzleClass, &methodCount);
    
    NSString *methodPrefix = @"swizzled_";
    
    for (unsigned int i = 0; i < methodCount; i++) {
        Method method = methods[i];
        
        SEL swizzledSelector = method_getName(method);
        NSString *swizzledMethodName = NSStringFromSelector(swizzledSelector);
        if (![swizzledMethodName hasPrefix:methodPrefix]) {
            NSLog(@"skipping [%@ %@]", swizzleClassName, swizzledMethodName);
            continue;
        }
        
        NSString *originalMethodName = [swizzledMethodName substringFromIndex:methodPrefix.length];
        SEL originalSelector = NSSelectorFromString(originalMethodName);
        
        Method originalMethod = class_getInstanceMethod(originalClass, originalSelector);
        Method swizzledMethod = class_getInstanceMethod(swizzleClass, swizzledSelector);
        
        BOOL didAddMethod =
        class_addMethod(originalClass,
                        swizzledSelector,
                        method_getImplementation(originalMethod),
                        method_getTypeEncoding(originalMethod));
        
        if (didAddMethod) {
            class_replaceMethod(originalClass,
                                originalSelector,
                                method_getImplementation(swizzledMethod),
                                method_getTypeEncoding(swizzledMethod));
        } else {
            method_exchangeImplementations(originalMethod, swizzledMethod);
        }

    }
    
    free(methods);
}

@end
