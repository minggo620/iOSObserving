//
//  YiTian.m
//  Observing
//  亦天
//  Created by minggo on 16/3/31.
//  Copyright © 2016年 minggo. All rights reserved.
//

#import "YiTian.h"

@implementation YiTian{
    NSTimer *timer;
}


-(instancetype)init{
    self = [super init];
    timer = [NSTimer scheduledTimerWithTimeInterval:2 target:self selector:@selector(makeNarcotics) userInfo:nil repeats:YES];
    
    return self;
}

-(void)makeNarcotics {
    
    int narcotics = self.narcotics;
    if (narcotics==20) {
        [timer invalidate];
    }
    [self setNarcotics:++narcotics];
    NSLog(@"亦天制毒了%iKg",self.narcotics);
}
@end
