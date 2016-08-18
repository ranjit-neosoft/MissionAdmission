//
//  UniversityListTableViewCell.h
//  Mission Admission
//
//  Created by Swapnil on 13/01/16.
//  Copyright (c) 2016 RS_Electronics_ranjitsChougale. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UniversityListTableViewCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UIImageView *labelUniversityLogo;
@property (weak, nonatomic) IBOutlet UILabel *labelUniversityName;
@property (weak, nonatomic) IBOutlet UILabel *labelUniversityCity;

@end
