//
//  JETProxy.m
//  iOS-ReferenceProblem
//
//  Created by JetCao on 2019/4/26.
//  Copyright © 2019年 jet. All rights reserved.
//

#import "JETProxy.h"
@interface JETProxy()
@property (nonatomic, weak) id object;
@end

@implementation JETProxy
+ (instancetype)proxyWithTransformObject:(id)object {
    JETProxy *proxy = [JETProxy alloc];
    proxy.object = object;
    return proxy;
}

- (void)forwardInvocation:(NSInvocation *)invocation {
    [invocation invokeWithTarget:self.object];
}

- (NSMethodSignature *)methodSignatureForSelector:(SEL)sel {
    return [self.object methodSignatureForSelector:sel];
}

@end
