//
//  RadioViewController.h
//  virijallu
//
//  Created by Vishal on 18/01/15.
//  Copyright (c) 2015 Vishal. All rights reserved.
//


#import <UIKit/UIKit.h>
@class AudioStreamer;

#import "DataHelper.h"

#import "AFNetworking.h"
#import "UIImageView+AFNetworking.h"
#import "MBProgressHUD.h"
#import "AppDelegate.h"

@interface RadioViewController : UIViewController <DataHelperDelegate>
{
    BOOL playing;
    
    IBOutlet UIView *templetView;
    IBOutlet UILabel *headingLabel;
    IBOutlet UILabel *radio_text;
    IBOutlet UIButton *radio_Button;
    IBOutlet UIImageView *radio_MetaData_BackGround;
    MBProgressHUD *progressHUD;
    
}
@property (strong, nonatomic)    AudioStreamer *streamer;

@property(nonatomic, weak) IBOutlet UIImageView * imagView;

- (IBAction)onPlayStopClick:(id)sender;

//- (IBAction)toggleRadio:(id)sender;
- (void)bitrateUpdated:(NSNumber *)br;
- (void)metaDataUpdated:(NSString *)metaData;


@end
