//
//  InfoViewController.m
//  FlutterHybrid
//
//  Created by yuan on 2019/11/6.
//  Copyright © 2019 yuan. All rights reserved.
//
#import <Flutter/Flutter.h>
#import "InfoViewController.h"
#import "BaseFlutterViewController.h"
#import "WeakProxy.h"

#pragma mark - *********** flutterView ***********

@interface flutterView : BaseFlutterViewController<FlutterStreamHandler>

@end

@implementation flutterView

- (instancetype)init{
    if (self = [super init]) {
        [self flutterEvents];
    }
    return self;
}

- (void)flutterEvents{
    
    [self setInitialRoute:@"detail"];
    
    id obj = [WeakProxy proxyWithTarget:self];
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

#pragma mark - *********** InfoViewController ***********

@interface InfoViewController (){
    flutterView *_flutterView;
}

@end

@implementation InfoViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = UIColor.whiteColor;
    self.title= @"Native 嵌套 Flutter";
    
    _flutterView = flutterView.new;
    
    dispatch_async(dispatch_get_main_queue(), ^{
        UIView *view = self->_flutterView.view;
        view.frame = CGRectMake(0, 64, 300, 300);
        [self.view addSubview:view];
        
        UIView *a = UIView.new;
        a.backgroundColor = UIColor.greenColor;
        a.frame = CGRectMake(0, CGRectGetMaxY(view.frame), 100, 100);
        [self.view addSubview:a];
    });
}

@end
