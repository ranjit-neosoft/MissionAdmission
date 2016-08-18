//
//  BaseViewController.h
//  Mission Admission
//
//  Created by Swapnil on 12/01/16.
//  Copyright (c) 2016 RS_Electronics_ranjitsChougale. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BaseViewController : UIViewController
{
    NSMutableData *container;
}

- (void)makeServerCallWithUrl:(NSString *)strUrl;
- (void)parseResult:(NSData *)data;
- (UIImage *)getImagesFromServerWithUrl:(NSString *)strUrl;
-(void)logout;

@end

