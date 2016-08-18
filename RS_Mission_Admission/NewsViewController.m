//
//  NewsViewController.m
//  Mission Admission
//
//  Created by Swapnil on 16/01/16.
//  Copyright (c) 2016 RS_Electronics_ranjitsChougale. All rights reserved.
//

#import "NewsViewController.h"
#import "Utils.h"
#import "Constants.h"
#import "News.h"

@interface NewsViewController ()

@end

@implementation NewsViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.navigationItem.title = @"News";
    
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"Logout" style:UIBarButtonItemStyleDone target:self action:@selector(logoutUser)];
     newsFromServer = [[NSMutableArray alloc] init];
    
    [self fetchNews];
    
}
//make url
- (void)fetchNews
{
    NSString *strUrl = [Utils getURL:SERVLET_NEWS];
    [self makeServerCallWithUrl:strUrl];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

//logout button action
- (void)logoutUser
{
    [self logout];
}

#pragma mark - JSON Parser methods
- (void)parseResult:(NSData *)data
{
    NSArray *tempNews = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];
    [newsFromServer removeAllObjects];
    
    for (NSDictionary *dictionary in tempNews)
    {
        News *news = [[News alloc] init];
        
        news.newsDescription = [dictionary valueForKey:@"NewsDescription"];
        news.universityName = [dictionary valueForKey:@"UniversityName"];
        //news.universityImageName = [dictionary valueForKey:@"UniversityImageName"];
        news.city = [dictionary valueForKey:@"City"];
        [newsFromServer addObject:news];
    }
    
    [self displayNewsOnscrollView];
   //[self.newsScrollView reloadData];
}

-(void) displayNewsOnscrollView
{
    int width = self.scrollView.frame.size.width;
    int height = self.scrollView.frame.size.height;
    
    for (int index = 0; index < [newsFromServer count]; index++)
    {
        News *news = [newsFromServer objectAtIndex:index];
        
        UITextView *textView = [[UITextView alloc] init];
        textView.text = [NSString stringWithFormat:@"%@ \n\n-%@, %@",news.newsDescription, news.universityName, news.city];
        textView.frame = CGRectMake(index * width, 0, 300, 150);
        textView.editable=NO;
        [textView setFont:[UIFont systemFontOfSize:15]];
        [textView setBackgroundColor:[UIColor clearColor]];
        textView.textAlignment = NSTextAlignmentCenter;
//
//        NSString *imageName = [NSString stringWithFormat:@"%@.jpg",news.universityImageName];
//        
//        UIImage *image = [UIImage imageNamed:imageName];
//        self.imageview.image = image;
        
        
        [self.scrollView addSubview:textView];
       // [self.scrollView addSubview:self.imageview];
//
//        UILabel *label = [[UILabel alloc] init];
//        label.text = news.universityName;
//        label.frame = CGRectMake(index * width, 245, 300, 63);
//        [label setFont:[UIFont systemFontOfSize:18]];
//        [label setBackgroundColor:[UIColor clearColor]];
//        label.textAlignment = NSTextAlignmentCenter;
//        [self.baseScrollView addSubview:label];
        
    }
    
    currentIndex = 1;
    self.scrollView.contentSize = CGSizeMake(width * [newsFromServer count], height);
    [NSTimer scheduledTimerWithTimeInterval:5 target:self selector:@selector(changeNews) userInfo:nil repeats:YES];
}

- (void)changeNews
{
    NSLog(@"changeNews");
    int width = self.scrollView.frame.size.width;
    if (currentIndex < [newsFromServer count])
    {
        self.scrollView.contentOffset = CGPointMake(currentIndex * width, 0);
        currentIndex++;
    } else
    {
        currentIndex = 0;
    }
}

@end
