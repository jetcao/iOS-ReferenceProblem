//
//  NSObject+Weak.m
//  iOS-ReferenceProblem
//
//  Created by JetCao on 2019/4/26.
//  Copyright © 2019年 jet. All rights reserved.
//

#import "NSObject+Weak.h"
#import <objc/runtime.h>

@implementation NSObject (Weak)
- (void)setContext:(id)object {
    id __weak weakObject = object;
    id (^block)(void) = ^{ return weakObject; };
    objc_setAssociatedObject(self, @selector(context), block, OBJC_ASSOCIATION_COPY);
}

- (id)context {
    id (^block)(void) = objc_getAssociatedObject(self, @selector(context));
    id curContext = (block ? block() : nil);
    return curContext;
}
@end
