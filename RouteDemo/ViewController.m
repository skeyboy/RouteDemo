//
//  ViewController.m
//  RouteDemo
//
//  Created by 李雨龙 on 2020/5/11.
//  Copyright © 2020 李雨龙. All rights reserved.
//

#import "ViewController.h"
#import "JLRoutes.h"
@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
}
- (IBAction)loadViewControllerFromMainApp:(id)sender {
    NSURL * url = [NSURL URLWithString:@"next/user/123/msg/hello"];
    [JLRoutes.globalRoutes routeURL:url];
}
- (IBAction)loadViewControllerFromStaticLibrary:(id)sender {
    

    NSURL * url = [NSURL URLWithString:@"static/user/static/msg/static"];
    [JLRoutes.globalRoutes routeURL:url];
}
- (IBAction)loadViewControllerFromDynamicLibrary:(id)sender {
    

    NSURL * url = [NSURL URLWithString:@"dynamic/user/dynamic/msg/dynamic"];
    
    [JLRoutes.globalRoutes routeURL:url];
}


@end
