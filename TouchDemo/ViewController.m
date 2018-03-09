//
//  ViewController.m
//  TouchDemo
//
//  Created by caikaixuan on 2018/3/5.
//  Copyright © 2018年 caikaixuan. All rights reserved.
//

#import "ViewController.h"
#import "TestView.h"
#import "WXLongPressButton.h"
@interface ViewController ()

@property (nonatomic, strong) WXLongPressButton *button;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    self.view.backgroundColor=[UIColor blackColor];
    
    self.button=[[WXLongPressButton alloc]initWithFrame:CGRectMake(100, 100, 100, 100)];
    self.button.totalTimeInterval=5.0f;
    self.button.complete = ^(NSTimeInterval duration) {
        NSLog(@"duration=%f",duration);
    };
    [self.view addSubview:self.button];
    
    
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    
    [self.button resetState];
    
}

@end
