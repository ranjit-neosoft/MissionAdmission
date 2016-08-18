//
//  UniversityDetailsTableViewCell.h
//  Mission Admission
//
//  Created by Swapnil on 15/01/16.
//  Copyright (c) 2016 RS_Electronics_ranjitsChougale. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MapKit/MapKit.h>

@interface UniversityDetailsTableViewCell : UITableViewCell <MKMapViewDelegate, CLLocationManagerDelegate>


@property (nonatomic) CLLocationManager *locationManager;
@property (weak, nonatomic) IBOutlet UILabel *labelUniversityDescription;

@property (weak, nonatomic) IBOutlet UILabel *labelUniversityName;
@property (weak, nonatomic) IBOutlet UILabel *labelAddress;
@property (weak, nonatomic) IBOutlet UILabel *labelCity;
@property (weak, nonatomic) IBOutlet UILabel *labelState;
@property (weak, nonatomic) IBOutlet UILabel *labelPincode;

@property (weak, nonatomic) IBOutlet UIImageView *universityImage;
@property (weak, nonatomic) IBOutlet UILabel *labelCityState;
@property (weak, nonatomic) IBOutlet UIImageView *universityLogo;
@property (weak, nonatomic) IBOutlet UIScrollView *scrollView;

@property (weak, nonatomic) IBOutlet UIButton *labelPhoneButton;
@property (weak, nonatomic) IBOutlet UIButton *labelEmailButton;
@property (weak, nonatomic) IBOutlet UIButton *labelWebsiteButton;
- (IBAction)callUniversity:(id)sender;
- (IBAction)gotoUniversityWebsite:(id)sender;

@property (weak, nonatomic) IBOutlet MKMapView *mapView;

- (IBAction)emailUniversity:(id)sender;


@end
