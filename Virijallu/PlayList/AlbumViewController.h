//
//  AlbumViewController.h
//  virijallu
//
//  Created by Srinivas on 09/09/16.
//  Copyright © 2016 Vishal. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AlbumTableViewCell.h"
#import "DataHelper.h"
#import <AVFoundation/AVFoundation.h>
#import <CoreMedia/CoreMedia.h>
#import <AudioToolbox/AudioToolbox.h>
@class AudioStreamer;
#import "AppDelegate.h"
#import "MBProgressHUD.h"
#import "AudioStreamer.h"

@interface AlbumViewController : UIViewController<UITableViewDelegate,UITableViewDataSource,DataHelperDelegate>
{
    NSMutableDictionary *playerStatusDic;
    NSString *playerIndex;
    NSString *isRadioPlaying;
    AVPlayerItem *anItem;
    MBProgressHUD *progressHUD;
}
@property (strong, nonatomic) NSString *playListNme;
@property (weak, nonatomic) IBOutlet UITableView *albumsTable;
@property (strong, nonatomic) NSMutableArray *albumDataArray;
@property (strong, nonatomic) NSString *songID;
@property (strong, nonatomic) UIImage *playlistImage;
@property (strong, nonatomic) AVPlayer *player;
@property (strong, nonatomic) NSTimer *playbackTimer;

@end
