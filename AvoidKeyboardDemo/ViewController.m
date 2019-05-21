//
//  ViewController.m
//  AvoidKeyboardDemo
//
//  Created by 吴珂 on 15/9/9.
//  Copyright (c) 2015年 MyCompany. All rights reserved.
//
#import "oneViewController.h"

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    oneViewController *one=[[oneViewController alloc]init];
    UINavigationController *nav=[[UINavigationController alloc]initWithRootViewController:one];
    [self presentViewController:nav animated:YES completion:nil];
}
@end
