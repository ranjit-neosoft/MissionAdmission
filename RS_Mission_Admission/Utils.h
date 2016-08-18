//
//  Utils.h
//  Mission Admission
//
//  Created by Swapnil on 12/01/16.
//  Copyright (c) 2016 RS_Electronics_ranjitsChougale. All rights reserved.
//

#import <Foundation/Foundation.h>

@class UIViewController;
@interface Utils : NSObject

+ (void)showAlert:(NSString *)message;
+ (NSString *)getURL:(NSString *)page;
+ (UIViewController *)instantiateViewControllerWithId:(NSString *)vcId;

@end