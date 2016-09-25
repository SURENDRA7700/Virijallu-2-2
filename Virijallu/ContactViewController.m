//
//  ContactViewController.m
//  Virijallu
//
//  Created by Vishal on 09/01/15.
//  Copyright (c) 2015 Vishal. All rights reserved.
//

#import "ContactViewController.h"
#import "DataHelper.h"


@interface ContactViewController ()
{
    NSMutableArray *contentArray;

}
@end

@implementation ContactViewController

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
    self.navigationItem.titleView = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"logo.PNG"]];
    DataHelper *dataHelper = [DataHelper sharedInstance];
    [dataHelper dataFromUrl:@"http://198.24.154.201/~viri/mobile/webservices/getwbs_contactus.php"];
    dataHelper.dataDelegate = self;
}
-(void)displayFechedContent:(NSArray*)feachedArray{
    [contentArray removeAllObjects];
    contentArray =[feachedArray mutableCopy];
    _aboutUS_Lable.text = [[contentArray objectAtIndex:0] objectForKey:@"descr"];
    [self removeActivityIndicator];
    
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

@end
