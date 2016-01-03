//
//  CA.m
//  AOPs
//
//  Created by User on 16/1/1.
//  Copyright © 2016年 User. All rights reserved.
//

#import "CA.h"
#import <objc/runtime.h>

@implementation CA

- (id)forwardingTargetForSelector:(SEL)aSelector
{
    if (aSelector == @selector(uppercaseString))
    {
        return@"hello world";
    }
    else
    {
        return self;
    }
}


-(NSString *)uppercaseString
{
    NSLog(@"haha");
    return @"haha";

}

void dynamicMethodIMP(id self, SEL _cmd)
{
    printf("SEL %s did not exist\n",sel_getName(_cmd));
}

+ (BOOL) resolveInstanceMethod:(SEL)aSEL
{
    if (aSEL == @selector(t))
    {
        class_addMethod([self class], aSEL, (IMP) dynamicMethodIMP, "v@:");
        return YES;
    }
    return [super resolveInstanceMethod:aSEL];
}
@end
