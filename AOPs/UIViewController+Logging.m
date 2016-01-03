//
//  UIViewController+Logging.m
//  AOPs
//
//  Created by User on 16/1/1.
//  Copyright © 2016年 User. All rights reserved.
//

#import "UIViewController+Logging.h"
#import <objc/runtime.h>
//typedef void (* _IMP) (id,SEL,...);
@implementation UIViewController (Logging)
+ (void)load {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        Class class = [self class];
        
        // When swizzling a class method, use the following:
        // Class class = object_getClass((id)self);
        
        SEL originalSelector = @selector(viewWillAppear:);
        SEL swizzledSelector = @selector(xxx_viewWillAppear:);
        
        Method originalMethod = class_getInstanceMethod(class, originalSelector);
        Method swizzledMethod = class_getInstanceMethod(class, swizzledSelector);
        
        BOOL didAddMethod =
        class_addMethod(class,
                        originalSelector,
                        method_getImplementation(swizzledMethod),
                        method_getTypeEncoding(swizzledMethod));
        
        if (didAddMethod) {
            class_replaceMethod(class,
                                swizzledSelector,
                                method_getImplementation(originalMethod),
                                method_getTypeEncoding(originalMethod));
        } else {
            method_exchangeImplementations(originalMethod, swizzledMethod); 
        }
        
        
    }); 
}

#pragma mark - Method Swizzling

- (void)xxx_viewWillAppear:(BOOL)animated
{
    [self xxx_viewWillAppear:animated];
    NSLog(@"viewWillAppear: %@", self);
}



@end
