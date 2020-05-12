//
//  NextViewController.m
//  RouteDemo
//
//  Created by 李雨龙 on 2020/5/11.
//  Copyright © 2020 李雨龙. All rights reserved.
//

#import "NextViewController.h"

@interface NextViewController ()

@property (weak, nonatomic) IBOutlet UILabel *userIdView;
@property (weak, nonatomic) IBOutlet UILabel *msgView;
@end

@implementation NextViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    NSString * userId =  _parameters[@"userId"];
                NSString * msg = _parameters[@"msg"];
                
          _userIdView.text =  userId;
          _msgView.text = msg;
}

@end
