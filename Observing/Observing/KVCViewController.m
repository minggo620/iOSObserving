//
//  KVVViewController.m
//  Observing
//
//  Created by minggo on 16/2/1.
//  Copyright © 2016年 minggo. All rights reserved.
//

#import "KVCViewController.h"

@interface KVCViewController ()
@property (weak, nonatomic) IBOutlet UILabel *testTf;

@end

@implementation KVCViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.testTf sizeToFit];
    // Do any additional setup after loading the view.
}

-(void)viewDidLayoutSubviews{
    [super viewDidLayoutSubviews];
    [self.testTf sizeToFit];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
