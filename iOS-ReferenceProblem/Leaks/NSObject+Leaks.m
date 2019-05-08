//
//  NSObject+Leaks.m
//  iOS-ReferenceProblem
//
//  Created by JetCao on 2019/4/26.
//  Copyright © 2019年 jet. All rights reserved.
//

#import "NSObject+Leaks.h"

@implementation NSObject (Leaks)

- (void)willDealloc {
    __weak id weakSelf = self;
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        __strong id strongSelf = weakSelf;
        [strongSelf assertNotDealloc];
    });
}

- (void)assertNotDealloc {
    NSLog(@"Leaks %@", NSStringFromClass([self class]));
}

+ (BOOL)hookOriginInstanceMethod:(SEL)oriSel newInstanceMethod:(SEL)newSel {
    Class cls = self;
    Method oriMethod = class_getInstanceMethod(cls, oriSel);
    Method newMethod = class_getInstanceMethod(cls, newSel);
    if (!newMethod) {
        return NO;
    }

    if (!oriMethod) {
        class_addMethod(cls, oriSel, method_getImplementation(newMethod), method_getTypeEncoding(newMethod));
        method_setImplementation(newMethod, imp_implementationWithBlock(^(id self, SEL _cmd){}));
        return YES;
    }

    BOOL didAddMethod = class_addMethod(cls, oriSel, method_getImplementation(newMethod), method_getTypeEncoding(newMethod));
    if (didAddMethod) {
        class_replaceMethod(cls, newSel, method_getImplementation(oriMethod), method_getTypeEncoding(oriMethod));
    } else {
        method_exchangeImplementations(oriMethod, newMethod);
    }
    return YES;
}
@end
