//
//  TestObj.h
//  DailyProject
//
//  Created by Joky_Lee on 2020/2/12.
//  Copyright © 2020 Joky_Lee. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface TestObj : NSObject
@property (nonatomic, copy) NSString *name;
//自定义kvo
- (void)sd_addObserver:(NSObject *)observer forKeyPath:(NSString *)keyPath options:(NSKeyValueObservingOptions)options context:(void *)context;
@end

NS_ASSUME_NONNULL_END
