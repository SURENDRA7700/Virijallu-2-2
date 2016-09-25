//
//  AboutUsViewController.m
//  Virijallu
//
//  Created by Vishal on 09/01/15.
//  Copyright (c) 2015 Vishal. All rights reserved.
//

#import "AboutUsViewController.h"

@interface AboutUsViewController ()
{
    NSMutableArray *contentArray;
}
@end

@implementation AboutUsViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
   // self.navigationItem.titleView = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"logo.PNG"]];
    
    //    DataHelper *dataHelper = [DataHelper sharedInstance];
    //    [dataHelper dataFromUrl:@"http://198.24.154.201/~viri/mobile/webservices/getwbs_aboutus.php"];
    //    dataHelper.dataDelegate = self;
    UILabel *heading =  [[UILabel alloc] init];
    [heading setText: @"About Us"];
  heading.font=[UIFont fontWithName:@"HelveticaNeue-CondensedBold" size:19];
    [heading setTextColor:[UIColor whiteColor]];
    [heading setTextAlignment:NSTextAlignmentCenter];
    heading.frame = CGRectMake(0, 0, 180, 25);
    self.navigationItem.titleView =heading;
    
    
    [self.navigationController.navigationBar setBarTintColor:[UIColor colorWithRed:25/255.0 green:108/255.0 blue:4/255.0 alpha:1]];
    
    UIImage *img = [UIImage imageNamed:@"leftarrow1"];
    UIButton *backButton = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 48,48)];
    [backButton setBackgroundImage:img forState:UIControlStateNormal];
    UIBarButtonItem *barBackButtonItem = [[UIBarButtonItem alloc] initWithCustomView:backButton];
    [backButton addTarget:self action:@selector(popToViewController) forControlEvents:UIControlEventTouchUpInside];
    self.navigationItem.leftBarButtonItem = barBackButtonItem;
}

- (void)popToViewController;
{
    [self.navigationController popViewControllerAnimated:YES];
}


-(void)displayFechedContent:(NSArray*)feachedArray{
//    [contentArray removeAllObjects];
//    contentArray =[feachedArray mutableCopy];
//    _aboutUS_Lable.text = [[contentArray objectAtIndex:0] objectForKey:@"descr"];
//    [self removeActivityIndicator];
    
}


- (void)showActivityIndicator{
    if (progressHUD == nil) {
        progressHUD = [[MBProgressHUD alloc]initWithView:self.view];
    }
    [progressHUD removeFromSuperViewOnHide];
    progressHUD.labelText = @"Loading...";
    [progressHUD show:YES];
    [self.view  addSubview:progressHUD];
}

- (void)removeActivityIndicator{
    if (progressHUD) {
        progressHUD.hidden = YES;
        [progressHUD removeFromSuperview];
        progressHUD = nil;
    }
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
//http://198.24.154.201/~viri/mobile/webservices/getwbs_aboutus.php

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
