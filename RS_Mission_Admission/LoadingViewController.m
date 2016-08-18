//
//  LoadingViewController.m
//  Mission Admission
//
//  Created by Swapnil on 18/01/16.
//  Copyright (c) 2016 RS_Electronics_ranjitsChougale. All rights reserved.
//

#import "LoadingViewController.h"

@interface LoadingViewController ()

@end

@implementation LoadingViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self.loadingMyView setAlpha:0.7];
    [self.mySpinner startAnimating];
}

- (void)didReceiveMemoryWarning
{
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
