//
//  PasswordChangeViewController.m
//  Mission Admission
//
//  Created by Swapnil on 18/01/16.
//  Copyright (c) 2016 RS_Electronics_ranjitsChougale. All rights reserved.
//

#import "PasswordChangeViewController.h"
#import "Utils.h"
#import "Constants.h"
@interface PasswordChangeViewController ()

@end

@implementation PasswordChangeViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    //self.labelChangePasswordButton.layer.cornerRadius = 7;
    self.labelChangePasswordButton.layer.cornerRadius = self.labelChangePasswordButton.frame.size.height /2;
    self.labelChangePasswordButton.layer.borderWidth = 1;
    self.labelChangePasswordButton.layer.masksToBounds = YES;
    
    self.labelChangePasswordButton.clipsToBounds = YES;
    self.labelChangePasswordButton.layer.borderColor =[UIColor colorWithRed:189.0/255.0f green:189.0/255.0f blue:189.0/255.0f alpha:1.0].CGColor;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

- (IBAction)goBack:(id)sender
{
     [self dismissViewControllerAnimated:YES completion:nil];
}

- (IBAction)changePassword:(id)sender
{
    if ([self.editEmail.text length] == 0)
    {
        [Utils showAlert:@"Please Enter Email ID"];
    }
    else if ([self.editPassword.text length] == 0)
    {
        [Utils showAlert:@"Please Enter Password"];
    }
    else if ([self.editConfirmPassword.text length] == 0)
    {
        [Utils showAlert:@"Please Confirm Password"];
    }
    else if (![self.editPassword.text isEqualToString: self.editConfirmPassword.text])
    {
        [Utils showAlert:@"Password Not Match"];
    }
    else
    {
        NSString *strUrl = [NSString stringWithFormat:@"%@?email=%@&password=%@", [Utils getURL:SERVLET_PASSWORDCHANGE],
                            self.editEmail.text, self.editPassword.text];
        
        NSURL *url1 = [NSURL URLWithString:strUrl];
        NSData *data = [NSData dataWithContentsOfURL:url1];
        
        NSError *error;
        NSDictionary *dictionary = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:&error];
        
        NSString *status = [dictionary valueForKey:@"status"];
        
        if ([status isEqualToString:@"failure"])
        {
            [Utils showAlert:@"You user name does not exist create your new account."];
        }
        else if ([status isEqualToString:@"success"])
        {
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Password" message:@"Password reset successful" delegate:self cancelButtonTitle:nil otherButtonTitles:nil];
            [alert show];
            
            [self performSelector:@selector(dismiss:) withObject:alert afterDelay:1.0];
            
            [self dismissViewControllerAnimated:YES completion:nil];
        }
    }
}

-(void)dismiss:(UIAlertView*)alert
{
    [alert dismissWithClickedButtonIndex:0 animated:YES];
}
@end
