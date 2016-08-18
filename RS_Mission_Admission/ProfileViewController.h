//
//  ProfileViewController.h
//  Mission Admission
//
//  Created by Swapnil on 16/01/16.
//  Copyright (c) 2016 RS_Electronics_ranjitsChougale. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AppDelegate.h"
#import "BaseViewController.h"

@interface ProfileViewController : BaseViewController
{
    NSArray *quotes;
    int currentIndex;
}
@property (weak, nonatomic) IBOutlet UIView *profileImageBackView;

@property (weak, nonatomic) IBOutlet UILabel *userName;

@property (weak, nonatomic) IBOutlet UILabel *emailId;
@property (weak, nonatomic) IBOutlet UILabel *userMobile;
@property (weak, nonatomic) IBOutlet UIImageView *profileImageView;
@property (weak, nonatomic) IBOutlet UIScrollView *quoteScrollView;

@end
