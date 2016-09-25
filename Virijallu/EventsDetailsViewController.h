//
//  EventsDetailsViewController.h
//  virijallu
//
//  Created by Vishal on 28/01/15.
//  Copyright (c) 2015 Vishal. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface EventsDetailsViewController : UIViewController


@property(nonatomic, weak) IBOutlet UILabel* eventtitle;
@property(nonatomic, weak) IBOutlet UILabel* headerTitle;
@property(nonatomic, weak) IBOutlet UILabel* dateLable;


@property(nonatomic, weak) IBOutlet UITextView* eventdescription;
@property(nonatomic, weak) IBOutlet UIImageView* eventimageView;
@property (nonatomic, strong ) NSMutableDictionary *dictionary;
@property (nonatomic, strong ) NSString *eventtitleString;
@property (nonatomic, strong ) NSString *eventdescriptionString;
@property (nonatomic, strong ) NSString *eventImageName;
@property (nonatomic, strong ) NSString *eventImageURL;
@property (nonatomic, strong ) NSString *headerName;
@property (nonatomic, strong ) NSString *dateLableString;
@property (nonatomic, strong ) UIColor *colour;




- (IBAction)popToViewController:(id)sender;
@end
