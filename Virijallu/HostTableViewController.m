//
//  HostTableViewController.m
//  Virijallu
//
//  Created by Vishal on 09/01/15.
//  Copyright (c) 2015 Vishal. All rights reserved.
//

#import "HostTableViewController.h"
#import "FMCellTableViewCell.h"
@interface HostTableViewController ()
{
    NSMutableArray *contentArray;
}
@end

@implementation HostTableViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

-(void)displayFechedContent:(NSArray*)feachedArray{
    [contentArray removeAllObjects];
    contentArray =[feachedArray mutableCopy];
    
    [self.tablView reloadData];
    [self removeActivityIndicator];

}

- (void)viewDidLoad
{
    [super viewDidLoad];
   // self.navigationItem.titleView = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"logo.PNG"]];
    
    UILabel *heading =  [[UILabel alloc] init];
    [heading setText: @"Host"];
    heading.font=[UIFont fontWithName:@"HelveticaNeue-CondensedBold" size:19];
    [heading setTextColor:[UIColor whiteColor]];
    [heading setTextAlignment:NSTextAlignmentCenter];
    heading.frame = CGRectMake(0, 0, 180, 25);
    self.navigationItem.titleView =heading;


    contentArray = [[NSMutableArray alloc]init];;
    [self showActivityIndicator];
    DataHelper *dataHelper = [DataHelper sharedInstance];
    [dataHelper dataFromUrl:@"http://198.24.154.201/~viri/mobile/webservices/getwbs_hosts.php"];
    dataHelper.dataDelegate = self;
    
    UIImageView *tempImageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"Default"]];
    [tempImageView setFrame:self.tablView.frame];
    self.tablView.backgroundView = tempImageView;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

#pragma mark - ActivityIndicator

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
    return [contentArray count];
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 90;
}
- (UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *indentifier = @"cell";
    FMCellTableViewCell *cell = (FMCellTableViewCell*)[tableView dequeueReusableCellWithIdentifier:indentifier forIndexPath:indexPath];
    cell.firstText.text = [[contentArray objectAtIndex:indexPath.row] objectForKey:@"title"];
    cell.secondText.text = [[contentArray objectAtIndex:indexPath.row] objectForKey:@"descr"];
    return cell;
}

@end
