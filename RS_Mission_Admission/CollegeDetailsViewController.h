//
//  CollegeDetailsViewController.h
//  Mission Admission
//
//  Created by Swapnil on 14/01/16.
//  Copyright (c) 2016 RS_Electronics_ranjitsChougale. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AppDelegate.h"
#import "BaseViewController.h"
#import "College.h"
#import "Dept.h"

@interface CollegeDetailsViewController : BaseViewController <NSXMLParserDelegate, UITableViewDataSource, UITableViewDelegate>
{
    College *tempCollege;
    Dept *tempDept;
    NSString *tempData;
    NSMutableArray *collegeDetails;
    NSMutableArray *departmentDetails;
}

@property (nonatomic) int collegeId;
@property (nonatomic) NSString *websiteUrl;
@property (nonatomic) NSString *emailUrl;
@property (nonatomic) NSString *phoneUrl;
@property (weak, nonatomic) IBOutlet UITableView *collegeDetailsTableView;

@end
