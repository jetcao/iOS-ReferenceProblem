//
//  UINavigationController+Leaks.m
//  iOS-ReferenceProblem
//
//  Created by JetCao on 2019/4/26.
//  Copyright © 2019年 jet. All rights reserved.
//

#import "UINavigationController+Leaks.h"
#import "NSObject+Leaks.h"
extern const void* const kHasBeenPoppedKey;

@implementation UINavigationController (Leaks)
+ (void)load {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        [self hookOriginInstanceMethod:@selector(ppopViewControllerAnimated:) newInstanceMethod:@selector(new_popViewControllerAnimated:)];
    });
}

- (UIViewController*)new_popViewControllerAnimated:(BOOL)animated {
    UIViewController* popViewController = [self new_popViewControllerAnimated:animated];
    objc_setAssociatedObject(popViewController, kHasBeenPoppedKey, @(YES), OBJC_ASSOCIATION_RETAIN);
    return popViewController;
}
@end
