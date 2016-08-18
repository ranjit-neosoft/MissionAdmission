//
//  CollegeListViewController.m
//  Mission Admission
//
//  Created by Swapnil on 13/01/16.
//  Copyright (c) 2016 RS_Electronics_ranjitsChougale. All rights reserved.
//

#import "CollegeListViewController.h"
#import "Utils.h"
#import "Constants.h"
#import "DeptCollege.h"
#import "CollegeDetailsViewController.h"
#import "UniversityListTableViewCell.h"
#import "UniversityDetailsViewController.h"

@interface CollegeListViewController ()

@end

@implementation CollegeListViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self.collegeTableView setRowHeight:75];
    //[self.collegeTableView setAlpha:0.7];
    [self.collegeTableView registerNib:[UINib nibWithNibName:@"UniversityListTableViewCell" bundle:nil] forCellReuseIdentifier:@"collegeCell"];
    self.navigationItem.title = @"Colleges";
    
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"info.png"] style:UIBarButtonItemStylePlain target:self action:@selector(universityInformation)];
    
    colleges = [[NSMutableArray alloc] init];
    filteredColleges = [[NSMutableArray alloc] init];
    [self fetchColleges];
    
}
- (void)universityInformation
{
    UniversityDetailsViewController *vc = (UniversityDetailsViewController *)  [Utils instantiateViewControllerWithId:@"UniversityDetailsVC"];
    vc.universityId = self.universityId;
    [self.navigationController pushViewController:vc animated:YES];
    

}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

- (void)fetchColleges
{
    int userId = [[[NSUserDefaults standardUserDefaults] valueForKey:KEY_LOGIN_USERID] intValue];
    NSString *strUrl = [NSString stringWithFormat:@"%@?universityId=%d&userId=%d", [Utils getURL:SERVLET_COLLEGE_LIST], self.universityId, userId];
    
    [self makeServerCallWithUrl:strUrl];
}

#pragma mark - JSON Parser methods
- (void)parseResult:(NSData *)data
{
    NSArray *tempCollege = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];
    [colleges removeAllObjects];
    
    for (NSDictionary *dictionary in tempCollege)
    {
        DeptCollege *college = [[DeptCollege alloc] init];
        college.collegeId = [[dictionary valueForKey:@"CollegeId"] intValue];
        college.collegeName= [dictionary valueForKey:@"CollegeName"];
        college.collegeLogo= [dictionary valueForKey:@"CollegeLogo"];
        
        college.city = [dictionary valueForKey:@"City"];
        
        [colleges addObject:college];
    }
    [self.collegeTableView reloadData];
}

#pragma mark - tableView methods

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UniversityListTableViewCell *cell = [self.collegeTableView dequeueReusableCellWithIdentifier:@"collegeCell"];
    if (cell == nil)
    {
        cell = [[UniversityListTableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:@"collegeCell"];
    }
    
    DeptCollege *college;
    if (self.isFiltered)
        college = [filteredColleges objectAtIndex:indexPath.row];
    
     else
          college = [colleges objectAtIndex:indexPath.row];
    
    cell.labelUniversityName.text = college.collegeName;
    cell.labelUniversityCity.text = college.city;
    
    NSString *strUrl = [NSString stringWithFormat:@"%@/Images/%@.jpg", SERVER_URL, college.collegeLogo];
    
    UIImage *image = [self getImagesFromServerWithUrl:strUrl];
    
    cell.labelUniversityLogo.layer.cornerRadius = cell.labelUniversityLogo.frame.size.height /2;
    cell.labelUniversityLogo.layer.masksToBounds = YES;
    cell.labelUniversityLogo.layer.borderWidth = 0;
    cell.labelUniversityLogo.clipsToBounds = YES;
    
    cell.labelUniversityLogo.image = image;
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    
    return cell;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)sectio
{
    if (self.isFiltered)
        return [filteredColleges count];
    else
        return [colleges count];
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [self showDetailsForIndexPath:indexPath];
    [self.collegeTableView deselectRowAtIndexPath:indexPath animated:YES];
}

-(void) showDetailsForIndexPath:(NSIndexPath*)indexPath
{
    [self.searchBar resignFirstResponder];
    CollegeDetailsViewController *vc = (CollegeDetailsViewController *)  [Utils instantiateViewControllerWithId:@"CollegeDetailsVC"];
    
    DeptCollege *college;
    
    if(self.isFiltered)
        college = [filteredColleges objectAtIndex:indexPath.row];

    else
        college = [colleges objectAtIndex:indexPath.row];

    vc.collegeId = college.collegeId;
    [self.navigationController pushViewController:vc animated:YES];

}

- (void)searchBar:(UISearchBar *)searchBar textDidChange:(NSString *)searchText
{
    if(searchText.length == 0)
        self.isFiltered = FALSE;
    else
    {
        self.isFiltered = true;
        filteredColleges = [[NSMutableArray alloc] init];
        
        for (DeptCollege* college in colleges)
        {
            NSRange nameRange = [college.collegeName rangeOfString:searchText options:NSCaseInsensitiveSearch];
            NSRange descriptionRange = [college.city rangeOfString:searchText options:NSCaseInsensitiveSearch];
            if(nameRange.location != NSNotFound || descriptionRange.location != NSNotFound)
            {
                [filteredColleges addObject:college];
            }
        }
    }
    [self.collegeTableView reloadData];
}

@end
