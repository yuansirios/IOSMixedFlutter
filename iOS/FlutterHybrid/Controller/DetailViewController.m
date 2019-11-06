//
//  DetailViewController.m
//  FlutterHybrid
//
//  Created by yuan on 2019/11/5.
//  Copyright © 2019 yuan. All rights reserved.
//

#import "DetailViewController.h"
#import "WeakProxy.h"

@interface DetailViewController ()<FlutterStreamHandler>

@end

@implementation DetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title= @"Detail页面";
    
    [self flutterEvents];
}

- (void)flutterEvents{
    //内存管理
    id obj = [WeakProxy proxyWithTarget:self];
    [self setInitialRoute:@"detail"];
    FlutterEventChannel *eventChannel = [FlutterEventChannel eventChannelWithName:@"channel_detail" binaryMessenger:obj];
    [eventChannel setStreamHandler:obj];
}

#pragma mark - FlutterStreamHandler
- (FlutterError* _Nullable)onListenWithArguments:(id _Nullable)arguments
                                       eventSink:(FlutterEventSink)eventSink{
    if ([arguments isKindOfClass:NSString.class]) {
        NSString *event = arguments;
        if ([event isEqualToString:@"init"]) {
            if (eventSink) {
                eventSink(@"1231231321");
            }
        }else if ([event isEqualToString:@"iOSToFlutter"]) {
            if (eventSink) {
                eventSink(@"iOS给Flutter的参数");
            }
        }
    }else if ([arguments isKindOfClass:NSDictionary.class]) {
        NSDictionary *dic = arguments;
        if ([[dic allKeys] containsObject:@"pramaToiOS"]) {
            NSDictionary *subDic = dic[@"pramaToiOS"];
            NSLog(@"iOS接收到参数：%@",subDic);
        }
    }
    
    return nil;
}
 
- (FlutterError* _Nullable)onCancelWithArguments:(id _Nullable)arguments {
    return nil;
}

@end
