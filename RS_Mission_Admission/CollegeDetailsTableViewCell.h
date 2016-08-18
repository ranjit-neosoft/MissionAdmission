//
//  CollegeDetailsTableViewCell.h
//  Mission Admission
//
//  Created by Swapnil on 14/01/16.
//  Copyright (c) 2016 RS_Electronics_ranjitsChougale. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CollegeDetailsTableViewCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UIImageView *collegeImage;
@property (weak, nonatomic) IBOutlet UIImageView *collegeLogo;
@property (weak, nonatomic) IBOutlet UILabel *labelCity1;
@property (weak, nonatomic) IBOutlet UILabel *labelCollegeCode;
@property (weak, nonatomic) IBOutlet UILabel *labelCollegeName;
@property (weak, nonatomic) IBOutlet UILabel *labelCollegeStatus;
@property (weak, nonatomic) IBOutlet UILabel *labelCollegeFees;
@property (weak, nonatomic) IBOutlet UILabel *labelAddressLine;
@property (weak, nonatomic) IBOutlet UILabel *labelCity;
@property (weak, nonatomic) IBOutlet UILabel *labelState;
@property (weak, nonatomic) IBOutlet UILabel *labelPincode;

@property (weak, nonatomic) IBOutlet UIButton *labelEmailButton;
@property (weak, nonatomic) IBOutlet UIButton *labelWebsiteButton;
@property (weak, nonatomic) IBOutlet UIButton *labelPhoneButton;

- (IBAction)callCollege:(id)sender;
- (IBAction)gotoCollegeWebsite:(id)sender;
- (IBAction)sendEmailCollege:(id)sender;

@end
