//
//  UniversitiesViewController.m
//  Mission Admission
//
//  Created by Swapnil on 15/01/16.
//  Copyright (c) 2016 RS_Electronics_ranjitsChougale. All rights reserved.
//

#import "UniversitiesViewController.h"
#import "Utils.h"
#import "Constants.h"
#import "CollegeUniversity.h"
#import "UniversityDetailsViewController.h"
#import "UniversityListTableViewCell.h"

@interface UniversitiesViewController ()

@end

@implementation UniversitiesViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self.universitiesTableView setRowHeight:75];
    //[self.universitiesTableView setAlpha:0.7];
    [self.universitiesTableView registerNib:[UINib nibWithNibName:@"UniversityListTableViewCell" bundle:nil] forCellReuseIdentifier:@"universityCell"];
    
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
    [self.universitiesTableView reloadData];
}

#pragma mark - tableView methods

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UniversityListTableViewCell *cell = [self.universitiesTableView dequeueReusableCellWithIdentifier:@"universityCell"];
    if (cell == nil)
    {
        cell = [[UniversityListTableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:@"universityCell"];
    }
    
    CollegeUniversity *university;
    if (self.isFiltered)
        university = [filteredUniversties objectAtIndex:indexPath.row];
    else
        university = [universities objectAtIndex:indexPath.row];

    cell.labelUniversityName.text = university.universityName;
    cell.labelUniversityCity.text = university.city;
    
    NSString *strUrl = [NSString stringWithFormat:@"%@/Images/%@.jpg", SERVER_URL, university.universityLogo];
    
    NSURL *url = [NSURL URLWithString:strUrl];
    NSData *data = [NSData dataWithContentsOfURL:url];
    UIImage *image = [UIImage imageWithData:data];
    
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
        return [filteredUniversties count];
    else
        return [universities count];
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [self showDetailsForIndexPath:indexPath];
    [self.universitiesTableView deselectRowAtIndexPath:indexPath animated:YES];
}

-(void) showDetailsForIndexPath:(NSIndexPath*)indexPath
{
    [self.searchBar resignFirstResponder];
    UniversityDetailsViewController *vc = (UniversityDetailsViewController *)  [Utils instantiateViewControllerWithId:@"UniversityDetailsVC"];
    
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
    [self.universitiesTableView reloadData];
}

@end
