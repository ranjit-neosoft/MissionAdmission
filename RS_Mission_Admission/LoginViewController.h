//
//  LoginViewController.h
//  Mission Admission
//
//  Created by Swapnil on 12/01/16.
//  Copyright (c) 2016 RS_Electronics_ranjitsChougale. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AppDelegate.h"
#import "BaseViewController.h"


@interface LoginViewController : BaseViewController

@property (weak, nonatomic) IBOutlet UITextField *editName;//to get username
@property (weak, nonatomic) IBOutlet UITextField *editPassword;//to get user password
@property (weak, nonatomic) IBOutlet UIButton *labelSignIn;//label for button name

- (IBAction)loginUser:(id)sender;//sign in button action
- (IBAction)forgotPassword:(id)sender;//forgot password button action

@end
