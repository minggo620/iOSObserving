//
//  KVOViewController.m
//  Observing
//
//  Created by minggo on 16/2/1.
//  Copyright © 2016年 minggo. All rights reserved.
//

#import "KVOViewController.h"
#import "LaughingSir.h"
#import "YiTian.h"

@interface KVOViewController ()<LaughingReportDelegate>
- (IBAction)watchOver:(id)sender;
@property (weak, nonatomic) IBOutlet UITextField *narcoticsTf;

@end

@implementation KVOViewController{
    YiTian *yiTian;
    LaughingSir *laughingSir;
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    yiTian = [YiTian new];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
}
- (IBAction)watchOver:(id)sender {
    if (laughingSir==nil) {
        laughingSir = [[LaughingSir alloc] initWithYiTian:yiTian];
        laughingSir.delegate = self;

    }
    //[laughingSir watchOverYiTian:yiTian];
    
}

#pragma mark - LaughingReportDelegate
-(void)reportYitian:(NSUInteger)narcotics{
    self.narcoticsTf.text = [NSString stringWithFormat:@"%iKg",narcotics];
}

@end
