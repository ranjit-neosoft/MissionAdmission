//
//  NewsViewController.h
//  Mission Admission
//
//  Created by Swapnil on 16/01/16.
//  Copyright (c) 2016 RS_Electronics_ranjitsChougale. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AppDelegate.h"
#import "BaseViewController.h"

@interface NewsViewController : BaseViewController
{
    NSMutableArray *newsFromServer;
    int currentIndex;
    NSArray *array;
}

@property (weak, nonatomic) IBOutlet UIImageView *imageview;

@property (weak, nonatomic) IBOutlet UIScrollView *scrollView;

@end
