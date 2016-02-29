//
//  ViewController.m
//  ImageScrollViewDemo
//
//  Created by 辉 on 16/1/28.
//  Copyright © 2016年 辉. All rights reserved.
//

#import "ViewController.h"

#import "SunshineScrollView.h"

@interface ViewController ()<SunshineScrollViewDelegate>
{
    SunshineScrollView *vc;
    BOOL isyes;
}
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    vc = [[SunshineScrollView alloc]initWithFrame:CGRectMake(0,0, self.view.frame.size.width    , self.view.frame.size.height-400)];
    vc.delegate = self;
    isyes = YES;
    [self.view addSubview:vc];
}

-(void)clickImageIndex:(NSInteger)imageIndex
{
NSLog(@"%ld",imageIndex);
}


- (void)pp
{

}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

- (IBAction)click:(id)sender {
   
    if (isyes) {
        [vc updateImageData:@[[UIColor redColor],[UIColor blackColor],[UIColor orangeColor],[UIColor yellowColor],[UIColor lightGrayColor],[UIColor greenColor]]];
        isyes = NO;
    } else {
      [vc updateImageData:@[[UIColor redColor],[UIColor blackColor],[UIColor orangeColor]]];
        isyes = YES;
    }
    
    
}
@end
