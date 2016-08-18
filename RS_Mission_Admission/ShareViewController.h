//
//  ShareViewController.h
//  Mission Admission
//
//  Created by Swapnil on 19/01/16.
//  Copyright (c) 2016 RS_Electronics_ranjitsChougale. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Social/Social.h"
#import "AppDelegate.h"
#import "BaseViewController.h"

@interface ShareViewController : BaseViewController

- (IBAction)postOnTwitter:(id)sender;
- (IBAction)postOnFacebook:(id)sender;

@property (weak, nonatomic) IBOutlet UIButton *labelFacebookButton;
@property (weak, nonatomic) IBOutlet UIButton *labelTwitterButton;
@property (weak, nonatomic) IBOutlet UIView *backgroundView;

@end
