//
//  CircularReferenceVC.m
//  iOS-ReferenceProblem
//
//  Created by JetCao on 2019/4/26.
//  Copyright © 2019年 jet. All rights reserved.
//

#import "CircularReferenceVC.h"
typedef void (^Blcok)(void);
typedef void (^BlcokSelf)(CircularReferenceVC *);

@interface CircularReferenceVC ()
@property (nonatomic, copy) Blcok blcok;
@property (nonatomic, copy) BlcokSelf blcokSelf;
@property (nonatomic, copy) Blcok blcokWeak;
@property (nonatomic, copy) NSString *name;
@end

@implementation CircularReferenceVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.name = @"JET";
//    [self method_self];
    [self method_weak];
//    [self method_block];
}

- (void)method_block {
    __block CircularReferenceVC *blockSelf = self;
    self.blcok = ^{
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            NSLog(@"%@",blockSelf.name);
            blockSelf = nil;
        });
    };
    self.blcok();
}

- (void)method_self {
    self.blcokSelf = ^(CircularReferenceVC *vc) {
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            NSLog(@"%@",vc.name);
        });
    };
    self.blcokSelf(self);
}

- (void)method_weak {
    __weak typeof(self) weakSelf = self;
    self.blcokWeak = ^{
        __strong typeof(self) strongSelf = weakSelf;
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            NSLog(@"%@",strongSelf.name);
        });
    };
    self.blcokWeak();
}
@end
