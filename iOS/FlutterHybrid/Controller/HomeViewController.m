//
//  HomeViewController.m
//  FlutterHybrid
//
//  Created by yuan on 2019/11/5.
//  Copyright © 2019 yuan. All rights reserved.
//

#import "HomeViewController.h"

@interface HomeViewController ()<FlutterBinaryMessenger>

@end

@implementation HomeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title= @"FlutterCallNative";
    [self flutterMethod];
}

- (void)flutterMethod{
    
    [self setInitialRoute:@"home"];
    
    NSString *channelName = @"channel_home";

    FlutterMethodChannel *messageChannel = [FlutterMethodChannel methodChannelWithName:channelName binaryMessenger:self];
    
    [messageChannel setMethodCallHandler:^(FlutterMethodCall * _Nonnull call, FlutterResult  _Nonnull result) {
        // call.method 获取 flutter 给回到的方法名，要匹配到 channelName 对应的多个 发送方法名，一般需要判断区分
        // call.arguments 获取到 flutter 给到的参数，（比如跳转到另一个页面所需要参数）
        // result 是给flutter的回调， 该回调只能使用一次
//        NSLog(@"method=%@ \narguments = %@", call.method, call.arguments);
        
        if ([call.method isEqualToString:@"initWithPrama"]) {
            if (result) {
                result(@"111111111");
            }
        }
        
        if ([call.method isEqualToString:@"setUpENV"]) {
            if (result) {
                #ifdef DEBUG
                    #ifdef TEST
                        result(@"test");
                    #else
                        result(@"dev");
                    #endif
                #else
                    result(@"release");
                #endif
            }
        }
        
        // flutter传参给iOS
        if ([call.method isEqualToString:@"pragmaToiOS"] ||
            [call.method isEqualToString:@"pragmaToiOS2"]) {
            NSLog(@"flutter给的参数：%@",call.arguments);
        }
        
        // iOS给iOS返回值
        if ([call.method isEqualToString:@"iOSToFlutter"]) {
            if (result) {
                result(@"返回给flutter的内容");
            }
        }
    }];
}

@end
