//
//  ViewController.m
//  DailyProject
//
//  Created by Joky_Lee on 2020/2/12.
//  Copyright © 2020 Joky_Lee. All rights reserved.
//

#import "ViewController.h"
#import <objc/runtime.h>
#import "TestObj.h"
@interface ViewController ()

@end

@implementation ViewController
+ (void)initialize {
    NSLog(@"%s",__FUNCTION__);
}

+ (void)load {
    NSLog(@"%s",__FUNCTION__);
}


- (void)loadView {
    [super loadView];
    NSLog(@"%s",__FUNCTION__);
}


- (void)viewDidLoad {
    [super viewDidLoad];
    NSLog(@"%s",__FUNCTION__);
    TestObj *obj1 = [[TestObj alloc] init];
    obj1.name = @"name1--";
    [obj1 sd_addObserver:self forKeyPath:@"name" options:NSKeyValueObservingOptionNew context:nil];
    obj1.name = @"name-change1---";
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    NSLog(@"%s",__FUNCTION__);
}

-(void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    NSLog(@"%s",__FUNCTION__);
}

-(void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    NSLog(@"%s",__FUNCTION__);
}

- (void)viewDidDisappear:(BOOL)animated{
    [super viewDidDisappear:animated];
    NSLog(@"%s",__FUNCTION__);
}

- (void)viewWillLayoutSubviews{
    [super viewWillLayoutSubviews];
    NSLog(@"%s",__FUNCTION__);
}

- (void)viewDidLayoutSubviews{
    [super viewDidLayoutSubviews];
    NSLog(@"%s",__FUNCTION__);
}

-(void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSKeyValueChangeKey,id> *)change context:(void *)context {
    NSLog(@"change ---- %@",change);
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    [self getClasses:[TestObj class]];
}

// 检查类以及子类
- (void)getClasses:(Class)cls {
    if (!cls) return;
    // 注册类的总数
    int count = objc_getClassList(NULL, 0);
    // 创建一个数组，其中包含给定对象
    NSMutableArray *mArr = [NSMutableArray arrayWithObject:cls];
    // 获取所有已注册的类
    Class *classes = (Class *)malloc(sizeof(Class)*count);
    objc_getClassList(classes, count);
    for (int i = 0; i < count; i++) {
        if (cls == class_getSuperclass(classes[i])) {
            [mArr addObject:classes[i]];
        }
    }
    free(classes);
    NSLog(@"classes --- %@", mArr);
}

@end
