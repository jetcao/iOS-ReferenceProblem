//
//  ASingletonClass.h
//  iOS-ReferenceProblem
//
//  Created by JetCao on 2019/4/26.
//  Copyright © 2019年 jet. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface ASingletonClass : NSObject
+ (instancetype)shareInstance;
@end

NS_ASSUME_NONNULL_END
