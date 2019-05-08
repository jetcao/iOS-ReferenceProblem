//
//  ASingletonClass.m
//  iOS-ReferenceProblem
//
//  Created by JetCao on 2019/4/26.
//  Copyright © 2019年 jet. All rights reserved.
//

#import "ASingletonClass.h"

@implementation ASingletonClass
+ (instancetype)shareInstance {
    static __weak ASingletonClass *instance;
    ASingletonClass *strongInstance = instance;
    @synchronized (self) {
        if (strongInstance == nil) {
            strongInstance = [[ASingletonClass alloc] init];
            instance = strongInstance;
        }
    }
    return strongInstance;
}
@end
