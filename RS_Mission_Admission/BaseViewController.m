//
//  BaseViewController.m
//  Mission Admission
//
//  Created by Swapnil on 12/01/16.
//  Copyright (c) 2016 RS_Electronics_ranjitsChougale. All rights reserved.
//

#import "BaseViewController.h"
#import "Utils.h"
#import "Constants.h"
#import "AppDelegate.h"
@interface BaseViewController ()

@end

@implementation BaseViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    //[self.view setBackgroundColor:[UIColor clearColor]];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

- (void)makeServerCallWithUrl:(NSString *)strUrl
{
    container = [[NSMutableData alloc] init];
    
    NSURL *url = [NSURL URLWithString:strUrl];
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    NSURLConnection *connection = [NSURLConnection connectionWithRequest:request delegate:self];
    [connection start];
}

- (UIImage *)getImagesFromServerWithUrl:(NSString *)strUrl
{
    NSURL *url = [NSURL URLWithString:strUrl];
    NSData *data = [NSData dataWithContentsOfURL:url];
    UIImage *image = [UIImage imageWithData:data];
    return image;
}

#pragma mark - urlconnection methods

- (void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)data
{
    [container appendData:data];
}

- (void)connectionDidFinishLoading:(NSURLConnection *)connection
{
    [self parseResult:container];
}

- (void)parseResult:(NSData *)data
{
    NSLog(@"parseResult in Base");
}

#pragma mark - logout methods
-(void) logout
{
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Log Out" message:@"Are you sure you want to log out?" delegate:self cancelButtonTitle:@"Cancel" otherButtonTitles:@"Ok",nil];
    [alert show];
}

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (buttonIndex == 0)
    {
        
    }
    if (buttonIndex == 1)
    {
        NSLog(@"You have clicked OK");
        NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
        [NSUserDefaults resetStandardUserDefaults];
        
//        [defaults setBool:NO forKey:KEY_LOGIN_STATUS];
//        [defaults setObject:nil forKey:KEY_LOGIN_USERID];
//        [defaults setObject:nil forKey:KEY_LOGIN_FIRSTNAME];
//        [defaults setObject:nil forKey:KEY_LOGIN_LASTNAME];
//        [defaults setObject:nil forKey:KEY_LOGIN_MOBILE];
//        [defaults setObject:nil forKey:KEY_LOGIN_EMAIL];
        [defaults synchronize];
        
        AppDelegate *appDelegate = [[UIApplication sharedApplication] delegate];
        [appDelegate showLoginViewController];
    }
}

@end
