//
//  StrongReferenceVC.m
//  iOS-ReferenceProblem
//
//  Created by JetCao on 2019/4/26.
//  Copyright © 2019年 jet. All rights reserved.
//

#import "StrongReferenceVC.h"
#import "JETProxy.h"
#import "ASingletonClass.h"

@interface StrongReferenceVC ()
@property (nonatomic, strong) NSTimer *timer;
@property (nonatomic, strong) JETProxy *proxy;
@end

@implementation StrongReferenceVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.proxy = [JETProxy proxyWithTransformObject:self];
    self.timer = [NSTimer scheduledTimerWithTimeInterval:1 target:self.proxy selector:@selector(fireHomeFunc) userInfo:nil repeats:YES];
}

- (void)fireHomeFunc {
    NSLog(@"%s",__func__);
}

- (void)dealloc {
    [self.timer invalidate];
    self.timer = nil;
}

@end
