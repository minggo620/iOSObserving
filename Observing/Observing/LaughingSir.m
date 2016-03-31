//
//  LaughingSir.m
//  Observing
//
//  Created by minggo on 16/2/22.
//  Copyright © 2016年 minggo. All rights reserved.
//

#import "LaughingSir.h"
#import "YiTian.h"

@implementation LaughingSir


-(instancetype)initWithYiTian:(YiTian *)yiTian{
    self = [super init];
    
    self.yiTian = yiTian;
    [self.yiTian addObserver:self forKeyPath:@"narcotics" options:NSKeyValueObservingOptionNew |NSKeyValueObservingOptionOld context:nil];
    
    return self;
}

//-(void)watchOverYiTian:(YiTian *)yiTian {
//    self.yiTian = yiTian;
//    [self.yiTian addObserver:self forKeyPath:@"narcotics" options:NSKeyValueObservingOptionNew |NSKeyValueObservingOptionOld context:nil];
//}

-(void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSString *,id> *)change context:(void *)context{
    
    if([keyPath isEqualToString:@"narcotics"]){
        
        NSNumber *narcoticsN = [change objectForKey:@"new"];//修改之后的最新值
        NSInteger narcotics = [narcoticsN integerValue];
        if (narcotics>0) {
            if (self.delegate!=nil&&[self.delegate respondsToSelector:@selector(reportYitian:)]) {
                [self.delegate reportYitian:narcotics];
            }
        }
    }
}

- (void)dealloc{
    //移除观察者
    [self.yiTian removeObserver:self forKeyPath:@"narcotics"];
}


@end
