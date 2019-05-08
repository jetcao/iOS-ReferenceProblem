//
//  UIViewController+Leaks.m
//  iOS-ReferenceProblem
//
//  Created by JetCao on 2019/4/26.
//  Copyright © 2019年 jet. All rights reserved.
//

#import "UIViewController+Leaks.h"
#import "NSObject+Leaks.h"

@implementation UIViewController (Leaks)
const void* const kHasBeenPoppedKey = &kHasBeenPoppedKey;

+ (void)load {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        [self hookOriginInstanceMethod:@selector(viewWillAppear:) newInstanceMethod:@selector(new_viewWillAppear:)];
        [self hookOriginInstanceMethod:@selector(viewDidDisappear:) newInstanceMethod:@selector(new_viewDidDisappear:)];
    });
}

- (void)new_viewWillAppear:(BOOL) animated {
    [self new_viewWillAppear:animated];

    objc_setAssociatedObject(self, kHasBeenPoppedKey, @(NO), OBJC_ASSOCIATION_RETAIN);
}

- (void)new_viewDidDisappear:(BOOL) animated {
    [self new_viewDidDisappear:animated];

    if ([objc_getAssociatedObject(self, kHasBeenPoppedKey) boolValue]) {
        [self willDealloc];
    }
}

@end
