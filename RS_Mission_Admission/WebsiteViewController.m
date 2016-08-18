//
//  WebsiteViewController.m
//  Mission Admission
//
//  Created by Swapnil on 18/01/16.
//  Copyright (c) 2016 RS_Electronics_ranjitsChougale. All rights reserved.
//

#import "WebsiteViewController.h"


@interface WebsiteViewController ()

@end

@implementation WebsiteViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
     NSLog(@"viewDidLoad");
    [self.spinner startAnimating];
}

-(void) goTourl
{
    NSURL *url = [NSURL URLWithString:self.websiteUrl];
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    [self.websiteView loadRequest:request];
    
}

-(void) viewWillAppear:(BOOL)animated
{
    [super viewDidLoad];
    NSLog(@"viewWillAppear");
    
}

-(void) viewWillDisappear:(BOOL)animated
{
    self.spinner.hidden = NO;
    NSLog(@"viewWillDisappear");
}

-(void) viewDidAppear:(BOOL)animated
{
    [self.spinner stopAnimating];
    self.spinner.hidden = YES;
    [self goTourl];
    NSLog(@"viewDidAppear");
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
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
