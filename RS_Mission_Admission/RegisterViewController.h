//
//  RegisterViewController.h
//  Mission Admission
//
//  Created by Swapnil on 12/01/16.
//  Copyright (c) 2016 RS_Electronics_ranjitsChougale. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AppDelegate.h"
#import "BaseViewController.h"

@interface RegisterViewController : BaseViewController

@property (weak, nonatomic) IBOutlet UITextField *editEmail;
@property (weak, nonatomic) IBOutlet UITextField *editPassword;
@property (weak, nonatomic) IBOutlet UITextField *editConfirmPassword;
@property (weak, nonatomic) IBOutlet UITextField *editFirstName;
@property (weak, nonatomic) IBOutlet UITextField *editLastName;
@property (weak, nonatomic) IBOutlet UITextField *editMobile;
@property (weak, nonatomic) IBOutlet UIButton *labelRegisterButton;

- (IBAction)registerUser:(id)sender;
- (IBAction)back:(id)sender;

@end
