//
//  TestViewController1.m
//  WJGNotification
//
//  Created by 王俊钢 on 2019/6/16.
//  Copyright © 2019 wangjungang. All rights reserved.
//

#import "TestViewController1.h"
#import "PSSNotificationCenter.h"

@interface TestViewController1 ()
@property (nonatomic, copy) NSObject *obj_1;
@property (nonatomic, copy) NSObject *obj_2;
@property (nonatomic, copy) NSObject *obj_3;

@end

@implementation TestViewController1

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor whiteColor];
    
    
    self.obj_1 = [[NSObject alloc] init];
    // 不带NotificationName，字用默认的name kDefaultNotificationName。observer必须传，而且要是NSObject
    [[PSSNotificationCenter defaultCenter] addEvent:^(id info) {
        NSLog(@"%@", info);
    } observer:self.obj_1];
    
    [[PSSNotificationCenter defaultCenter] addEvent:^(id info) {
        NSLog(@"%@", info);
    } observer:self];
    
    [[PSSNotificationCenter defaultCenter] addEvent:^(id info) {
        
    } eventName:@"PSS" observer:self];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(receiveSysNoti:) name:@"target" object:nil];
    
    [[NSNotificationCenter defaultCenter] addObserverForName:@"block" object:nil queue:nil usingBlock:^(NSNotification * _Nonnull note) {
        NSLog(@"block方式受到系统通知");
    }];
}

- (void)dealloc {
    NSLog(@"1234567890987654322221");
}

- (void)clickBack:(id)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}
// 发消息1
- (void)clickMsg1:(id)sender {
    [[PSSNotificationCenter defaultCenter] postDefaultNotification:@"11111"];
    [[PSSNotificationCenter defaultCenter] postNotificationByName:@"PSS" info:@"附带信息"];
}
// 移除obj_1对应的通知事件
- (void)clickMsg2:(id)sender {
    [[PSSNotificationCenter defaultCenter] removeObserver:self.obj_1];
}
// 销毁observer
- (void)click3:(id)sender {
    self.obj_1 = nil;
    [[PSSNotificationCenter defaultCenter] removeObserver:self.obj_1];
    [[PSSNotificationCenter defaultCenter] removeNotificationName:@"PSS"];
    [[NSNotificationCenter defaultCenter] removeObserver:self];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:@"block" object:nil];
}
- (void)clickSysNoti:(id)sender {
    for (NSInteger i = 0; i < 10; i++) {
        dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
            NSLog(@"%ld - %@", (long)i, [[NSThread currentThread] isMainThread] ? @"发送系统通知：主线程" : @"发送系统通知：子线程");
            [[NSNotificationCenter defaultCenter] postNotificationName:@"test" object:nil];
        });
    }
    [[NSNotificationCenter defaultCenter] postNotificationName:@"block" object:nil];
}

- (void)receiveSysNoti:(NSNotification *)noti {
    NSLog(@"%@", [[NSThread currentThread] isMainThread] ? @"收到系统通知：主线程" : @"收到系统通知：子线程");
}

@end
