//
//  ViewController.m
//  Quartz2DDemo
//
//  Created by zpf on 2017/6/30.
//  Copyright © 2017年 XiHeLaoBo. All rights reserved.
//

#import "ViewController.h"
#import "CustomView.h"

@interface ViewController ()

@property (nonatomic, strong) CustomView *customView;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    _customView = [[CustomView alloc] initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height)];
    
    [self.view addSubview:_customView];
    
    
    
    
    
}


#pragma mark - 警告
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}


@end
