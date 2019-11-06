//
//  BaseFlutterViewController.m
//  FlutterHybrid
//
//  Created by yuan on 2019/11/5.
//  Copyright © 2019 yuan. All rights reserved.
//

#import "BaseFlutterViewController.h"

@interface BaseFlutterViewController ()

@end

@implementation BaseFlutterViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)dealloc{
    NSLog(@"---- %@ 释放了 ----",NSStringFromClass(self.class));
}

@end
