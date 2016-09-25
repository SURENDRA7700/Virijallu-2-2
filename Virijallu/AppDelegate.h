//
//  AppDelegate.h
//  Virijallu
//
//  Created by Vishal on 07/01/15.
//  Copyright (c) 2015 Vishal. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DataHelper.h"
@class AudioStreamer;

@interface AppDelegate : UIResponder <UIApplicationDelegate , DataHelperDelegate>

@property (strong, nonatomic) UIWindow *window;

@property (strong, nonatomic) AudioStreamer *streamer;

-(BOOL)connected;


@end
