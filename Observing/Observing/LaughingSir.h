//
//  LaughingSir.h
//  Observing
//  梁笑棠
//  Created by minggo on 16/2/22.
//  Copyright © 2016年 minggo. All rights reserved.
//

#import <Foundation/Foundation.h>
@class YiTian;

@protocol LaughingReportDelegate <NSObject>

-(void)reportYitian:(NSUInteger)narcotics;

@end

@interface LaughingSir : NSObject

@property(nonatomic,copy) NSString *name;
@property(nonatomic,copy) NSString *famous;
@property(nonatomic,retain) YiTian *yiTian;
@property(nonatomic,retain) id<LaughingReportDelegate> delegate;

//-(void)watchOverYiTian:(YiTian *)yiTian;

-(instancetype)initWithYiTian:(YiTian *)yiTian;

@end
