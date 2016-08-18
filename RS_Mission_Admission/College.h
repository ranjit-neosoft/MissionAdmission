//
//  College.h
//  Mission Admission
//
//  Created by Swapnil on 13/01/16.
//  Copyright (c) 2016 RS_Electronics_ranjitsChougale. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface College : NSObject

@property (nonatomic) int universityId;
@property (nonatomic) int addressId;
@property (nonatomic) int collegeId;

@property (nonatomic) NSString *collegeName;
@property (nonatomic) int collegeCode;
@property (nonatomic) NSString *collegeStatus;
@property (nonatomic) NSString *collegeFees;
@property (nonatomic) NSString *collegeRank;
@property (nonatomic) NSString *collegeImageName;
@property (nonatomic) NSString *collegeLogo;

@property (nonatomic) NSString *addressLine1;
@property (nonatomic) NSString *city;
@property (nonatomic) NSString *state;
@property (nonatomic) NSString *pincode;
@property (nonatomic) NSString *phone;
@property (nonatomic) NSString *email;
@property (nonatomic) NSString *website;

@property (nonatomic) int isFavorite;

@end
