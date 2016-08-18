//
//  WebsiteViewController.h
//  Mission Admission
//
//  Created by Swapnil on 18/01/16.
//  Copyright (c) 2016 RS_Electronics_ranjitsChougale. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AppDelegate.h"
#import "BaseViewController.h"

@interface WebsiteViewController : BaseViewController
@property (weak, nonatomic) IBOutlet UIActivityIndicatorView *spinner;

@property (weak, nonatomic) IBOutlet UIWebView *websiteView;
@property (nonatomic) NSString *websiteUrl;

@end
