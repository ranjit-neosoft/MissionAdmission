//
//  CollegeListViewController.h
//  Mission Admission
//
//  Created by Swapnil on 13/01/16.
//  Copyright (c) 2016 RS_Electronics_ranjitsChougale. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AppDelegate.h"
#import "BaseViewController.h"

@class DeptCollege;
@interface CollegeListViewController : BaseViewController <UISearchBarDelegate, NSURLConnectionDataDelegate, UITableViewDataSource, UITableViewDelegate>
{
     NSMutableArray *filteredColleges;
    NSMutableArray *colleges;
}

@property (weak, nonatomic) IBOutlet UISearchBar *searchBar;

@property (nonatomic) int universityId;

@property (nonatomic, assign) bool isFiltered;

@property (weak, nonatomic) IBOutlet UITableView *collegeTableView;

@end
