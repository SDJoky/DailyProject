//
//  TestObj.m
//  DailyProject
//
//  Created by Joky_Lee on 2020/2/12.
//  Copyright © 2020 Joky_Lee. All rights reserved.
//

#import "TestObj.h"
#import <objc/message.h>

@implementation TestObj


void setterMethod(id self, SEL _cmd, NSString *name)  {
//1.调用父类方法
//2.通知观察者调用addObserver:(NSObject *)observer forKeyPath:(NSString *)keyPath options:(NSKeyValueObservingOptions)options context:(void *)context

    struct objc_super superClass = {
        self,
        class_getSuperclass([self class])
    };
    objc_msgSendSuper(&superClass,_cmd,name);
//    取出observer
    id observer = objc_getAssociatedObject(self, (__bridge const void *)@"objc");
//    通知改变
    NSString *methodName = NSStringFromSelector(_cmd);
    NSString *key = getValueKey(methodName);
    objc_msgSend(observer, @selector(observeValueForKeyPath: ofObject: change: context:),key,self,@{key: name},nil);
}

NSString *getValueKey(NSString *setter) {
    NSRange range = NSMakeRange(3, setter.length - 4);
    NSString *key = [setter substringWithRange:range];
    NSString * letter = [[key substringToIndex:1] lowercaseString];
    key = [key stringByReplacingCharactersInRange:NSMakeRange(0, 1) withString:letter];
    return key;
}

//重写addObserver
- (void)sd_addObserver:(NSObject *)observer forKeyPath:(NSString *)keyPath options:(NSKeyValueObservingOptions)options context:(void *)context {

//    在系统创建一个类
    NSString *oldName = NSStringFromClass([self class]);
    NSString *newName = [NSString stringWithFormat:@"CustomKVO_%@",oldName];
    Class customClass = objc_allocateClassPair([self class], newName.UTF8String, 0);
//    注册
    objc_registerClassPair(customClass);
//    修改isa 指针
    object_setClass(self, customClass);
//    重写set方法
    NSString *methodName = [NSString stringWithFormat:@"set%@:",keyPath.capitalizedString];
    SEL sel = NSSelectorFromString(methodName);
//    添加方法实现
    class_addMethod(customClass, sel, (IMP)setterMethod, "v@:@");
//  关联观察者
    objc_setAssociatedObject(self, (__bridge const void *)@"objc", observer, OBJC_ASSOCIATION_ASSIGN);
}

@end
