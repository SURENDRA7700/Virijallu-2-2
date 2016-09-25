//
//  SponsorsTableViewController.m
//  Virijallu
//
//  Created by Vishal on 09/01/15.
//  Copyright (c) 2015 Vishal. All rights reserved.
//

#import "SponsorsTableViewController.h"
#import "FMCellTableViewCell.h"
#import "EventsDetailsViewController.h"
#import "AFNetworking.h"

#import "DataHelper.h"

#import "AFNetworking.h"
#import "UIImageView+AFNetworking.h"

@interface SponsorsTableViewController ()
{
    NSMutableArray *contentArray;
}
@end

@implementation SponsorsTableViewController


- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

//
-(void)displayFechedContent:(NSArray*)feachedArray{
    [contentArray removeAllObjects];
    contentArray =[feachedArray mutableCopy];
    
    [self.tableView reloadData];
    [self removeActivityIndicator];

}

- (void)viewDidLoad
{
    [super viewDidLoad];
    contentArray = [[NSMutableArray alloc]init];;
    
    UILabel *heading =  [[UILabel alloc] init];
    [heading setText: @"Offer & Discounts"];
    [heading setTextColor:[UIColor whiteColor]];
    heading.font=[UIFont fontWithName:@"HelveticaNeue-CondensedBold" size:19];
    [heading setTextAlignment:NSTextAlignmentCenter];
    heading.frame = CGRectMake(0, 0, 180, 25);
    self.navigationItem.titleView =heading;

    [self showActivityIndicator];
//self.navigationItem.titleView = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"logo.PNG"]];
  
    
 /*   UIImageView *tempImageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"Default"]];
    [tempImageView setFrame:self.tableView.frame];
    self.tableView.backgroundView = tempImageView;
  */
    
     [self.navigationController.navigationBar setBarTintColor:[UIColor colorWithRed:4/255.0 green:39/255.0 blue:104/255.0 alpha:1]];
    
      
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
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

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:YES];
    DataHelper *dataHelper = [DataHelper sharedInstance];
    [dataHelper dataFromUrl:@"http://198.24.154.201/~viri/mobile/webcopy/getwbs_sponsors.php"];
    dataHelper.dataDelegate = self;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
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

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    CGFloat navHeight = self.navigationController.navigationBarHidden ? 0 :
    self.navigationController.navigationBar.frame.size.height;
    float h = 80 * [contentArray count];
    int tableHeight = [[UIScreen mainScreen] bounds].size.height - navHeight+20;
    
    if(h > [[UIScreen mainScreen] bounds].size.height - navHeight+20 )
    {
        _tableView.frame = CGRectMake(0, navHeight+20, self.view.frame.size.width, tableHeight);
    }
    else
    {
        _tableView.frame = CGRectMake(0, navHeight+20, self.view.frame.size.width, h);
    }

    
    return [contentArray count];
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 83;
}

- (UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *indentifier = @"cell";
    FMCellTableViewCell *cell = (FMCellTableViewCell*)[tableView dequeueReusableCellWithIdentifier:indentifier forIndexPath:indexPath];
    //cell.textLabel.text = [[contentArray objectAtIndex:indexPath.row] objectForKey:@"title"];
    //  cell.detailTextLabel.text = [[contentArray objectAtIndex:indexPath.row] objectForKey:@"descr"];
    cell.firstText.text =[[contentArray objectAtIndex:indexPath.row] objectForKey:@"title"];
    cell.secondText.text =[[contentArray objectAtIndex:indexPath.row] objectForKey:@"descr"];
    
    NSString *urlString = [NSString stringWithFormat:@"http://198.24.154.201/~viri/mobile/sponsers/%@",[[contentArray objectAtIndex:indexPath.row] objectForKey:@"image"]];
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL: [NSURL URLWithString:urlString]];
    
    [cell.imgView setImageWithURLRequest:request placeholderImage:nil success:^(NSURLRequest *request, NSHTTPURLResponse *response, UIImage *image) {
        [cell.imgView setImage:image];
        // NSLog(@"setImageWithURLRequest");
    } failure:^(NSURLRequest *request, NSHTTPURLResponse *response, NSError *error) {
        // NSLog(@"Error %@",request);
    }];
    
    
    
    return cell;
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{

    
//    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main_iPhone" bundle:nil];
//    EventsDetailsViewController *evviewController = [storyboard instantiateViewControllerWithIdentifier:@"EventsDetailsViewController"];
//    evviewController.eventtitleString =[[contentArray objectAtIndex:indexPath.row] objectForKey:@"title"];
//    evviewController.eventdescriptionString =[[contentArray objectAtIndex:indexPath.row] objectForKey:@"descr"];
//    evviewController.eventImageName =[[contentArray objectAtIndex:indexPath.row] objectForKey:@"image"];
//    evviewController.eventImageURL = @"http://198.24.154.201/~viri/mobile/sponsers/";
//    [self.navigationController pushViewController:evviewController animated:YES];
}


@end
