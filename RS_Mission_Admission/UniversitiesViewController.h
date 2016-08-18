//
//  UniversitiesViewController.h
//  Mission Admission
//
//  Created by Swapnil on 15/01/16.
//  Copyright (c) 2016 RS_Electronics_ranjitsChougale. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AppDelegate.h"
#import "BaseViewController.h"
@class CollegeUniversity;


@interface UniversitiesViewController : BaseViewController <UISearchBarDelegate, NSURLConnectionDataDelegate, UITableViewDataSource, UITableViewDelegate>
{
    NSMutableArray *filteredUniversties;
    NSMutableArray *universities;
}

@property (weak, nonatomic) IBOutlet UISearchBar *searchBar;

@property (nonatomic, assign) bool isFiltered;

@property (weak, nonatomic) IBOutlet UITableView *universitiesTableView;

@end
