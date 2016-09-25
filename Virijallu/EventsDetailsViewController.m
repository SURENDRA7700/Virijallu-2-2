//
//  EventsDetailsViewController.m
//  virijallu
//
//  Created by Vishal on 28/01/15.
//  Copyright (c) 2015 Vishal. All rights reserved.
//

#import "EventsDetailsViewController.h"
#import "DataHelper.h"

#import "AFNetworking.h"
#import "UIImageView+AFNetworking.h"

@interface EventsDetailsViewController ()

- (void)popToViewController:(id)sender;

@end



@implementation EventsDetailsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
   /// self.navigationItem.titleView = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"logo.PNG"]];
    
    UILabel *heading =  [[UILabel alloc] init];
    [heading setText: _eventtitleString];
    [heading setTextColor:[UIColor whiteColor]];
    heading.font=[UIFont fontWithName:@"HelveticaNeue-CondensedBold" size:19];
    [heading setTextAlignment:NSTextAlignmentCenter];
    heading.frame = CGRectMake(0, 0, 180, 25);
    self.navigationItem.titleView =heading;
    
    [self.navigationController.navigationBar setBarTintColor:_colour];
    
    UIImage *img = [UIImage imageNamed:@"leftarrow1"];
    UIButton *backButton = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 48,48)];
    [backButton setBackgroundImage:img forState:UIControlStateNormal];
    UIBarButtonItem *barBackButtonItem = [[UIBarButtonItem alloc] initWithCustomView:backButton];
    [backButton addTarget:self action:@selector(popToViewController) forControlEvents:UIControlEventTouchUpInside];
    self.navigationItem.leftBarButtonItem = barBackButtonItem;
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewWillAppear:(BOOL)animated{
    _eventtitle.text = _eventtitleString;
    _eventdescription.text = _eventdescriptionString;
    _headerTitle.text= _headerName;
    if (![_dateLableString isKindOfClass:[NSNull class]]) {
        _dateLable.text =_dateLableString;
    }
    
    if( ![_eventImageName isKindOfClass:[NSNull class]])
    {
        NSString *urlString = [NSString stringWithFormat:@"%@/%@",_eventImageURL,_eventImageName];
        NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL: [NSURL URLWithString:urlString]];
        [_eventimageView setImageWithURLRequest:request placeholderImage:nil success:^(NSURLRequest *request, NSHTTPURLResponse *response, UIImage *image) {
            [_eventimageView setImage:image];
        } failure:^(NSURLRequest *request, NSHTTPURLResponse *response, NSError *error) {
            
        }];
    }
}



- (void)popToViewController
{
    [self.navigationController popViewControllerAnimated:YES];
}

@end
