//
//  AppDelegate.h
//  Mission Admission
//
//  Created by Swapnil on 12/01/16.
//  Copyright (c) 2016 RS_Electronics_ranjitsChougale. All rights reserved.
//

#import <UIKit/UIKit.h>

@class LoginViewController;
@interface AppDelegate : UIResponder <UIApplicationDelegate>
{
    LoginViewController *loginViewController;
    UITabBarController *tabBarController;
}


@property (strong, nonatomic) UIWindow *window;

- (void)showHomeNavigation;
- (void)showLoginViewController;

@end

