//
//  DataHelper.m
//  Virijallu
//
//  Created by Vishal on 07/01/15.
//  Copyright (c) 2015 Vishal. All rights reserved.
//


#import "DataHelper.h"
#import "AFNetworking.h"
#import "AppDelegate.h"
#define AppDelegate (AppDelegate *)[[UIApplication sharedApplication] delegate]

@implementation DataHelper


+ (id)sharedInstance {
    static DataHelper *sharedInstance = nil;
   // static dispatch_once_t onceToken;
   // dispatch_once(&onceToken, ^{
        sharedInstance = [[self alloc] init];
   // });
    return sharedInstance;
}

- (void)dataFromUrl:(NSString*)url
{
    if ([AppDelegate connected]) {

        
        dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0ul);
        dispatch_async(queue, ^{
            NSURLRequest * urlRequest = [NSURLRequest requestWithURL:[NSURL URLWithString:url]];
            NSURLResponse * response = nil;
            NSError * error = nil;
            NSData * responseData = [NSURLConnection sendSynchronousRequest:urlRequest
                                                          returningResponse:&response
                                                                      error:&error];
            NSDictionary* json;
            if (error == nil)
            {
                json = [NSJSONSerialization JSONObjectWithData:responseData
                                                       options:kNilOptions
                                                         error:&error];
            }
            dispatch_sync(dispatch_get_main_queue(), ^(void) {
                if([self.dataDelegate conformsToProtocol:@protocol(DataHelperDelegate)]){
                    NSArray *allKeys = [json allKeys];
                    if ([allKeys containsObject:@"playlist"])
                    {
                        [[self dataDelegate]displayFechedContent:[json objectForKey:@"playlist"]];

                    }
                    else if ([allKeys containsObject:@"DirctorPlayList"])
                    {
                        [[self dataDelegate]displayFechedContent:[json objectForKey:@"DirctorPlayList"]];
                        
                    }
                    else
                    {
                        [[self dataDelegate]displayFechedContent:[json objectForKey:@"result"]];
                    }
                    
                }
            });
        });
    }
}

- (void)audioUrl:(NSString*)url
{
    if ([AppDelegate connected]) {
        dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0ul);
        dispatch_async(queue, ^{
            NSURLRequest * urlRequest = [NSURLRequest requestWithURL:[NSURL URLWithString:url]];
            NSURLResponse * response = nil;
            NSError * error = nil;
            NSData * responseData = [NSURLConnection sendSynchronousRequest:urlRequest
                                                          returningResponse:&response
                                                                      error:&error];
            NSDictionary* json;
            if (error == nil)
            {
                json = [NSJSONSerialization JSONObjectWithData:responseData
                                                       options:kNilOptions
                                                         error:&error];
            }
            dispatch_sync(dispatch_get_main_queue(), ^(void) {
                if([self.dataDelegate conformsToProtocol:@protocol(DataHelperDelegate)]){
                    [[self dataDelegate] pollingFetehData:[json mutableCopy]];
                }
            });
        });
    }
}



    

@end
