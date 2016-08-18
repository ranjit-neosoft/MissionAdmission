//
//  DepartmentDetailsTableViewCell.h
//  Mission Admission
//
//  Created by Swapnil on 14/01/16.
//  Copyright (c) 2016 RS_Electronics_ranjitsChougale. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DepartmentDetailsTableViewCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UILabel *labelDepartmentName;
@property (weak, nonatomic) IBOutlet UILabel *labelDepartmentIntake;
@property (weak, nonatomic) IBOutlet UILabel *labelDepartmentCutoff;

@end
