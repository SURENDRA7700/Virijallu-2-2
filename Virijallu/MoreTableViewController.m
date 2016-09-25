//
//  MoreTableViewController.m
//  virijallu
//
//  Created by Vishal on 20/02/15.
//  Copyright (c) 2015 Vishal. All rights reserved.
//

#import "MoreTableViewController.h"
#import "HostTableViewController.h"
#import "EventsTableViewController.h"
#import "AboutUsViewController.h"
#import "SponsorsTableViewController.h"
#import "DataHelper.h"
#import "RVTableViewCell.h"
#import "ProgramsViewController.h"

@interface MoreTableViewController ()
{
    NSMutableArray *storyBrdIds;
    NSMutableArray *programmesArray;

}
@end

@implementation MoreTableViewController
@synthesize headViewArray;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad {
        [super viewDidLoad];
    UILabel *heading =  [[UILabel alloc] init];
    [heading setText: @"More"];
    heading.font=[UIFont fontWithName:@"HelveticaNeue-CondensedBold" size:19];
    [heading setTextColor:[UIColor whiteColor]];
    [heading setTextAlignment:NSTextAlignmentCenter];
    heading.frame = CGRectMake(0, 0, 180, 25);
    self.navigationItem.titleView =heading;
    
    UIImageView *backgroundImagevIew = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"movies_background"]];
    [self.tableView setBackgroundView:backgroundImagevIew];
    
    
//        self.navigationItem.titleView = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"logo.PNG"]];
        storyBrdIds = [[NSArray arrayWithObjects:@"Offers and Discounts", @"About Us", @"Website",@"Find us on Facebook",@"Find us on Twitter",@"Find us on Youtube",@"Programs", nil] mutableCopy];
        programmesArray = storyBrdIds;
    [self loadModel];

//        UIImageView *tempImageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"livebackground"]];
//        [tempImageView setFrame:self.tableView.frame];
//        self.tableView.backgroundView = tempImageView;
//
}
-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:YES];
    
    [self.navigationController.navigationBar setBarTintColor:[UIColor colorWithRed:4/255.0 green:39/255.0 blue:104/255.0 alpha:1]];

}


- (void)didReceiveMemoryWarning {
        [super didReceiveMemoryWarning];
        // Dispose of any resources that can be recreated.
}

- (void)loadModel{
    _currentRow = -1;
    self.headViewArray = [[NSMutableArray alloc]init ];
    for(int i = 0;i< [programmesArray count];i++){
        HeadView* headview = [[HeadView alloc] init];
        headview.delegate = self;
        headview.section = i;
        NSString *name = [programmesArray objectAtIndex:i];
        [headview.backBtn setTitle:name forState:UIControlStateNormal];
        [headview.backBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [self.headViewArray addObject:headview];
    }
}

- (void)viewDidUnload
{
    [super viewDidUnload];
}

#pragma mark - TableViewdelegate&&TableViewdataSource
//- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
//    HeadView* headView = [self.headViewArray objectAtIndex:indexPath.section];
//
//    return headView.open?45:0;
//}

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section{
    return nil;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 44;
}
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 4.0;
}


- (UIView*)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    return [self.headViewArray objectAtIndex:section];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
 //   HeadView* headView = [self.headViewArray objectAtIndex:section];
    return 0;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return [self.headViewArray count];
}



- (UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *indentifier = @"cell";
    
    RVTableViewCell *cell = (RVTableViewCell *)[tableView dequeueReusableCellWithIdentifier:indentifier forIndexPath:indexPath];
   // HeadView* view = [self.headViewArray objectAtIndex:indexPath.section];
   
    return cell;
}



- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    _currentRow = indexPath.row;
    [tableView reloadData];
}

#pragma mark - HeadViewdelegate
-(void)selectedWith:(HeadView *)view{
    _currentRow = -1;
//    if (view.open) {
//        for(int i = 0;i<[headViewArray count];i++)
//        {
//            HeadView *head = [headViewArray objectAtIndex:i];
//            head.open = NO;
//        }
    
        //[self.tableView reloadData];
     //   return;
    //}
    _currentSection = view.section;
    
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main_iPhone" bundle:nil];
      if (_currentSection == 0)
      {
          SponsorsTableViewController *evviewController = [storyboard instantiateViewControllerWithIdentifier:@"SponsorsTableViewController"];
          [self.navigationController pushViewController:evviewController animated:YES];
   
      }    else if (_currentSection == 1){
          AboutUsViewController *evviewController = [storyboard instantiateViewControllerWithIdentifier:@"AboutUsViewController"];
          [self.navigationController pushViewController:evviewController animated:YES];
   
      }
      else if (_currentSection == 2){
         // WebSiteViewController *evviewController = [storyboard instantiateViewControllerWithIdentifier:@"WebSiteViewController"];
          //[self.navigationController pushViewController:evviewController animated:YES];
          
              [[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"http://www.virijallu.com"]];
   
      }
      else if (_currentSection == 3){
                 [[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"https://www.facebook.com/groups/virijallu/"]];
      }
      else if (_currentSection == 4){
          [[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"https://www.twitter.com/virijallu"]];
      }
      else if (_currentSection == 5){
          [[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"https://www.youtube.com/user/virijallu"]];
      }
    
      else if (_currentSection == 6){
          ProgramsViewController *objPrograms = [storyboard instantiateViewControllerWithIdentifier:@"ProgramsViewController"];
          [self.navigationController pushViewController:objPrograms animated:YES];
      }
    //
    
   //[self reset];
}

- (void)reset
{
    for(int i = 0;i<[headViewArray count];i++)
    {
        HeadView *head = [headViewArray objectAtIndex:i];
        
        if(head.section == _currentSection)
        {
            head.open = YES;
            [head.backBtn setBackgroundImage:[UIImage imageNamed:@"btn_nomal"] forState:UIControlStateNormal];
            
        }else {
            [head.backBtn setBackgroundImage:[UIImage imageNamed:@"btn_momal"] forState:UIControlStateNormal];
            
            head.open = NO;
        }
        
    }
//    [self.tableView setContentOffset:CGPointZero animated:YES];
//    
//    [self.tableView reloadData];
}




@end


