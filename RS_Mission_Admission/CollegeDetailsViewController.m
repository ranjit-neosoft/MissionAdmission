//
//  CollegeDetailsViewController.m
//  Mission Admission
//
//  Created by Swapnil on 14/01/16.
//  Copyright (c) 2016 RS_Electronics_ranjitsChougale. All rights reserved.
//

#import "CollegeDetailsViewController.h"
#import "Utils.h"
#import "Constants.h"
#import "CollegeDetailsTableViewCell.h"
#import "DepartmentDetailsTableViewCell.h"
#import "WebsiteViewController.h"
#import <MessageUI/MessageUI.h>

@interface CollegeDetailsViewController ()<MFMessageComposeViewControllerDelegate, MFMailComposeViewControllerDelegate>

@end

@implementation CollegeDetailsViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [self.collegeDetailsTableView registerNib:[UINib nibWithNibName:@"CollegeDetailsTableViewCell" bundle:nil] forCellReuseIdentifier:@"collegeDetailsCell"];
    
    [self.collegeDetailsTableView registerNib:[UINib nibWithNibName:@"DepartmentDetailsTableViewCell" bundle:nil] forCellReuseIdentifier:@"departmentDetailsCell"];
    self.navigationItem.title = @"College Details";
    
    collegeDetails = [[NSMutableArray alloc] init];
    departmentDetails = [[NSMutableArray alloc] init];
    [self fetchCollegeDetails];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

- (void)fetchCollegeDetails
{
    int userId = [[[NSUserDefaults standardUserDefaults] valueForKey:KEY_LOGIN_USERID] intValue];
    NSString *strUrl = [NSString stringWithFormat:@"%@?collegeId=%d&userId=%d", [Utils getURL:SERVLET_COLLEGE_DETAILS], self.collegeId, userId];
    
    [self makeServerCallWithUrl:strUrl];
}

- (void)parseResult:(NSData *)data
{
    NSXMLParser *parser = [[NSXMLParser alloc] initWithData:data];
    parser.delegate = self;
    [parser parse];
}

#pragma mark - XML Parser methods
- (void)parserDidStartDocument:(NSXMLParser *)parser
{
    [collegeDetails removeAllObjects];
    [departmentDetails removeAllObjects];
}

- (void)parserDidEndDocument:(NSXMLParser *)parser
{
    [self.collegeDetailsTableView reloadData];
}

- (void)parser:(NSXMLParser *)parser didStartElement:(NSString *)elementName namespaceURI:(NSString *)namespaceURI qualifiedName:(NSString *)qName attributes:(NSDictionary *)attributeDict
{
    if ([elementName isEqualToString:@"CollegeDetail"])
    {
        tempCollege = [[College alloc] init];
    }
    else if ([elementName isEqualToString:@"Department"])
    {
        tempDept = [[Dept alloc] init];
    }
}

- (void)parser:(NSXMLParser *)parser didEndElement:(NSString *)elementName namespaceURI:(NSString *)namespaceURI qualifiedName:(NSString *)qName
{
    
    if ([elementName isEqualToString:@"CollegeCode"])//int
    {
        tempCollege.collegeCode = [tempData intValue];
    }
    else if ([elementName isEqualToString:@"CollegeName"])
    {
        tempCollege.collegeName = tempData;
    }
    else if ([elementName isEqualToString:@"CollegeStatus"])
    {
        tempCollege.collegeStatus = tempData;
    }
    else if ([elementName isEqualToString:@"CollegeFees"])
    {
        tempCollege.collegeFees = tempData;
    }
    else if ([elementName isEqualToString:@"CollegeImageName"])
    {
        tempCollege.collegeImageName = tempData;
    }
    else if ([elementName isEqualToString:@"CollegeLogo"])
    {
        tempCollege.collegeLogo = tempData;
    }
    
    else if ([elementName isEqualToString:@"AddressLine"])
    {
        tempCollege.addressLine1 = tempData;
    }
    else if ([elementName isEqualToString:@"City"])
    {
        tempCollege.city = tempData;
    }
    else if ([elementName isEqualToString:@"State"])
    {
        tempCollege.state = tempData;
    }
    else if ([elementName isEqualToString:@"Pincode"])
    {
        tempCollege.pincode = tempData;
    }
    else if ([elementName isEqualToString:@"Phone"])
    {
        tempCollege.phone = tempData;
    }
    else if ([elementName isEqualToString:@"Email"])
    {
        tempCollege.email = tempData;
    }
    else if ([elementName isEqualToString:@"Website"])
    {
        tempCollege.website = tempData;
    }
    else if ([elementName isEqualToString:@"CollegeDetail"])
    {
        [collegeDetails addObject:tempCollege];
    }
    
    
    else if ([elementName isEqualToString:@"DepartmentName"])
    {
        tempDept.departmentName = tempData;
    }
    else if ([elementName isEqualToString:@"DepartmentIntake"])
    {
        tempDept.departmentIntake = [tempData intValue];
    }
    else if ([elementName isEqualToString:@"DepartmentCutoff"])
    {
        tempDept.departmentCutoff = [tempData intValue];
    }
    else if ([elementName isEqualToString:@"Department"])
    {
        [departmentDetails addObject:tempDept];
    }
}

- (void)parser:(NSXMLParser *)parser foundCharacters:(NSString *)string
{
    tempData = string;
}

#pragma mark - tableView methods
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString* collegeDetailsCell = @"collegeDetailsCell";
    
    CollegeDetailsTableViewCell *collegeCell = (CollegeDetailsTableViewCell*) [self.collegeDetailsTableView dequeueReusableCellWithIdentifier:collegeDetailsCell];
    
    if (collegeCell == nil)
    {
        NSArray *nib = [[NSBundle mainBundle] loadNibNamed: collegeDetailsCell owner:nil options:nil];
        collegeCell = (CollegeDetailsTableViewCell*) [nib objectAtIndex:0];
        
    }
    
    static NSString* departmentDetailsCell = @"departmentDetailsCell";
    DepartmentDetailsTableViewCell *departmentCell = (DepartmentDetailsTableViewCell*) [self.collegeDetailsTableView dequeueReusableCellWithIdentifier:departmentDetailsCell];
    
    if (departmentCell == nil)
    {
        NSArray *nib = [[NSBundle mainBundle] loadNibNamed: collegeDetailsCell owner:nil options:nil];
        departmentCell = (DepartmentDetailsTableViewCell*) [nib objectAtIndex:0];
        
    }

    if([indexPath section] == 0)
    {
        [self.collegeDetailsTableView setRowHeight:690];
        College *college = [collegeDetails objectAtIndex:indexPath.row];
        
        NSString *strUrl = [NSString stringWithFormat:@"%@/Images/%@.jpg", SERVER_URL, college.collegeImageName];
        
        UIImage *image = [self getImagesFromServerWithUrl:strUrl];
        
        NSString *strUrlLogo = [NSString stringWithFormat:@"%@/Images/%@.jpg", SERVER_URL, college.collegeLogo];
        
        UIImage *logo = [self getImagesFromServerWithUrl:strUrlLogo];
        
        collegeCell.collegeLogo.layer.cornerRadius = collegeCell.collegeLogo.frame.size.height /2;
        collegeCell.collegeLogo.layer.masksToBounds = YES;
        collegeCell.collegeLogo.layer.borderWidth = 0;
        collegeCell.collegeLogo.clipsToBounds = YES;
        
        collegeCell.collegeImage.image = image;
        collegeCell.collegeLogo.image = logo;
        
        collegeCell.labelCity1.text =[NSString stringWithFormat:@"%@ | %@", college.city, college.state];
 
        collegeCell.labelCollegeCode.text= [NSString stringWithFormat:@"%d", college.collegeCode];
        collegeCell.labelCollegeName.text= college.collegeName;
        collegeCell.labelCollegeStatus.text= college.collegeStatus;
        collegeCell.labelCollegeFees.text= college.collegeFees;
        collegeCell.labelAddressLine.text= college.addressLine1;
        collegeCell.labelCity.text= college.city;
        collegeCell.labelState.text= college.state;
        collegeCell.labelPincode.text= college.pincode;
        //collegeCell.labelPhone.text= college.phone;
        //collegeCell.labelEmail.text= college.email;
        //collegeCell.labelWebsite.text= college.website;
        
        self.websiteUrl = college.website;
        self.phoneUrl = college.phone;
        self.emailUrl = college.email;
        
        [collegeCell.labelEmailButton  setTitle:college.phone forState:normal];
        [collegeCell.labelPhoneButton setTitle:college.email forState:normal];
        [collegeCell.labelWebsiteButton setTitle:college.website forState:normal];
        
        [collegeCell.labelWebsiteButton addTarget:self action:@selector(gotoCollegeWebsite) forControlEvents:UIControlEventTouchUpInside];
        
        [collegeCell.labelPhoneButton addTarget:self action:@selector(callCollege) forControlEvents:UIControlEventTouchUpInside];
        
        [collegeCell.labelEmailButton addTarget:self action:@selector(sendEmailCollege) forControlEvents:UIControlEventTouchUpInside];
        
        collegeCell.selectionStyle = UITableViewCellSelectionStyleNone;
        
    return collegeCell;
    }
    
    else if ([indexPath section] == 1)
    {
        [self.collegeDetailsTableView setRowHeight:30];
        Dept *department = [departmentDetails objectAtIndex:indexPath.row];
        departmentCell.labelDepartmentName.text = department.departmentName;
        departmentCell.labelDepartmentIntake.text = [NSString stringWithFormat:@"%d", department.departmentIntake];
        departmentCell.labelDepartmentCutoff.text = [NSString stringWithFormat:@"%d", department.departmentCutoff];
        departmentCell.selectionStyle = UITableViewCellSelectionStyleNone;
        
    }
    return departmentCell;
}
-(void)gotoCollegeWebsite
{
    WebsiteViewController *vc = (WebsiteViewController *)  [Utils instantiateViewControllerWithId:@"WebsiteVC"];
    vc.websiteUrl = self.websiteUrl;
    [self.navigationController pushViewController:vc animated:YES];
}

-(void)callCollege
{
    NSString *strUrl = [NSString stringWithFormat:@"tel://%@", self.phoneUrl];
    NSURL *url = [NSURL URLWithString:strUrl];
    [[UIApplication sharedApplication] openURL:url];
}

- (void)messageComposeViewController:(MFMessageComposeViewController *)controller didFinishWithResult:(MessageComposeResult)result
{
    [self dismissViewControllerAnimated:YES completion:nil];
}

-(void)sendEmailCollege
{
    // Email Subject
    NSString *emailTitle = @"Regarding Admissions";
    // Email Content
    NSString *messageBody = @"";
    // To address
    NSArray *toRecipents = [NSArray arrayWithObject:@"ranjitschougale1@gmail.com"];
    
    MFMailComposeViewController *mc = [[MFMailComposeViewController alloc] init];
    mc.mailComposeDelegate = self;
    [mc setSubject:emailTitle];
    [mc setMessageBody:messageBody isHTML:NO];
    [mc setToRecipients:toRecipents];
    
    // Present mail view controller on screen
    [self presentViewController:mc animated:YES completion:NULL];
    
    
//    MFMailComposeViewController *vc = [[MFMailComposeViewController alloc] init];
//    [vc setMessageBody:@"This is a simple email" isHTML:NO];
//    [vc setToRecipients:@[@"pythoncpp@gmail.com"]];
//    [vc setSubject:@"This is a subject"];
//    vc.mailComposeDelegate = self;
//    [self presentViewController:vc animated:YES completion:nil];
}
- (void) mailComposeController:(MFMailComposeViewController *)controller didFinishWithResult:(MFMailComposeResult)result error:(NSError *)error
{
    switch (result)
    {
        case MFMailComposeResultCancelled:
            NSLog(@"Mail cancelled");
            break;
        case MFMailComposeResultSaved:
            NSLog(@"Mail saved");
            break;
        case MFMailComposeResultSent:
            NSLog(@"Mail sent");
            break;
        case MFMailComposeResultFailed:
            NSLog(@"Mail sent failure: %@", [error localizedDescription]);
            break;
        default:
            break;
    }
    
    // Close the Mail Interface
    [self dismissViewControllerAnimated:YES completion:NULL];
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    NSInteger rows = 0;
    if (section == 0)
    {
        rows = [collegeDetails count];
    }
    else if(section == 1)
        
    {
        rows = [departmentDetails count];
    }
    return rows;
}

-(NSInteger) numberOfSectionsInTableView:(UITableView *)tableView
{
    return 2;
}

@end
