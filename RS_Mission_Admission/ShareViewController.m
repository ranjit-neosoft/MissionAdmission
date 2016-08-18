//
//  ShareViewController.m
//  Mission Admission
//
//  Created by Swapnil on 19/01/16.
//  Copyright (c) 2016 RS_Electronics_ranjitsChougale. All rights reserved.
//

#import "ShareViewController.h"
#import <QuartzCore/QuartzCore.h>

@interface ShareViewController ()

@end

@implementation ShareViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.navigationItem.title = @"About Us";
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"Logout" style:UIBarButtonItemStyleDone target:self action:@selector(logoutUser)];
    
    self.backgroundView.layer.cornerRadius = 10;
    self.labelFacebookButton.layer.cornerRadius = 10;
    self.labelFacebookButton.layer.borderWidth = 1;
    self.labelFacebookButton.layer.borderColor =[UIColor colorWithRed:189.0/255.0f green:189.0/255.0f blue:189.0/255.0f alpha:1.0].CGColor;
    
    self.labelTwitterButton.layer.cornerRadius = 10;
    self.labelTwitterButton.layer.borderWidth = 1;
    self.labelTwitterButton.layer.borderColor =[UIColor colorWithRed:189.0/255.0f green:189.0/255.0f blue:189.0/255.0f alpha:1.0].CGColor;
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

- (void)logoutUser
{
    [self logout];
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

//post on twitter
- (IBAction)postOnTwitter:(id)sender
{
    if ([SLComposeViewController isAvailableForServiceType:SLServiceTypeTwitter])
    {
        SLComposeViewController *tweetSheet = [SLComposeViewController composeViewControllerForServiceType:SLServiceTypeTwitter];
        [tweetSheet setInitialText:@"Find your perfect college today... With MISSION ADMISSION, discovering the perfect college is fun, simple & right on your iPhone..!! "];
        [self presentViewController:tweetSheet animated:YES completion:nil];
        
    }
    else
    {
        UIAlertView *alertView = [[UIAlertView alloc]
                                  initWithTitle:@"Sorry"
                                  message:@"You can't send a tweet right now, make sure your device has an internet connection and you have at least one Twitter account setup"
                                  delegate:self
                                  cancelButtonTitle:@"OK"
                                  otherButtonTitles:nil];
        [alertView show];
    }
}

//post on facebook
- (IBAction)postOnFacebook:(id)sender
{
    if ([SLComposeViewController isAvailableForServiceType:SLServiceTypeFacebook])
    {
        SLComposeViewController *fbPostSheet = [SLComposeViewController composeViewControllerForServiceType:SLServiceTypeFacebook];
        [fbPostSheet setInitialText:@"Find your perfect college today... With MISSION ADMISSION, discovering the perfect college is fun, simple & right on your iPhone..!!"];
        [self presentViewController:fbPostSheet animated:YES completion:nil];
    } else
    {
        UIAlertView *alertView = [[UIAlertView alloc]
                                  initWithTitle:@"Sorry"
                                  message:@"You can't post right now, make sure your device has an internet connection and you have at least one facebook account setup"
                                  delegate:self
                                  cancelButtonTitle:@"OK"
                                  otherButtonTitles:nil];
        [alertView show];
    }
}
@end
