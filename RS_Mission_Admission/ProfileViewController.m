//
//  ProfileViewController.m
//  Mission Admission
//
//  Created by Swapnil on 16/01/16.
//  Copyright (c) 2016 RS_Electronics_ranjitsChougale. All rights reserved.
//

#import "ProfileViewController.h"
#import "Utils.h"
#import "Constants.h"
@interface ProfileViewController ()

@end

@implementation ProfileViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.navigationItem.title = @"Profile";
    
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"Logout" style:UIBarButtonItemStyleDone target:self action:@selector(logoutUser)];
    self.profileImageBackView.layer.cornerRadius = 10;
    
    self.profileImageView.layer.cornerRadius = self.profileImageView.frame.size.height /2;
    self.profileImageView.layer.masksToBounds = YES;
    self.profileImageView.layer.borderWidth = 0;
    self.profileImageView.clipsToBounds = YES;
    
//    self.profileImageView.layer.cornerRadius = self.profileImageView.frame.size.width / 2;
//    self.profileImageView.clipsToBounds = YES;
    [self fetchQuotes];
    [self fetchUserDetails];
}

-(void) fetchQuotes
{
    int width = self.quoteScrollView.frame.size.width;
    int height = self.quoteScrollView.frame.size.height;
    
    NSString *quote1 = @"Welcome to Mission Admission Support";
    NSString *quote2 = @"“Live as if you were to die tomorrow. Learn as if you were to live forever.”   –Gandhi";
    NSString *quote3 = @"“Do not wait to strike till the iron is hot; but make it hot by striking.”       –William Butler Yeats";
    NSString *quote4 = @"“Learning is not a spectator sport.” –D. Blocher";
    NSString *quote5 = @"“Education is what survives when what has been learned has been forgotten.”   –B. F. Skinner";
    NSString *quote6 = @"“Learn from yesterday, live for today, hope for tomorrow.”                – Albert Einstein";
    NSString *quote7 = @"“The purpose of learning is growth, and our minds, unlike our bodies, can continue growing as long as we live.”     –Mortimer Adler";
    
    NSString *quote8 = @"“Whatever you can do, or dream you can do, begin it. Boldness has genius, power, and magic in it. Begin it now.”     –Goethe";
    NSString *quote9 = @"“Learning is like rowing upstream, not to advance is to drop back.”        –Chinese Proverb";
    NSString *quote10 = @"“Be a student as long as you still have something to learn, and this will mean all your life.”                      –Henry L. Doherty";
    
    quotes = @[quote1,quote2,quote3,quote4,quote5,quote6,quote7,quote8,quote9,quote10];

    for (int index = 0; index < [quotes count]; index++)
    {
        
        //NSString *imageName = [images objectAtIndex:index];
        //UIImage *image = [UIImage imageNamed:imageName];
       // UILabel *label = [quotes objectAtIndex:index];
        UITextView *textView = [[UITextView alloc] init];
        textView.text = [quotes objectAtIndex:index];;
        textView.frame = CGRectMake(index * width, 0, width, height);
        [textView setFont:[UIFont systemFontOfSize:18]];
        [textView setBackgroundColor:[UIColor clearColor]];
        textView.textAlignment = NSTextAlignmentCenter;
        
        [self.quoteScrollView addSubview:textView];
        
    }
    
    currentIndex = 1;
    self.quoteScrollView.contentSize = CGSizeMake(width * [quotes count], height);
    [NSTimer scheduledTimerWithTimeInterval:5 target:self selector:@selector(changeQuotes) userInfo:nil repeats:YES];
}

- (void)changeQuotes
{
    NSLog(@"changeImage");
    int width = self.quoteScrollView.frame.size.width;
    if (currentIndex < [quotes count])
    {
        self.quoteScrollView.contentOffset = CGPointMake(currentIndex * width, 0);
        currentIndex++;
    } else
    {
        currentIndex = 0;
    }
}

-(void)fetchUserDetails
{
    NSString *firstName = [[NSUserDefaults standardUserDefaults] valueForKey:KEY_LOGIN_FIRSTNAME];
    
    NSString *lastName = [[NSUserDefaults standardUserDefaults] valueForKey:KEY_LOGIN_LASTNAME];
    
    NSString *mobile = [[NSUserDefaults standardUserDefaults] valueForKey:KEY_LOGIN_MOBILE];
    
    NSString *email = [[NSUserDefaults standardUserDefaults] valueForKey:KEY_LOGIN_EMAIL];
    
    self.userName.text = [NSString stringWithFormat:@"%@ %@", firstName, lastName];
    self.emailId.text = email;
    self.userMobile.text = mobile;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

- (void)logoutUser
{
    [self logout];
}

@end
