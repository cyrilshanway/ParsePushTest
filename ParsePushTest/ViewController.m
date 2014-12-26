//
//  ViewController.m
//  ParsePushTest
//
//  Created by Cyrilshanway on 2014/12/19.
//  Copyright (c) 2014年 Cyrilshanway. All rights reserved.
//

#import "ViewController.h"
#import <Parse/Parse.h>

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    //設定頻道
    // When users indicate they are Giants fans, we subscribe them to that channel.
    PFInstallation *currentInstallation = [PFInstallation currentInstallation];
    [currentInstallation addUniqueObject:@"Giants" forKey:@"channels"];
    [currentInstallation saveInBackground];
    
    //取消訂閱頻道
    /*
     // When users indicate they are no longer Giants fans, we unsubscribe them.
     PFInstallation *currentInstallation = [PFInstallation currentInstallation];
     [currentInstallation removeObject:@"Giants" forKey:@"channels"];
     [currentInstallation saveInBackground];
     */
    //針對特定頻道推播
    NSArray *subscribedChannels = [PFInstallation currentInstallation].channels;
    PFPush *push = [[PFPush alloc] init];
    [push setChannel:@"Giants"];
    [push setMessage:@"The Giants just scored!"];
    [push sendPushInBackground];
    
    PFQuery *pushQuery = [PFInstallation query];
    [pushQuery whereKey:@"deviceType" equalTo:@"ios"];
    [PFPush sendPushMessageToQueryInBackground:pushQuery
                                   withMessage:@"Hello World!"];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
