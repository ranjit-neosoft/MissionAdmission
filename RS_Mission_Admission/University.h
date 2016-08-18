//
//  University.h
//  Mission Admission
//
//  Created by Swapnil on 13/01/16.
//  Copyright (c) 2016 RS_Electronics_ranjitsChougale. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Address.h"

@interface University : NSObject

@property (nonatomic) int universityId;
@property (nonatomic) NSString *universityName;
@property (nonatomic) NSString *universityDescription;

@property (nonatomic) NSString *latitude;
@property (nonatomic) NSString *longitude;

@property (nonatomic) NSString *galleryImage1;
@property (nonatomic) NSString *galleryImage2;
@property (nonatomic) NSString *galleryImage3;
@property (nonatomic) NSString *galleryImage4;
@property (nonatomic) NSString *galleryImage5;

@property (nonatomic) NSString *universityImageName;
@property (nonatomic) NSString *universityLogo;

@property (nonatomic) NSString *addressLine1;
@property (nonatomic) NSString *city;
@property (nonatomic) NSString *state;
@property (nonatomic) NSString *pincode;
@property (nonatomic) NSString *phone;
@property (nonatomic) NSString *email;
@property (nonatomic) NSString *website;

@end
