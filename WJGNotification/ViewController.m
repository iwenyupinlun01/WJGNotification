//
//  ViewController.m
//  WJGNotification
//
//  Created by 王俊钢 on 2019/6/16.
//  Copyright © 2019 wangjungang. All rights reserved.
//

#import "ViewController.h"
#import "TestViewController1.h"

@interface ViewController ()
@property (nonatomic, copy) NSString *str;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
     self.view.backgroundColor = [UIColor whiteColor];
    
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    [self.view addSubview:button];
    button.frame = CGRectMake(100, 100, 200, 100);
    [button setTitle:@"跳转" forState:UIControlStateNormal];
    button.backgroundColor = [UIColor redColor];
    [button setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    
    
    [button addTarget:self action:@selector(clickToVC) forControlEvents:UIControlEventTouchUpInside];
}

- (void)clickToVC {
    NSLog(@"点击跳转");
    TestViewController1 *testVC = [[TestViewController1 alloc] init];
    [self presentViewController:testVC animated:YES completion:nil];
}
@end
