//
//  MoviesTableViewController.m
//  Virijallu
//
//  Created by Vishal on 09/01/15.
//  Copyright (c) 2015 Vishal. All rights reserved.
//

#import "MoviesTableViewController.h"
#import "FMCellTableViewCell.h"
#import "EventsDetailsViewController.h"
#import "AFNetworking.h"
#import "DataHelper.h"



#import "AFNetworking.h"
#import "UIImageView+AFNetworking.h"


@interface MoviesTableViewController ()
{
    NSMutableArray *contentArray;
    NSMutableArray *getContentArray;

}
@end

@implementation MoviesTableViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}
/*
 "msg": "Success",
 "result": [
 {
  "id": "5",
 "title": "Chinnadana Neekosam",
 "descr": "Good Movie,Nice Movie",
 "image": "1419589559_newmov.jpg"
 }
 ]
 */
-(void)displayFechedContent:(NSArray*)feachedArray{
    [getContentArray removeAllObjects];
    getContentArray =[feachedArray mutableCopy];
    NSSortDescriptor *sortDescriptor = [[NSSortDescriptor alloc] initWithKey:@"id"
                                                 ascending:NO];
    contentArray = [[getContentArray sortedArrayUsingDescriptors:[NSArray arrayWithObject:sortDescriptor]] mutableCopy];
    
    [self.tableView reloadData];
    [self removeActivityIndicator];

}
- (void)viewDidLoad
{
    [super viewDidLoad];
    contentArray = [[NSMutableArray alloc]init];;
    [self showActivityIndicator];
    
    UILabel *heading =  [[UILabel alloc] init];
    [heading setText: @"Movies"];
    heading.font=[UIFont fontWithName:@"HelveticaNeue-CondensedBold" size:19];
    [heading setTextColor:[UIColor whiteColor]];
    [heading setTextAlignment:NSTextAlignmentCenter];
    heading.frame = CGRectMake(0, 0, 180, 25);
    self.navigationItem.titleView =heading;
    
    [self.navigationController.navigationBar setBarTintColor:[UIColor colorWithRed:114/255.0 green:0/255.0 blue:102/255.0 alpha:1]];
   

    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    //self.navigationItem.titleView = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"logo.PNG"]];
}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:YES];
    dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0ul);
    dispatch_async(queue, ^{
    DataHelper *dataHelper = [DataHelper sharedInstance];
    [dataHelper dataFromUrl:@"http://198.24.154.201/~viri/mobile/webcopy/getwbs_movies.php"];
    dataHelper.dataDelegate = self;
    });

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

- (UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *indentifier = @"cell";
    FMCellTableViewCell *cell = (FMCellTableViewCell*)[tableView dequeueReusableCellWithIdentifier:indentifier forIndexPath:indexPath];
    
    cell.firstText.text =[[contentArray objectAtIndex:indexPath.row] objectForKey:@"title"];
    cell.subtitleLbl.text =[[contentArray objectAtIndex:indexPath.row] objectForKey:@"starring"];
    NSString *urlString = [NSString stringWithFormat:@"http://198.24.154.201/~viri/mobile/movies/%@",[[contentArray objectAtIndex:indexPath.row] objectForKey:@"image"]];
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL: [NSURL URLWithString:urlString]];

    [cell.imgView setImageWithURLRequest:request placeholderImage:nil success:^(NSURLRequest *request, NSHTTPURLResponse *response, UIImage *image) {
        [cell.imgView setImage:image];
    } failure:^(NSURLRequest *request, NSHTTPURLResponse *response, NSError *error) {
    }];
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 120;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main_iPhone" bundle:nil];
    EventsDetailsViewController *evviewController = [storyboard instantiateViewControllerWithIdentifier:@"EventsDetailsViewController"];
    evviewController.eventtitleString =[[contentArray objectAtIndex:indexPath.row] objectForKey:@"title"];
    evviewController.eventdescriptionString =[[contentArray objectAtIndex:indexPath.row] objectForKey:@"descr"];
    evviewController.eventImageName =[[contentArray objectAtIndex:indexPath.row] objectForKey:@"image"];
    evviewController.headerName = @"Movie Information";
    evviewController.eventImageURL = @"http://198.24.154.201/~viri/mobile/movies/";
    evviewController.colour =[UIColor colorWithRed:114/255.0 green:0/255.0 blue:102/255.0 alpha:1];

    [self.navigationController pushViewController:evviewController animated:YES];
}


@end
