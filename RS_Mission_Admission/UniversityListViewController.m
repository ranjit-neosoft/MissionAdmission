//
//  UniversityListViewController.m
//  Mission Admission
//
//  Created by Swapnil on 12/01/16.
//  Copyright (c) 2016 RS_Electronics_ranjitsChougale. All rights reserved.
//

#import "UniversityListViewController.h"
#import "Utils.h"
#import "Constants.h"
#import "CollegeUniversity.h"
#import "CollegeListViewController.h"
#import "UniversityListTableViewCell.h"



@interface UniversityListViewController ()

@end

@implementation UniversityListViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    //[self.universityTableView setBackgroundColor:[UIColor colorWithPatternImage:[UIImage imageNamed:@"ShivajiUniversity.jpg"]]];
    
    [self.universityTableView setRowHeight:75];
    //[self.universityTableView setAlpha:0.7];
    [self.universityTableView registerNib:[UINib nibWithNibName:@"UniversityListTableViewCell" bundle:nil] forCellReuseIdentifier:@"universityCell"];

    self.navigationItem.title = @"Universities";
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"Logout" style:UIBarButtonItemStyleDone target:self action:@selector(logoutUser)];
    
    universities = [[NSMutableArray alloc] init];
    filteredUniversties = [[NSMutableArray alloc] init];
    [self fetchUniverties];
}

- (void)logoutUser
{
    [self logout];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

- (void)fetchUniverties
{
    NSString *strUrl = [Utils getURL:SERVLET_UNIVERSITY_LIST];
    [self makeServerCallWithUrl:strUrl];
}

#pragma mark - JSON Parser methods
- (void)parseResult:(NSData *)data
{
    NSArray *tempUniversities = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];
    [universities removeAllObjects];
    
    for (NSDictionary *dictionary in tempUniversities)
    {
        CollegeUniversity *university = [[CollegeUniversity alloc] init];
        
        university.universityId = [[dictionary valueForKey:@"UniversityId"] intValue];
        university.universityName= [dictionary valueForKey:@"UniversityName"];
        university.universityImageName = [dictionary valueForKey:@"UniversityImageName"];
        university.universityLogo = [dictionary valueForKey:@"UniversityLogo"];
        university.city = [dictionary valueForKey:@"City"];
        
        [universities addObject:university];
    }
   [self.universityTableView reloadData];
}


#pragma mark - tableView methods

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UniversityListTableViewCell *cell = [self.universityTableView dequeueReusableCellWithIdentifier:@"universityCell"];
    if (cell == nil)
    {
        cell = [[UniversityListTableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:@"universityCell"];
    }
    CollegeUniversity *university;
    if (self.isFiltered)
    {
        university = [filteredUniversties objectAtIndex:indexPath.row];
    }
    else
    {
        university = [universities objectAtIndex:indexPath.row];
    }
    
    cell.labelUniversityName.text = university.universityName;
    cell.labelUniversityCity.text = university.city;
        
    NSString *strUrl = [NSString stringWithFormat:@"%@/Images/%@.jpg", SERVER_URL, university.universityLogo];
    
    UIImage *image = [self getImagesFromServerWithUrl:strUrl];
    
    cell.labelUniversityLogo.layer.cornerRadius = cell.labelUniversityLogo.frame.size.height /2;
    cell.labelUniversityLogo.layer.masksToBounds = YES;
    cell.labelUniversityLogo.layer.borderWidth = 0;
    cell.labelUniversityLogo.clipsToBounds = YES;

    cell.labelUniversityLogo.image = image;
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    
    return cell;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (self.isFiltered)
        return [filteredUniversties count];
    else
       return [universities count];
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [self showDetailsForIndexPath:indexPath];
    [self.universityTableView deselectRowAtIndexPath:indexPath animated:YES];
}

-(void) showDetailsForIndexPath:(NSIndexPath*)indexPath
{
    [self.searchBar resignFirstResponder];
    CollegeListViewController *vc = (CollegeListViewController *)  [Utils instantiateViewControllerWithId:@"CollegeListVC"];

    CollegeUniversity *university;
    
    if(self.isFiltered)
        university = [filteredUniversties objectAtIndex:indexPath.row];
    else
        university = [universities objectAtIndex:indexPath.row];
    
    vc.universityId = university.universityId;
    [self.navigationController pushViewController:vc animated:YES];
}

- (void)searchBar:(UISearchBar *)searchBar textDidChange:(NSString *)searchText
{
    if(searchText.length == 0)
        self.isFiltered = FALSE;
    else
    {
        self.isFiltered = true;
        filteredUniversties = [[NSMutableArray alloc] init];
        
        for (CollegeUniversity* university in universities)
        {
            NSRange nameRange = [university.universityName rangeOfString:searchText options:NSCaseInsensitiveSearch];
            NSRange descriptionRange = [university.city rangeOfString:searchText options:NSCaseInsensitiveSearch];
            if(nameRange.location != NSNotFound || descriptionRange.location != NSNotFound)
            {
                [filteredUniversties addObject:university];
            }
        }
    }
    [self.universityTableView reloadData];
}

@end
