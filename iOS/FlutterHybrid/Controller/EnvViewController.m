//
//  EnvViewController.m
//  FlutterHybrid
//
//  Created by yuan on 2019/11/6.
//  Copyright © 2019 yuan. All rights reserved.
//

#import "EnvViewController.h"

@interface EnvViewController ()

@end

@implementation EnvViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title= @"当前环境";
    [self flutterMethod];
}

- (void)flutterMethod{
    
    [self setInitialRoute:@"envSetting"];
    
    NSString *channelName = @"channel_env";

    FlutterMethodChannel *messageChannel = [FlutterMethodChannel methodChannelWithName:channelName binaryMessenger:self];
    
    [messageChannel setMethodCallHandler:^(FlutterMethodCall * _Nonnull call, FlutterResult  _Nonnull result) {
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
    }];
}

@end
