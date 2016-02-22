//
//  KVVViewController.m
//  Observing
//
//  Created by minggo on 16/2/1.
//  Copyright © 2016年 minggo. All rights reserved.
//

#import "KVCViewController.h"
#import "LaughingSir.h"

@interface KVCViewController ()
@property (weak, nonatomic) IBOutlet UITextField *answerTf;

- (IBAction)answer:(id)sender;

@end

@implementation KVCViewController{
    LaughingSir *laughingSir;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    laughingSir = [LaughingSir new];
    laughingSir.name = @"梁笑棠";
    laughingSir.famous = @"一日警察，一世警察";
}

NSString* exchangeName(LaughingSir *laughingSir){
    
    NSString *preName = [laughingSir valueForKey:@"name"];
    NSLog(@"laughing的旧名字：%@",preName);
    
    [laughingSir setValue:@"laughing 哥" forKey:@"name"];
    
    NSString *newName = [laughingSir valueForKey:@"name"];
    NSLog(@"laughing的新名字：%@",newName);
    
    return newName;
}




- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
}


- (IBAction)answer:(id)sender {
    
    NSString *newName = exchangeName(laughingSir);
    self.answerTf.text  = newName;
    
}
@end
