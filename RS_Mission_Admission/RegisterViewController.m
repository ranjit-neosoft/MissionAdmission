//
//  RegisterViewController.m
//  Mission Admission
//
//  Created by Swapnil on 12/01/16.
//  Copyright (c) 2016 RS_Electronics_ranjitsChougale. All rights reserved.
//

#import "RegisterViewController.h"
#import "Utils.h"
#import "Constants.h"

@interface RegisterViewController ()

@end

@implementation RegisterViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    //self.labelRegisterButton.layer.cornerRadius = 7;
//    self.labelRegisterButton.layer.borderWidth = 1;
//    self.labelRegisterButton.layer.borderColor =[UIColor colorWithRed:189.0/255.0f green:189.0/255.0f blue:189.0/255.0f alpha:1.0].CGColor;
    self.labelRegisterButton.layer.cornerRadius = self.labelRegisterButton.frame.size.height /2;
    self.labelRegisterButton.layer.borderWidth = 1;
    self.labelRegisterButton.layer.masksToBounds = YES;
    
    self.labelRegisterButton.clipsToBounds = YES;
    self.labelRegisterButton.layer.borderColor =[UIColor colorWithRed:189.0/255.0f green:189.0/255.0f blue:189.0/255.0f alpha:1.0].CGColor;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

- (IBAction)registerUser:(id)sender
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
    else if ([self.editFirstName.text length] == 0)
    {
        [Utils showAlert:@"Please Enter First Name"];
    }
    else if ([self.editLastName.text length] == 0)
    {
        [Utils showAlert:@"Please Enter Last Name"];
    }
    else if ([self.editMobile.text length] == 0)
    {
        [Utils showAlert:@"Please Enter Mobile"];
    }
    else
    {
        NSString *strUrl = [NSString stringWithFormat:@"%@?email=%@&password=%@&firstName=%@&lastName=%@&mobile=%@", [Utils getURL:SERVLET_REGISTER],
                            self.editEmail.text, self.editPassword.text, self.editFirstName.text,self.editLastName.text,self.editMobile.text];
        NSURL *url = [NSURL URLWithString:strUrl];
        NSData *data = [NSData dataWithContentsOfURL:url];
        NSString *result = [[NSString alloc] initWithData:data encoding:NSASCIIStringEncoding];
        
        if ([result isEqualToString:@"-1"])
        {
            [Utils showAlert:@"You can not user this user name"];
        }
        else if ([result isEqualToString:@"0"])
        {
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Register User" message:@"User register successfully" delegate:nil cancelButtonTitle:nil otherButtonTitles:nil];
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
- (IBAction)back:(id)sender
{
    [self dismissViewControllerAnimated:YES completion:nil];
}
@end
