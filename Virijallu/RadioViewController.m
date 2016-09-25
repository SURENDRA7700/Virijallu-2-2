//
//  RadioViewController.m
//  virijallu
//
//  Created by Vishal on 18/01/15.
//  Copyright (c) 2015 Vishal. All rights reserved.
//

#import "RadioViewController.h"
#import "AFNetworking.h"
#import "UIImageView+AFNetworking.h"
#import "DataHelper.h"
#import "AudioStreamer.h"
#import "AppDelegate.h"

#define AppDelegate (AppDelegate *)[[UIApplication sharedApplication] delegate]


#define STREAM_URL @"http:\/\/198.24.154.201:8000\/viri\/index.html"
//#define STREAM_URL @"http://38.101.195.5:9196"


@interface RadioViewController ()
{
    NSTimer *timer,*pollingUrltimer;
    UIImageView *img_flw;
    CGPoint position;
    NSMutableArray *contentArray;

    UIDynamicAnimator* _animator;
    UIGravityBehavior* _gravity;
    int XValue;
    bool isForceStop;


}
@end

@implementation RadioViewController
@synthesize streamer;
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    

    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(stopSong) name:@"STOPPLAYER" object:nil];
    isForceStop  = NO;
    self.navigationItem.titleView = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"logo.PNG"]];
    UIImage *image = [UIImage imageNamed:@"play.png"];
    [self setButtonImage:image];
    [self performSelector:@selector(showActivityIndicator) withObject:nil afterDelay:0.2];
}
-(void)stopPlayer
{
    [streamer stop];
}
-(void)viewWillDisappear:(BOOL)animated{
    [self Stop];
}
- (void)viewDidAppear:(BOOL)animated
{
    DataHelper *dataHelper = [DataHelper sharedInstance];
    dataHelper.dataDelegate = self;

    [dataHelper dataFromUrl:@"http://198.24.154.201/~viri/mobile/webservices/getwbs_ads.php"];
    
    [dataHelper audioUrl:@"http://198.24.154.201/~viri/mobile/webcopy/getwbs_live.php"];
    [self pollingUrl];
    XValue = 0;
    

   if ([contentArray count] > 0) {
       [self Start];
   }
}


-(void)displayFechedContent:(NSArray*)feachedArray{
    [contentArray removeAllObjects];
    contentArray =[feachedArray mutableCopy];
    if ([contentArray count] > 0) {
        NSString *urlString = [NSString stringWithFormat:@"http://198.24.154.201/~viri/mobile/ads/%@",[[contentArray objectAtIndex:0] objectForKey:@"image_name"]];
        NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL: [NSURL URLWithString:urlString]];
        [_imagView setImageWithURLRequest:request placeholderImage:nil success:^(NSURLRequest *request, NSHTTPURLResponse *response, UIImage *image) {
            [_imagView setImage:image];
        
        } failure:^(NSURLRequest *request, NSHTTPURLResponse *response, NSError *error) {
           
            // NSLog(@"Error %@",request);
        }];
        [self Start];
    }
}
-(IBAction)Start {
    timer = [NSTimer scheduledTimerWithTimeInterval:(25)
                                             target: self
                                           selector:@selector(onTimer)
                                           userInfo: nil repeats: YES];
}

-(IBAction)Stop {
    if (timer != nil)
    {
        [timer invalidate];
        timer = nil;
    }
}



-(void)onTimer {
    if (XValue == [contentArray count]) {
        XValue = 0;
    }
    int x =  XValue;
    NSString *urlString = [NSString stringWithFormat:@"http://198.24.154.201/~viri/mobile/ads/%@",[[contentArray objectAtIndex:x] objectForKey:@"image_name"]];
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL: [NSURL URLWithString:urlString]];
    [_imagView setImageWithURLRequest:request placeholderImage:nil success:^(NSURLRequest *request, NSHTTPURLResponse *response, UIImage *image) {
        [_imagView setImage:image];
        XValue++;

    } failure:^(NSURLRequest *request, NSHTTPURLResponse *response, NSError *error) {
        XValue++;

        // NSLog(@"Error %@",request);
    }];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}


#pragma mark -
#pragma mark AudioStream Callback Functions
- (void)bitrateUpdated:(NSNumber *)br
{
    //bitrate.text = [br stringValue];
}

- (void)statusChanged:(id)metaData{
    
}
- (void)metaDataUpdated:(NSString *)metaData
{
    NSString *radio_text_str;
    NSArray *chunks = [metaData componentsSeparatedByString:@";"];
    if ([chunks count]) {
        NSArray *streamTitle = [[chunks objectAtIndex:0] componentsSeparatedByString:@"="];
        if ([streamTitle count] > 1) {
            radio_text_str = [streamTitle objectAtIndex:1];
            if (radio_text_str.length <= 0) {
                radio_text.text = @"Title not updated";
            }else{
                radio_text.text = radio_text_str;
            }
        }
    }
}

- (void)streamError
{
     NSLog(@"Stream Error.");
    
    if (streamer) {
        [streamer stop];
        streamer = nil;
        //[self onPlayStopClick:nil];
        [self playStopAudio];

    }
}

- (void)setButtonImage:(UIImage *)image
{
    [radio_Button.layer removeAllAnimations];
    [radio_Button
     setImage:image
     forState:0];
}



- (void)spinButton
{
    [CATransaction begin];
    [CATransaction setValue:(id)kCFBooleanTrue forKey:kCATransactionDisableActions];
    //CGRect frame = [radio_Button frame];
    radio_Button.layer.anchorPoint = CGPointMake(0.5, 0.5);
    //button.layer.position = CGPointMake(frame.origin.x + 0.5 * frame.size.width, frame.origin.y + 0.5 * frame.size.height);
    [CATransaction commit];
    
    [CATransaction begin];
    [CATransaction setValue:(id)kCFBooleanFalse forKey:kCATransactionDisableActions];
    [CATransaction setValue:[NSNumber numberWithFloat:2.0] forKey:kCATransactionAnimationDuration];
    
    CABasicAnimation *animation;
    animation = [CABasicAnimation animationWithKeyPath:@"transform.rotation.z"];
    animation.fromValue = [NSNumber numberWithFloat:0.0];
    animation.toValue = [NSNumber numberWithFloat:2 * M_PI];
    animation.timingFunction = [CAMediaTimingFunction functionWithName: kCAMediaTimingFunctionLinear];
    animation.delegate = self;
    [radio_Button.layer addAnimation:animation forKey:@"rotationAnimation"];
    
    [CATransaction commit];
}

- (void)animationDidStop:(CAAnimation *)theAnimation finished:(BOOL)finished
{
    if (finished)
    {
        [self spinButton];
    }
}

- (IBAction)onPlayStopClick:(id)sender
{
    if (!streamer && [AppDelegate connected] == YES) {
        isForceStop = NO;

        NSString *url_str =[[NSUserDefaults standardUserDefaults] objectForKey:@"PlayingUrl"];
        
        NSString *escapedValue =
        (NSString *)CFBridgingRelease(CFURLCreateStringByAddingPercentEscapes(
                                                                              nil,
                                                                              (CFStringRef)url_str
                                                                              ,
                                                                              NULL,
                                                                              NULL,
                                                                              kCFStringEncodingUTF8))
        ;
        NSURL *url = [NSURL URLWithString:escapedValue];
        streamer = [[AudioStreamer alloc] initWithURL:url];
        [streamer
         addObserver:self
         forKeyPath:@"isPlaying"
         options:0
         context:nil];
        [streamer setDelegate:self];
        [streamer setDidUpdateMetaDataSelector:@selector(metaDataUpdated:)];
        [streamer setDidErrorSelector:@selector(streamError)];
        [streamer setDidDetectBitrateSelector:@selector(bitrateUpdated:)];
        
        [streamer start];
        
        [self setButtonImage:[UIImage imageNamed:@"stop.png"]];
        

    }else{
        [radio_Button.layer removeAllAnimations];
        [streamer stop];
        isForceStop = YES;
    }
}
-(void)stopSong
{
    [radio_Button.layer removeAllAnimations];
    [streamer stop];
    isForceStop = YES;
}

- (void)playStopAudio{
    [self performSelector:@selector(removeActivityIndicator) withObject:nil afterDelay:4.0];

    if (!streamer && !isForceStop && [AppDelegate connected] == YES)
    {
        NSString *url_str =[[NSUserDefaults standardUserDefaults] objectForKey:@"PlayingUrl"];
        
        NSString *escapedValue =
        (NSString *)CFBridgingRelease(CFURLCreateStringByAddingPercentEscapes(
                                                                              nil,
                                                                              (CFStringRef)url_str
                                                                              ,
                                                                              NULL,
                                                                              NULL,
                                                                              kCFStringEncodingUTF8))
        ;
        NSURL *url = [NSURL URLWithString:escapedValue];
        streamer = [[AudioStreamer alloc] initWithURL:url];
        [streamer
         addObserver:self
         forKeyPath:@"isPlaying"
         options:0
         context:nil];
        [streamer setDelegate:self];
        [streamer setDidUpdateMetaDataSelector:@selector(metaDataUpdated:)];
        [streamer setDidErrorSelector:@selector(streamError)];
        [streamer setDidDetectBitrateSelector:@selector(bitrateUpdated:)];
        
        [streamer start];
        
        [self setButtonImage:[UIImage imageNamed:@"stop.png"]];
        
        //  [self spinButton];
    }
    else
    {
        [radio_Button.layer removeAllAnimations];
        [streamer stop];
    }

}


- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object
                        change:(NSDictionary *)change context:(void *)context
{
    if ([keyPath isEqual:@"isPlaying"])
    {
        
        if ([(AudioStreamer *)object isPlaying])
        {
            [self
             performSelector:@selector(setButtonImage:)
             onThread:[NSThread mainThread]
             withObject:[UIImage imageNamed:@"stop.png"]
             waitUntilDone:NO];
        }
        else
        {
            [streamer removeObserver:self forKeyPath:@"isPlaying"];
            streamer = nil;
            
            [self
             performSelector:@selector(setButtonImage:)
             onThread:[NSThread mainThread]
             withObject:[UIImage imageNamed:@"play.png"]
             waitUntilDone:NO];
        }
        
        return;
    }
    
    [super observeValueForKeyPath:keyPath ofObject:object change:change
                          context:context];
}



- (void)pollingUrl
{
    pollingUrltimer = [NSTimer scheduledTimerWithTimeInterval:(5)
                                             target: self
                                           selector:@selector(pollingUrlonTimer)
                                           userInfo: nil repeats: YES];
}

-(void)pollingUrlStop
{
 if (timer != nil){
     [timer invalidate];
     timer = nil;
 }
}

-(void)pollingUrlonTimer {
    
    DataHelper *dataHelper = [DataHelper sharedInstance];
    dataHelper.dataDelegate = self;
    [dataHelper audioUrl:@"http://198.24.154.201/~viri/mobile/webservices/getwbs_live.php"];
    
}
- (void)pollingFetehData:(NSMutableArray*)data{
    
   NSMutableDictionary * dict = [data lastObject];
    if ([[NSUserDefaults standardUserDefaults]objectForKey:@"PlayingUrl"] ==  nil) {
        [[NSUserDefaults standardUserDefaults]setObject:[dict objectForKey:@"link"] forKey:@"PlayingUrl"];
        
       // [self onPlayStopClick:nil];
        [self playStopAudio];
    }
    if (![[dict objectForKey:@"link"] isEqualToString: [[NSUserDefaults standardUserDefaults] objectForKey:@"PlayingUrl"]]) {
        [[NSUserDefaults standardUserDefaults]setObject:[dict objectForKey:@"link"] forKey:@"PlayingUrl"];
        if (streamer.isPlaying) {
        [streamer stop];
        }
       // [self onPlayStopClick:nil];
        [self playStopAudio];

    }
    if (!streamer) {
        [streamer stop];
        streamer = nil;
   //     [NSTimer scheduledTimerWithTimeInterval:(5) target:nil selector:@selector(onPlayStopClick) userInfo:nil repeats:YES];
        [self playStopAudio];

       // [self onPlayStopClick:nil];
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
