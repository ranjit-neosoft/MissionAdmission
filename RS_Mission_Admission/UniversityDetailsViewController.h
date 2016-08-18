//
//  UniversityDetailsViewController.h
//  Mission Admission
//
//  Created by Swapnil on 15/01/16.
//  Copyright (c) 2016 RS_Electronics_ranjitsChougale. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AppDelegate.h"
#import "BaseViewController.h"
#import "University.h"

@interface UniversityDetailsViewController : BaseViewController <NSURLConnectionDataDelegate,UITableViewDataSource, UITableViewDelegate>
{
    NSMutableArray *universityDetails;
    NSArray *images;
    int currentIndex;
}



@property (weak, nonatomic) IBOutlet UITableView *universityDetailsTableView;

@property (nonatomic) int universityId;

@property (nonatomic) NSString *websiteUrl;
@property (nonatomic) NSString *emailUrl;
@property (nonatomic) NSString *phoneUrl;

@property (nonatomic) double latitude;
@property (nonatomic) double longitude;

@end
