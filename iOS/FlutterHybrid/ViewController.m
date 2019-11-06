//
//  ViewController.m
//  FlutterHybrid
//
//  Created by yuan on 2019/11/4.
//  Copyright © 2019 yuan. All rights reserved.
//

#import "ViewController.h"
#import "HomeViewController.h"
#import "DetailViewController.h"
#import "InfoViewController.h"
#import "EnvViewController.h"

#import "AppDelegate.h"

@interface ViewController()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"原生交互";
    
    UIButton *btn = [self createBtn:@"MethodChannel" sel:@selector(MethodChannel)];
    btn.frame = CGRectMake(0, 80, 200, 40);
    [self.view addSubview:btn];
    
    UIButton *btn1 = [self createBtn:@"EventChannel" sel:@selector(EventChannel)];
    btn1.frame = CGRectMake(0, CGRectGetMaxY(btn.frame) + 20, 200, 40);
    [self.view addSubview:btn1];
    
    UIButton *btn2 = [self createBtn:@"Native 嵌套 Flutter" sel:@selector(Engine)];
    btn2.frame = CGRectMake(0, CGRectGetMaxY(btn1.frame) + 20, 200, 40);
    [self.view addSubview:btn2];
    
    UIButton *btn3 = [self createBtn:@"环境信息" sel:@selector(EnvInfo)];
    btn3.frame = CGRectMake(0, CGRectGetMaxY(btn2.frame) + 20, 200, 40);
    [self.view addSubview:btn3];
}

- (UIButton *)createBtn:(NSString *)title sel:(SEL)selector{
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    [btn setTitle:title forState:UIControlStateNormal];
    [btn addTarget:self action:selector forControlEvents:UIControlEventTouchUpInside];
    [btn setTitleColor:UIColor.whiteColor forState:UIControlStateNormal];
    btn.backgroundColor = UIColor.blueColor;
    return btn;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

- (void)MethodChannel {
    [self.navigationController pushViewController:HomeViewController.new animated:YES];
}

- (void)EventChannel {
    [self.navigationController pushViewController:DetailViewController.new animated:YES];
}

- (void)Engine{
    [self.navigationController pushViewController:InfoViewController.new animated:YES];
}

- (void)EnvInfo{
    [self.navigationController pushViewController:EnvViewController.new animated:YES];
}

@end
