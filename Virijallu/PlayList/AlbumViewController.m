
//
//  AlbumViewController.m
//  virijallu
//
//  Created by Srinivas on 09/09/16.
//  Copyright © 2016 Vishal. All rights reserved.
//

#import "AlbumViewController.h"

@interface AlbumViewController ()

@end

@implementation AlbumViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    
}
-(void)viewWillAppear:(BOOL)animated
{
    isRadioPlaying = @"YES";

    if (self.playListNme != nil)
    {
        [self.player pause];
        [self.player removeObserver:self forKeyPath:@"status"];
        self.player = nil;
    }
    [self showActivityIndicator];
    self.title = self.playListNme;
    [self.navigationController.navigationBar setTintColor:[UIColor whiteColor]];
    
    DataHelper *dataHelper = [DataHelper sharedInstance];
    [dataHelper dataFromUrl:[NSString stringWithFormat:@"http://198.24.154.201/~viri/mobile/admincopy/wbs.php?category=%@",self.songID]];
    dataHelper.dataDelegate = self;
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.albumDataArray.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath;
{
    AlbumTableViewCell *cell = (AlbumTableViewCell*)[tableView dequeueReusableCellWithIdentifier:@"AlbumTableViewCell"];
    if (cell == nil)
    {
        NSArray *nib = [[NSBundle mainBundle]loadNibNamed:@"AlbumTableViewCell" owner:self options:nil];
        cell = [nib objectAtIndex:0];
    }
    
    cell.imageView.image = self.playlistImage;
    NSDictionary *dic = [self.albumDataArray objectAtIndex:indexPath.row];
    cell.songTitle.text = [dic objectForKey:@"file_name"];
    cell.backgroundColor = [UIColor clearColor];
    cell.playPauseButton.tag = indexPath.row;
    [cell.playPauseButton setImage:[UIImage imageNamed:@"play icon"] forState:UIControlStateNormal];
    [cell.playPauseButton addTarget:self action:@selector(playPauseBtnPressed:) forControlEvents:UIControlEventTouchUpInside];
    return cell;
    
}
-(void)playPauseBtnPressed:(id)sender
{
    [self showActivityIndicator];
    UIButton *b = sender;

    
    [b setImage:[UIImage imageNamed:@"stopone"] forState:UIControlStateNormal];

    
    NSIndexPath *myIP = [NSIndexPath indexPathForRow:b.tag inSection:0];
    AlbumTableViewCell *cell = [self.albumsTable cellForRowAtIndexPath:myIP];

    if ([isRadioPlaying isEqualToString:@"YES"])
    {
        [[NSNotificationCenter defaultCenter]postNotificationName:@"STOPPLAYER" object:nil];
        isRadioPlaying = @"NO";
    }
    
    [b setImage:[UIImage imageNamed:@"stopone"] forState:UIControlStateNormal];
    
   
    if ([playerIndex isEqualToString:[NSString stringWithFormat:@"%ld",(long)b.tag]])
    {
        NSString *playerStatus = [cell.cellStatusDic objectForKey:@"ISPLAYING"];
        if ([playerStatus isEqualToString:@"YES"])
        {
            [b setImage:[UIImage imageNamed:@"play icon"] forState:UIControlStateNormal];
            [cell.cellStatusDic setObject:@"NO" forKey:@"ISPLAYING"];
            [self pauseSong];
        }
        else
        {
            [b setImage:[UIImage imageNamed:@"stopone"] forState:UIControlStateNormal];
            [cell.cellStatusDic setObject:@"YES" forKey:@"ISPLAYING"];
            [self playSong];
        }
    }
    else
    {
        NSIndexPath *myIP = [NSIndexPath indexPathForRow:[playerIndex integerValue] inSection:0];
        AlbumTableViewCell *cell = [self.albumsTable cellForRowAtIndexPath:myIP];
        [cell.playPauseButton setImage:[UIImage imageNamed:@"play icon"] forState:UIControlStateNormal];
        [b setImage:[UIImage imageNamed:@"stopone"] forState:UIControlStateNormal];

        [self.player pause];
        [self.player removeObserver:self forKeyPath:@"status"];
        playerIndex = [NSString stringWithFormat:@"%ld",(long)b.tag];
        NSDictionary *dic = [self.albumDataArray objectAtIndex:b.tag];
        NSString *urlStr = [dic objectForKey:@"audiopath"];
        NSString *finalUrl = [urlStr stringByReplacingOccurrencesOfString:@" " withString:@"%20"];
        
        NSURL *url = [[NSURL alloc] initWithString:finalUrl];
        
        
            [self setupAVPlayerForURL:url];
    }
}

-(void) setupAVPlayerForURL: (NSURL*) url {
    
    AVAsset *asset = [AVURLAsset URLAssetWithURL:url options:nil];
     anItem = [AVPlayerItem playerItemWithAsset:asset];
    
    self.player = [AVPlayer playerWithPlayerItem:anItem];
    [self.player addObserver:self forKeyPath:@"status" options:0 context:nil];
}
- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context {
    
    if (object == self.player && [keyPath isEqualToString:@"status"]) {
        if (self.player.status == AVPlayerStatusFailed) {
            NSLog(@"AVPlayer Failed");
        } else if (self.player.status == AVPlayerStatusReadyToPlay) {
            NSLog(@"AVPlayer Ready to Play");
            [self playSong];
        } else if (self.player.status == AVPlayerItemStatusUnknown) {
            NSLog(@"AVPlayer Unknown");
        }
    }
}
-(void)playSong
{
    [self.player play];
    [self performSelector:@selector(removeActivityIndicator) withObject:nil afterDelay:0.1];
}
-(void)pauseSong
{
    [self.player pause];
    [self performSelector:@selector(removeActivityIndicator) withObject:nil afterDelay:0.1];
}

//-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
//{
////    NSDictionary *dic = [self.albumDataArray objectAtIndex:indexPath.row];
////    NSString *urlStr = [dic objectForKey:@"audiopath"];
//    [self.albumsTable deselectRowAtIndexPath:indexPath animated:YES];
//
//}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 70;
}



-(void)displayFechedContent:(NSArray*)feachedArray
{
    NSLog(@"A");
    if (feachedArray.count>0)
    {
        self.albumDataArray = [[NSMutableArray alloc]initWithArray:feachedArray];
        [self.albumsTable reloadData];
    }
    [self removeActivityIndicator];

}

-(void)viewWillDisappear:(BOOL)animated
{
    if (self.playListNme != nil)
    {
        [self.player pause];
        [self.player removeObserver:self forKeyPath:@"status"];
        self.player = nil;
        playerIndex = @" ";
        isRadioPlaying = @"YES";
    }
}

- (void)showActivityIndicator{
    if (progressHUD == nil) {
        progressHUD = [[MBProgressHUD alloc]initWithView:[[[UIApplication sharedApplication] delegate] window]];
    }
    [progressHUD removeFromSuperViewOnHide];
    progressHUD.labelText = @"Buffering...";
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
@end
