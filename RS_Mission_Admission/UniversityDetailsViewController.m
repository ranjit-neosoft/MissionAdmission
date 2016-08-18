//
//  UniversityDetailsViewController.m
//  Mission Admission
//
//  Created by Swapnil on 15/01/16.
//  Copyright (c) 2016 RS_Electronics_ranjitsChougale. All rights reserved.
//

#import "UniversityDetailsViewController.h"
#import "Utils.h"
#import "Constants.h"
#import "UniversityDetailsTableViewCell.h"
#import "WebsiteViewController.h"
#import <MessageUI/MessageUI.h>
#import <MapKit/MapKit.h>
#import "MyAnnotation.h"

@interface UniversityDetailsViewController ()<MFMessageComposeViewControllerDelegate, MFMailComposeViewControllerDelegate>

@end

@implementation UniversityDetailsViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self.universityDetailsTableView setRowHeight:1100];
    [self.universityDetailsTableView registerNib:[UINib nibWithNibName:@"UniversityDetailsTableViewCell" bundle:nil] forCellReuseIdentifier:@"universityDetailsCell"];
    self.navigationItem.title = @"University Details";
    
    universityDetails = [[NSMutableArray alloc] init];
    
    
    [self fetchUniversityDetails];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

- (void)fetchUniversityDetails
{
    int userId = [[[NSUserDefaults standardUserDefaults] valueForKey:KEY_LOGIN_USERID] intValue];
    NSString *strUrl = [NSString stringWithFormat:@"%@?universityId=%d&userId=%d", [Utils getURL:SERVLET_UNIVERSITY_DETAILS], self.universityId, userId];
    
    [self makeServerCallWithUrl:strUrl];
}

#pragma mark - JSON Parser methods

- (void)parseResult:(NSData *)data
{
    NSArray *tempUniversity = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];
    [universityDetails removeAllObjects];
    
    for (NSDictionary *dictionary in tempUniversity)
    {
        University *university = [[University alloc] init];
       
        university.universityName= [dictionary valueForKey:@"UniversityName"];
        university.universityDescription= [dictionary valueForKey:@"UniversityDescription"];
        university.galleryImage1= [dictionary valueForKey:@"GalleryImage1"];
        university.galleryImage2= [dictionary valueForKey:@"GalleryImage2"];
        university.galleryImage3= [dictionary valueForKey:@"GalleryImage3"];
        university.galleryImage4= [dictionary valueForKey:@"GalleryImage4"];
        university.galleryImage5= [dictionary valueForKey:@"GalleryImage5"];
        
        university.universityImageName= [dictionary valueForKey:@"UniversityImageName"];
        university.universityLogo = [dictionary valueForKey:@"UniversityLogo"];
        university.addressLine1= [dictionary valueForKey:@"AddressLine"];
        university.city= [dictionary valueForKey:@"City"];
        university.state= [dictionary valueForKey:@"State"];
        university.pincode= [dictionary valueForKey:@"Pincode"];
        university.phone = [dictionary valueForKey:@"Phone"];
        university.email = [dictionary valueForKey:@"Email"];
        university.website = [dictionary valueForKey:@"Website"];
        university.latitude = [dictionary valueForKey:@"Latitude"];
        university.longitude = [dictionary valueForKey:@"Longitude"];
        
        [universityDetails addObject:university];
    }
    [self.universityDetailsTableView reloadData];
}

#pragma mark - tableView methods

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UniversityDetailsTableViewCell *cell = [self.universityDetailsTableView dequeueReusableCellWithIdentifier:@"universityDetailsCell"];
    if (cell == nil)
    {
        cell = [[UniversityDetailsTableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:@"universityDetailsCell"];
    }

    University *university = [universityDetails objectAtIndex:indexPath.row];
    
    NSString *strUrl = [NSString stringWithFormat:@"%@/Images/%@.jpg", SERVER_URL, university.universityImageName];
    NSString *strUrl1 = [NSString stringWithFormat:@"%@/Images/%@.jpg", SERVER_URL, university.universityLogo];
    NSString *strUrlGalleryImage1 = [NSString stringWithFormat:@"%@/Images/%@.jpg", SERVER_URL, university.galleryImage1];
    NSString *strUrlGalleryImage2 = [NSString stringWithFormat:@"%@/Images/%@.jpg", SERVER_URL, university.galleryImage2];
    NSString *strUrlGalleryImage3 = [NSString stringWithFormat:@"%@/Images/%@.jpg", SERVER_URL, university.galleryImage3];
    NSString *strUrlGalleryImage4 = [NSString stringWithFormat:@"%@/Images/%@.jpg", SERVER_URL, university.galleryImage4];
    NSString *strUrlGalleryImage5 = [NSString stringWithFormat:@"%@/Images/%@.jpg", SERVER_URL, university.galleryImage5];

    
    UIImage *universityImage = [self getImagesFromServerWithUrl:strUrl];
    UIImage *universityLogo = [self getImagesFromServerWithUrl:strUrl1];
    UIImage *image1 = [self getImagesFromServerWithUrl:strUrlGalleryImage1];
    UIImage *image2 = [self getImagesFromServerWithUrl:strUrlGalleryImage2];
    UIImage *image3 = [self getImagesFromServerWithUrl:strUrlGalleryImage3];
    UIImage *image4 = [self getImagesFromServerWithUrl:strUrlGalleryImage4];
    UIImage *image5 = [self getImagesFromServerWithUrl:strUrlGalleryImage5];
    
    cell.labelUniversityDescription.text = university.universityDescription;
    
    
    cell.universityLogo.layer.cornerRadius = cell.universityLogo.frame.size.height /2;
    cell.universityLogo.layer.masksToBounds = YES;
    cell.universityLogo.layer.borderWidth = 0;
    cell.universityLogo.clipsToBounds = YES;
    
    cell.universityImage.image = universityImage;
    cell.universityLogo.image = universityLogo;
    cell.labelUniversityName.text= university.universityName;
    cell.labelCityState.text = [NSString stringWithFormat:@"%@ | %@", university.city, university.state];
    cell.labelAddress.text= university.addressLine1;
    cell.labelCity.text= university.city;
    cell.labelState.text= university.state;
    cell.labelPincode.text= university.pincode;
    
    self.websiteUrl = university.website;
    self.phoneUrl = university.phone;
    self.emailUrl = university.email;
    
    self.latitude = [university.latitude doubleValue];
    self.longitude = [university.longitude doubleValue];
    
    [cell.labelEmailButton  setTitle:university.phone forState:normal];
    [cell.labelPhoneButton setTitle:university.email forState:normal];
    [cell.labelWebsiteButton setTitle:university.website forState:normal];
    
    [cell.labelWebsiteButton addTarget:self action:@selector(gotoUniversityWebsite) forControlEvents:UIControlEventTouchUpInside];
    
    [cell.labelPhoneButton addTarget:self action:@selector(callUniversity) forControlEvents:UIControlEventTouchUpInside];
    
    [cell.labelEmailButton addTarget:self action:@selector(emailUniversity) forControlEvents:UIControlEventTouchUpInside];
    
    
    //-----------------
    int width = cell.scrollView.frame.size.width;
    int height = cell.scrollView.frame.size.height;
    
    images = @[universityImage,image1,image2,image3,image4,image5];
    
    for (int index = 0; index < [images count]; index++)
    {
        
        //NSString *imageName = [images objectAtIndex:index];
        //UIImage *image = [UIImage imageNamed:imageName];
        UIImage *image = [images objectAtIndex:index];
        UIImageView *imageView = [[UIImageView alloc] init];
        imageView.image = image;
        
        imageView.frame = CGRectMake(index * width, 0, width, height);
        [cell.scrollView addSubview:imageView];
        
    }
    
    currentIndex = 1;
    cell.scrollView.contentSize = CGSizeMake(width * [images count], height);
//   [NSTimer scheduledTimerWithTimeInterval:5 target:cell selector:@selector(changeImage) userInfo:nil repeats:YES];
    
    //-------------
    
    //Map Implaementation
    
//    cell.locationManager = [[CLLocationManager alloc] init];
//    cell.locationManager.delegate = cell;
//    [cell.locationManager startUpdatingLocation];
    
    cell.mapView.delegate = cell;
    MyAnnotation *universityAnnotation = [[MyAnnotation alloc] initLatitude:self.latitude withLongitude:self.longitude withTitle:university.universityName withSubtitle:university.city withImageName:university.universityImageName];
    [cell.mapView addAnnotation:universityAnnotation];
//    MKCoordinateRegion region = MKCoordinateRegionMakeWithDistance(universityAnnotation.coordinate, self.latitude, self.longitude);
//    [cell.mapView setRegion:[cell.mapView regionThatFits:region] animated:YES];


    cell.selectionStyle = UITableViewCellSelectionStyleNone;

    return cell;
}



//-(NSInteger) numberOfSectionsInTableView:(UITableView *)tableView
//{
//    return 2;
//}
-(void)callUniversity
{
    NSString *strUrl = [NSString stringWithFormat:@"tel://%@", self.phoneUrl];
    NSURL *url = [NSURL URLWithString:strUrl];
    [[UIApplication sharedApplication] openURL:url];
}
-(void)gotoUniversityWebsite
{
    WebsiteViewController *vc = (WebsiteViewController *)  [Utils instantiateViewControllerWithId:@"WebsiteVC"];
    vc.websiteUrl = self.websiteUrl;
    [self.navigationController pushViewController:vc animated:YES];
}

-(void)emailUniversity
{
//    // Email Subject
//    NSString *emailTitle = @"Test Email";
//    // Email Content
//    NSString *messageBody = @"iOS programming is so fun!";
//    // To address
//    NSString *emailId = [NSString stringWithFormat:@"%@", self.emailUrl];
//   // NSArray *toRecipents = [NSArray arrayWithObject:@"ranjitschougale1@gmail.com"];
//    
//    MFMailComposeViewController *mc = [[MFMailComposeViewController alloc] init];
//    mc.mailComposeDelegate = self;
//    [mc setSubject:emailTitle];
//    [mc setMessageBody:messageBody isHTML:NO];
//    [mc setToRecipients:@[emailId]];
//    
//    // Present mail view controller on screen
//    [self presentViewController:mc animated:YES completion:NULL];
    
    if ([MFMailComposeViewController canSendMail])
    {
        MFMailComposeViewController *mail = [[MFMailComposeViewController alloc] init];
        mail.mailComposeDelegate = self;
        [mail setSubject:@"Regarding Asmissions"];
        [mail setMessageBody:@"Here is some main text in the email!" isHTML:NO];
        [mail setToRecipients:@[@"ranjitschougale@gmail.com"]];
        
        [self presentViewController:mail animated:YES completion:NULL];
    }
    else
    {
        NSLog(@"This device cannot send email");
    }
}

- (void)messageComposeViewController:(MFMessageComposeViewController *)controller didFinishWithResult:(MessageComposeResult)result
{
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)mailComposeController:(MFMailComposeViewController *)controller didFinishWithResult:(MFMailComposeResult)result error:(NSError *)error
{
    switch (result) {
        case MFMailComposeResultSent:
            NSLog(@"You sent the email.");
            break;
        case MFMailComposeResultSaved:
            NSLog(@"You saved a draft of this email");
            break;
        case MFMailComposeResultCancelled:
            NSLog(@"You cancelled sending this email.");
            break;
        case MFMailComposeResultFailed:
            NSLog(@"Mail failed:  An error occurred when trying to compose this email");
            break;
        default:
            NSLog(@"An error occurred when trying to compose this email");
            break;
    }
    
    [self dismissViewControllerAnimated:YES completion:NULL];
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)sectio
{
    return [universityDetails count];
}

//- (MKAnnotationView *)mapView:(MKMapView *)mapView viewForAnnotation:(id<MKAnnotation>)annotation {
//    
//    MyAnnotation *myAnnotation = (MyAnnotation *)annotation;
//    
//    MKAnnotationView *annotationView = [[MKAnnotationView alloc] init];
//    annotationView.image = [UIImage imageNamed:myAnnotation.imageName];
//    annotationView.canShowCallout = YES;
//    
//    UIButton *button = [UIButton buttonWithType:UIButtonTypeDetailDisclosure];
//    annotationView.rightCalloutAccessoryView = button;
//    
//    UIImageView *imageView = [[UIImageView alloc] init];
//    imageView.frame = CGRectMake(0, 0, 40, 40);
//    imageView.image = [UIImage imageNamed:@"ShivajiUniversity.jpg"];
//    annotationView.leftCalloutAccessoryView = imageView;
//    return annotationView;
//}
//
//- (void)mapView:(MKMapView *)mapView annotationView:(MKAnnotationView *)view calloutAccessoryControlTapped:(UIControl *)control {
//    
//    MyAnnotation *myAnnotation = (MyAnnotation *) view.annotation;
//    
//    NSString *message = [NSString stringWithFormat:@"Selected annotation: %@", myAnnotation.title];
//    
//    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"tapped" message:message delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
//    [alert show];
//}


@end
