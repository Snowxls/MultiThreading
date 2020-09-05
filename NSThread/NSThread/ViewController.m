//
//  ViewController.m
//  NSThread
//
//  Created by Snow WarLock on 2020/5/27.
//  Copyright © 2020 Chineseall. All rights reserved.
//

#import "ViewController.h"
#import "Person.h"

@interface ViewController () {
    
}

@property (nonatomic, strong) Person *p;
@property (nonatomic, strong) NSThread *t;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.p = [[Person alloc] init];
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    [self testThread];
}

- (void)testThread {
    // 主线程 512K
    NSLog(@"%@ %zd K %d", [NSThread currentThread], [NSThread currentThread].stackSize / 1024, [NSThread currentThread].isMainThread);
    
    NSThread *eat1 = [[NSThread alloc] initWithTarget:self selector:@selector(eat) object:nil];
    
    // 1. name - 在应用程序中，收集错误日志，能够记录工作的线程！
    // 否则不好判断具体哪一个线程出的问题！
    eat1.name = @"eat1";
    //This value must be in bytes and a multiple of 4KB.
    eat1.stackSize = 1024*1024;
    eat1.threadPriority = 1;
    [eat1 start];
    
    // --- 再创建一个线程，调用同一个方法 ---
    NSThread *eat2 = [[NSThread alloc] initWithTarget:self selector:@selector(eat) object:nil];
    eat2.name = @"eat2";
    eat2.threadPriority = 0;
    [eat2 start];
    
}

- (void)eat {
    for (NSInteger i = 0; i < 10; i++) {
        NSLog(@"%@ %zd K %zd", [NSThread currentThread], [NSThread currentThread].stackSize / 1024, [NSThread currentThread].isMainThread);
    }
}

@end
