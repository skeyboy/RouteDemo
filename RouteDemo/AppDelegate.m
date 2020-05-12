//
//  AppDelegate.m
//  RouteDemo
//
//  Created by 李雨龙 on 2020/5/11.
//  Copyright © 2020 李雨龙. All rights reserved.
//

#import "AppDelegate.h"
#import "JLRoutes.h"
#import "NextViewController.h"
#import <StaticVC/StaticViewController.h>
#import <DynamicVC/DynamicVC.h>
#import "UIViewController+JLRouteInit.h"

@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    //    StaticViewController * vc = [[StaticViewController alloc] initWithNibName:@"StaticVC.framework/StaticViewController" bundle:[NSBundle mainBundle]];
    
    
    return YES;
}




@end
#import <StaticVC/StaticVC.h>
@implementation AppDelegate (JLRoutes)
+(void)initialize{
    JLRoutes *routes = [JLRoutes globalRoutes];
    
    
    [routes addRoute:@"dynamic/user/:userId/msg/:msg" handler:^BOOL(NSDictionary<NSString *,id> * _Nonnull parameters) {
     
        DynamicViewController  * dynamicVC =  [DynamicViewController initRouteParams:@{@"userId":@"12324",@"msg":@"我是消息"}
                                                              forDyLibraryBlock:^(UIViewController * _Nonnull viewController, NSDictionary * _Nonnull param) {
            DynamicViewController * vv = (DynamicViewController *)viewController;
            
        }];
        AppDelegate * appdelegate = (AppDelegate *) [UIApplication sharedApplication].delegate;
        
        [appdelegate.window.rootViewController
         presentViewController:dynamicVC
         animated:YES
         completion:^{
            
        }];
        
        
        return YES;
    }];
    
    
    [routes addRoute:@"static/user/:userId/msg/:msg" handler:^BOOL(NSDictionary<NSString *,id> * _Nonnull parameters) {
        
        StaticViewController  * staticVC =  [StaticViewController initRouteParams:@{@"userId":@"12324",@"msg":@"我是消息"}
                                                              staticFrameworkName:@"StaticVC" forStaticLibraryBlock:^(UIViewController * _Nonnull viewController, NSDictionary * _Nonnull param) {
            StaticViewController * vv = (StaticViewController *)viewController;
            
            [vv setValue:param
                  forKey:@"parameters"];
        }];
        AppDelegate * appdelegate = (AppDelegate *) [UIApplication sharedApplication].delegate;
        
        [appdelegate.window.rootViewController
         presentViewController:staticVC
         animated:YES
         completion:^{
            
        }];
        
        
        return YES;
    }];
    
    [routes addRoute:@"next/user/:userId/msg/:msg" handler:^BOOL(NSDictionary<NSString *,id> * _Nonnull parameters) {
        
        
        
        NextViewController * nextVC = [[NextViewController alloc] init];
        nextVC.parameters = parameters;
        NextViewController *vc  =   [NextViewController initRouteParams:parameters block:^(UIViewController * _Nonnull viewController, NSDictionary * _Nonnull param) {
            NextViewController *nextVC = ( NextViewController *) viewController;
            nextVC.parameters = parameters;
        }];
        AppDelegate * appdelegate = (AppDelegate *) [UIApplication sharedApplication].delegate;
        
        [appdelegate.window.rootViewController presentViewController:vc
                                                            animated:YES completion:^{
            
        }];
        return YES;
    }];
}


@end
