//
//  ViewController.m
//  DailyProject
//
//  Created by Joky_Lee on 2020/2/12.
//  Copyright © 2020 Joky_Lee. All rights reserved.
//

#import "ViewController.h"
#import "TestObj.h"
@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    TestObj *obj1 = [[TestObj alloc] init];
    obj1.name = @"name1--";
    [obj1 sd_addObserver:self forKeyPath:@"name" options:NSKeyValueObservingOptionNew context:nil];
    obj1.name = @"name-change1---";
}

-(void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSKeyValueChangeKey,id> *)change context:(void *)context {
    NSLog(@"change ---- %@",change);
}

@end
