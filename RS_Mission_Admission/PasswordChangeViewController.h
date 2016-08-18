//
//  PasswordChangeViewController.h
//  Mission Admission
//
//  Created by Swapnil on 18/01/16.
//  Copyright (c) 2016 RS_Electronics_ranjitsChougale. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AppDelegate.h"
#import "BaseViewController.h"

@interface PasswordChangeViewController : BaseViewController

@property (weak, nonatomic) IBOutlet UITextField *editEmail;
@property (weak, nonatomic) IBOutlet UITextField *editPassword;
@property (weak, nonatomic) IBOutlet UITextField *editConfirmPassword;

- (IBAction)goBack:(id)sender;
@property (weak, nonatomic) IBOutlet UIButton *labelChangePasswordButton;

- (IBAction)changePassword:(id)sender;

@end
