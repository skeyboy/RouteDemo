//
//  UIViewController+JLRouteInit.m
//  RouteDemo
//
//  Created by 李雨龙 on 2020/5/12.
//  Copyright © 2020 李雨龙. All rights reserved.
//

#import "UIViewController+JLRouteInit.h"

@implementation UIViewController (JLRouteInit)
+(instancetype)initRouteParams:(NSDictionary *)params
                         block:(nonnull void (^)(UIViewController * _Nonnull, NSDictionary * _Nonnull))block{
    NSString * xibName = NSStringFromClass(self);
    NSBundle * mainBundle = [NSBundle mainBundle];
    NSBundle  *staticBundle = [NSBundle bundleForClass:self];
    NSBundle *dyBundle = [NSBundle bundleForClass:self];
    NSString * xibPath  = [[NSBundle mainBundle] pathForResource:xibName ofType:@"nib"];
    
    if ([xibPath componentsSeparatedByString:@"/"].count) {
        xibName = [xibPath componentsSeparatedByString:@"/"].lastObject;
        xibName = [xibName componentsSeparatedByString:@"."].firstObject;
    }else{
        xibName = [NSString stringWithFormat:@"StaticVC.framework/%@",xibName];
        mainBundle = [NSBundle mainBundle];
    }
    
    __block UIViewController * vc =    [[self alloc] initWithNibName:xibName
                                                              bundle:mainBundle];
    block(vc, params);
    return vc;
}

+(instancetype)initRouteParams:(NSDictionary *)params staticFrameworkName:(NSString *) frameworkName
         forStaticLibraryBlock:(void (^)(UIViewController * _Nonnull, NSDictionary * _Nonnull))block{
    
  
    NSBundle * mainBundle = [NSBundle mainBundle];
    NSString *  xibName = [NSString stringWithFormat:@"%@.framework/%@",frameworkName
                           ,NSStringFromClass(self)];
    
    __block UIViewController * vc =    [[self alloc] initWithNibName:xibName
                                                              bundle:mainBundle];
    block(vc, params);
    return vc;
}
+(instancetype)initRouteParams:(NSDictionary *)params
         forDyLibraryBlock:(void (^)(UIViewController * _Nonnull, NSDictionary * _Nonnull))block{
    
    NSBundle * dyBundle = [NSBundle bundleForClass:self];
    
    __block UIViewController * vc =    [[self alloc]
                                        initWithNibName:NSStringFromClass(self)
                                                              bundle:dyBundle];
    block(vc, params);
    return vc;
}
@end
