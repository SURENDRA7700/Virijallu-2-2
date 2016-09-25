//
//  ProgramsViewController.m
//  Virijallu
//
//  Created by Vishal on 07/01/15.
//  Copyright (c) 2015 Vishal. All rights reserved.
//

#import "ProgramsViewController.h"
#import "DataHelper.h"
#import "RVTableViewCell.h"
#import "DataHelper.h"

#import "AFNetworking.h"
#import "UIImageView+AFNetworking.h"


@interface ProgramsViewController (){
    NSMutableArray *programmesArray;
    
}
@end

@implementation ProgramsViewController
@synthesize tableView = _tableView;
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
    [self loadModel];
    
    [_tableView reloadData];
    
    [self removeActivityIndicator];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    programmesArray = [[NSMutableArray alloc]init];
    //self.navigationItem.titleView = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"logo.PNG"]];
    [self showActivityIndicator];

    UILabel *heading =  [[UILabel alloc] init];
    [heading setText: @"Programs"];
    heading.font=[UIFont fontWithName:@"HelveticaNeue-CondensedBold" size:19];
    [heading setTextColor:[UIColor whiteColor]];
    [heading setTextAlignment:NSTextAlignmentCenter];
    heading.frame = CGRectMake(0, 0, 180, 25);
    self.navigationItem.titleView =heading;
    
    self.view.backgroundColor = [UIColor whiteColor];
    [self.navigationController.navigationBar setBarTintColor:[UIColor colorWithRed:15/255.0 green:18/255.0 blue:187/255.0 alpha:1]];
    
    //    [UIColor colorWithRed:188/255.0 green:96/255.0 blue:10/255.0 alpha:1]

    
//    UIImageView *tempImageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"livebackground"]];
//    [tempImageView setFrame:self.tableView.frame];
//    _tableView.backgroundView = tempImageView;
//
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:YES];
    DataHelper *dataHelper = [DataHelper sharedInstance];
    [dataHelper dataFromUrl:@"http://198.24.154.201/~viri/mobile/webcopy/getwbs_programs.php"];
    dataHelper.dataDelegate = self;

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

- (void)loadModel{
    _currentRow = -1;
    self.headViewArray = [[NSMutableArray alloc]init ];
    for(int i = 0;i< [programmesArray count];i++){
        HeadView* headview = [[HeadView alloc] init];
        headview.delegate = self;
        headview.section = i;
        NSString *name = [[programmesArray objectAtIndex:i] objectForKey:@"days"];
        [headview.backBtn setTitle:name forState:UIControlStateNormal];
        [headview.backBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [self.headViewArray addObject:headview];
    }
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    _tableView= nil;
    
    
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
    HeadView* headView = [self.headViewArray objectAtIndex:section];
    return headView.open?1:0;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return [self.headViewArray count];
}



- (UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *indentifier = @"cell";
   
    RVTableViewCell *cell = (RVTableViewCell *)[tableView dequeueReusableCellWithIdentifier:indentifier forIndexPath:indexPath];
    HeadView* view = [self.headViewArray objectAtIndex:indexPath.section];
    
    NSString *urlString = [NSString stringWithFormat:@"http://198.24.154.201/~viri/mobile/programs/%@",[[programmesArray objectAtIndex:indexPath.section] objectForKey:@"image"]];
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL: [NSURL URLWithString:urlString]];
    [cell.prgImageView setImageWithURLRequest:request placeholderImage:nil success:^(NSURLRequest *request, NSHTTPURLResponse *response, UIImage *image) {
        [cell.prgImageView setImage:image];
        // NSLog(@"setImageWithURLRequest");
    } failure:^(NSURLRequest *request, NSHTTPURLResponse *response, NSError *error) {
        // NSLog(@"Error %@",request);
    }];
    
    if (view.open) {
        if (indexPath.row == _currentRow) {
           // backBtn.backgroundColor = [UIColor orangeColor];
        }
    }
    return cell;
}


//- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
//    [_tableView reloadData];
// 
//}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    _currentRow = indexPath.row;
    
    [tableView reloadData];
}
-(void) scrollToTop:(NSIndexPath*)indexPath
{
    if ([self numberOfSectionsInTableView:_tableView] > 0 && indexPath.section > 1)
    {
        NSIndexPath* top = [NSIndexPath indexPathForRow:indexPath.row inSection:indexPath.section - 1];
        [_tableView scrollToRowAtIndexPath:top atScrollPosition:UITableViewScrollPositionMiddle animated:YES];
    }
}
#pragma mark - HeadViewdelegate
-(void)selectedWith:(HeadView *)view{
    _currentRow = -1;
    if (view.open) {
        for(int i = 0;i<[headViewArray count];i++)
        {
            HeadView *head = [headViewArray objectAtIndex:i];
            head.open = NO;
        }
        
        [_tableView reloadData];
        return;
    }
    _currentSection = view.section;
    [self reset];
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
    [_tableView setContentOffset:CGPointZero animated:YES];

    [_tableView reloadData];
}




@end
