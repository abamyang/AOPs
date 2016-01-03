//
//  ViewController.m
//  AOPs
//
//  Created by User on 15/12/31.
//  Copyright © 2015年 User. All rights reserved.
//

#import "ViewController.h"
#import <objc/runtime.h>
#import "CA.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    //[self testReplaceMethod];
    
    CA *a = [CA new];
    
    NSString * s = [a performSelector:@selector(uppercaseString)];
    
    NSLog(@"%@",s);
    // Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

IMP orginIMP;
NSString * MyUppercaseString(id SELF, SEL _cmd)
{
    //@""
    return @"123";
}
-(void)testReplaceMethod
{
    Class strcls = [NSString class];
    SEL  oriUppercaseString = @selector(uppercaseString);
    orginIMP = [NSString instanceMethodForSelector:oriUppercaseString];
    class_replaceMethod(strcls,oriUppercaseString,(IMP)MyUppercaseString,NULL);
    NSString *s = @"hello world";
    NSLog(@"%@",[s uppercaseString]);
}

@end
