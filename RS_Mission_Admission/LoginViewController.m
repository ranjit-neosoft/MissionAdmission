//
//  LoginViewController.m
//  Mission Admission
//
//  Created by Swapnil on 12/01/16.
//  Copyright (c) 2016 RS_Electronics_ranjitsChougale. All rights reserved.
//

#import "LoginViewController.h"
#import "Utils.h"
#import "Constants.h"
#import "PasswordChangeViewController.h"

@interface LoginViewController ()

@end

@implementation LoginViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.labelSignIn.layer.cornerRadius = self.labelSignIn.frame.size.height /2;
    self.labelSignIn.layer.borderWidth = 1;
    self.labelSignIn.layer.masksToBounds = YES;
    //self.labelSignIn.clipsToBounds = YES;
    self.labelSignIn.layer.borderColor =[UIColor colorWithRed:189.0/255.0f green:189.0/255.0f blue:189.0/255.0f alpha:1.0].CGColor;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

- (IBAction)loginUser:(id)sender//sign in button clicked
{
    if ([self.editName.text length] == 0)//if user name not enter
    {
        [Utils showAlert:@"Please Enter Admission ID"];
    }
    else if ([self.editPassword.text length] == 0)//if passeord not enter
    {
        [Utils showAlert:@"Please Enter Password"];
    }
    else//check username & password validation
    {
        NSString *admissionId = self.editName.text;//get username
        NSString *password = self.editPassword.text;//get password
        
        NSString *url = [NSString stringWithFormat:@"%@?admissionId=%@&password=%@", [Utils getURL:SERVLET_LOGIN], admissionId, password];//make url
        
        NSURL *url1 = [NSURL URLWithString:url];
        NSData *data = [NSData dataWithContentsOfURL:url1];//get data from url
        
        NSError *error;
        NSDictionary *dictionary = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:&error];//get data to dictionary
       
        NSString *status = [dictionary valueForKey:@"status"];
        
        if ([status isEqualToString:@"failure"])
        {
            [Utils showAlert:@"Invalid user name or password"];
        }
        else if ([status isEqualToString:@"success"])
        {
//            [[NSUserDefaults standardUserDefaults] setValue:AccountTxtField.text forKey:@"Account"];
//            [[NSUserDefaults standardUserDefaults] setValue:UserTxtField.text forKey:@"Username"];
//            [[NSUserDefaults standardUserDefaults] setValue:passwordTxtField.text forKey:@"password"];
//            [[NSUserDefaults standardUserDefaults] synchronize];
          
           
            NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
            [defaults setBool:YES forKey:KEY_LOGIN_STATUS];
        

            [defaults setValue:[dictionary valueForKey:@"UserId"] forKey:KEY_LOGIN_USERID];
            [defaults setValue:[dictionary valueForKey:@"Email"] forKey:KEY_LOGIN_EMAIL];
            [defaults setValue:[dictionary valueForKey:@"FirstName"] forKey:KEY_LOGIN_FIRSTNAME];
             [defaults setValue:[dictionary valueForKey:@"LastName"] forKey:KEY_LOGIN_LASTNAME];
             [defaults setValue:[dictionary valueForKey:@"Mobile"] forKey:KEY_LOGIN_MOBILE];
            
            [defaults synchronize];
            
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Sign In" message:@"Sign In successful" delegate:self cancelButtonTitle:nil otherButtonTitles:nil];
            [alert show];
            
            [self performSelector:@selector(dismiss:) withObject:alert afterDelay:1.0];
          
            AppDelegate *appDelegate = [[UIApplication sharedApplication] delegate];
            [appDelegate showHomeNavigation];
        }
    }
}
-(void)dismiss:(UIAlertView*)alert
{
    [alert dismissWithClickedButtonIndex:0 animated:YES];
}
- (IBAction)forgotPassword:(id)sender
{
    PasswordChangeViewController *vc = (PasswordChangeViewController *)  [Utils instantiateViewControllerWithId:@"PasswordChangeVC"];
    [self presentViewController:vc animated:YES completion:nil];
}

@end
