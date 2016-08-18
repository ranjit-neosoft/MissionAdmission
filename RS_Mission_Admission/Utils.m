//
//  Utils.m
//  Mission Admission
//
//  Created by Swapnil on 12/01/16.
//  Copyright (c) 2016 RS_Electronics_ranjitsChougale. All rights reserved.
//

#import "Utils.h"
#import <UIKit/UIKit.h>
#import "Constants.h"

@implementation Utils

+ (void)showAlert:(NSString *)message
{
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Error" message:message delegate:nil cancelButtonTitle:@"Ok" otherButtonTitles:nil];
    [alert show];
}

+ (NSString *)getURL:(NSString *)page
{
    return [NSString stringWithFormat:@"%@/%@", SERVER_URL, page];
}

+ (UIViewController *)instantiateViewControllerWithId:(NSString *)vcId
{
    return [[UIStoryboard storyboardWithName:@"Main" bundle:nil] instantiateViewControllerWithIdentifier:vcId];
}

@end

