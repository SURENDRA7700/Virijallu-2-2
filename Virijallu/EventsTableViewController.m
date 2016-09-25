//
//  EventsTableViewController.m
//  Virijallu
//
//  Created by Vishal on 09/01/15.
//  Copyright (c) 2015 Vishal. All rights reserved.
//

#import "EventsTableViewController.h"
#import "EVTableViewCell.h"
#import "EventsDetailsViewController.h"
#import "AFNetworking.h"
#import "FMCellTableViewCell.h"

#import "DataHelper.h"

#import "AFNetworking.h"
#import "UIImageView+AFNetworking.h"

#import "DataHelper.h"

#import "AFNetworking.h"
#import "UIImageView+AFNetworking.h"
#import "DataHelper.h"

#import "AFNetworking.h"
#import "UIImageView+AFNetworking.h"

//http://198.24.154.201/~viri/mobile/notification/1420875516_event.jpg

@interface EventsTableViewController (){
    NSMutableArray *programmesArray;
    
}
@end

@implementation EventsTableViewController
@synthesize headViewArray;



- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}
-(void)displayFechedContent:(NSArray*)feachedArray{
    [programmesArray removeAllObjects];
    programmesArray =[feachedArray mutableCopy];
    [_tableView reloadData];
    [self removeActivityIndicator];

}

- (void)viewDidLoad
{
    [super viewDidLoad];
    //self.navigationItem.titleView = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"logo.PNG"]];
    programmesArray = [[NSMutableArray alloc]init];
   
    UILabel *heading =  [[UILabel alloc] init];
    [heading setText: @"Events"];
    heading.font=[UIFont fontWithName:@"HelveticaNeue-CondensedBold" size:19];
    [heading setTextColor:[UIColor whiteColor]];
    [heading setTextAlignment:NSTextAlignmentCenter];
    heading.frame = CGRectMake(0, 0, 180, 25);
    self.navigationItem.titleView =heading;
    
    [self.navigationController.navigationBar setBarTintColor:[UIColor colorWithRed:25/255.0 green:108/255.0 blue:4/255.0 alpha:1]];
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self showActivityIndicator];
    self.view.backgroundColor = [UIColor whiteColor];
}


- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:YES];
    dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0ul);
    dispatch_async(queue, ^{
        DataHelper *dataHelper = [DataHelper sharedInstance];
        [dataHelper dataFromUrl:@"http://198.24.154.201/~viri/mobile/webcopy/getwbs_events.php"];
        dataHelper.dataDelegate = self;
    });
}




- (void)viewDidUnload
{
    [super viewDidUnload];
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


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    //HeadView* headView = [self.headViewArray objectAtIndex:section];
   // return headView.open?2:0;
    
//    CGFloat navHeight = self.navigationController.navigationBarHidden ? 0 :
//    self.navigationController.navigationBar.frame.size.height;
//    float h = 83 * [programmesArray count];
//    int tableHeight = [[UIScreen mainScreen] bounds].size.height - navHeight+20;
//
//    if(h > [[UIScreen mainScreen] bounds].size.height - navHeight+20 )
//    {
//        _tableView.frame = CGRectMake(0, navHeight+20, self.view.frame.size.width, tableHeight);
//    }
//    else
//    {
//        _tableView.frame = CGRectMake(0, navHeight+20, self.view.frame.size.width, h);
//    }
    
    return [programmesArray count];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 83;
}

- (UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *indentifier = @"cell";
    FMCellTableViewCell *cell = (FMCellTableViewCell*)[tableView dequeueReusableCellWithIdentifier:indentifier forIndexPath:indexPath];
    
    UIButton* backBtn = (UIButton*)[cell.contentView viewWithTag:20000];
    [backBtn setBackgroundImage:[UIImage imageNamed:@"btn_2_nomal"] forState:UIControlStateNormal];
    cell.firstText.text = [[programmesArray objectAtIndex:indexPath.row] objectForKey:@"title"];
     cell.secondText.text =[[programmesArray objectAtIndex:indexPath.row] objectForKey:@"event_date"];

    NSString *urlString = [NSString stringWithFormat:@"http://198.24.154.201/~viri/mobile/notification/%@",[[programmesArray objectAtIndex:indexPath.row] objectForKey:@"image"]];
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL: [NSURL URLWithString:urlString]];
    
    [cell.imgView setImageWithURLRequest:request placeholderImage:nil success:^(NSURLRequest *request, NSHTTPURLResponse *response, UIImage *image) {
        [cell.imgView setImage:image];
    } failure:^(NSURLRequest *request, NSHTTPURLResponse *response, NSError *error) {
    }];
    return cell;
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main_iPhone" bundle:nil];
    EventsDetailsViewController *evviewController = [storyboard instantiateViewControllerWithIdentifier:@"EventsDetailsViewController"];
    evviewController.eventtitleString =[[programmesArray objectAtIndex:indexPath.row] objectForKey:@"title"];
    evviewController.eventdescriptionString =[[programmesArray objectAtIndex:indexPath.row] objectForKey:@"desc"];
    evviewController.eventImageName =[[programmesArray objectAtIndex:indexPath.row] objectForKey:@"image"];
    evviewController.headerName = @"Events";
    evviewController.dateLableString =[[programmesArray objectAtIndex:indexPath.row] objectForKey:@"event_date"];
    evviewController.colour =[UIColor colorWithRed:25/255.0 green:108/255.0 blue:4/255.0 alpha:1];
    evviewController.eventImageURL = @"http://198.24.154.201/~viri/mobile/notification/";

    evviewController.dictionary = [programmesArray objectAtIndex:indexPath.row];
    [self.navigationController pushViewController:evviewController animated:YES];
    
    _currentRow = indexPath.row;
}





@end
