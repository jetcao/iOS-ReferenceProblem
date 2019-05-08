//
//  NSObject+Leaks.h
//  iOS-ReferenceProblem
//
//  Created by JetCao on 2019/4/26.
//  Copyright © 2019年 jet. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <objc/runtime.h>

NS_ASSUME_NONNULL_BEGIN

@interface NSObject (Leaks)
+ (BOOL)hookOriginInstanceMethod:(SEL)oriSel newInstanceMethod:(SEL)newSel;
- (void)willDealloc;
@end

NS_ASSUME_NONNULL_END
