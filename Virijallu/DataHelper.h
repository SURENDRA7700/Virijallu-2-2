//
//  DataHelper.h
//  Virijallu
//
//  Created by Vishal on 07/01/15.
//  Copyright (c) 2015 Vishal. All rights reserved.
//

#import <Foundation/Foundation.h>
@protocol DataHelperDelegate;

@interface DataHelper : NSObject
{
}
@property(nonatomic, retain) id <DataHelperDelegate> dataDelegate;

- (void) dataFromUrl:(NSString*)url;
+ (id)sharedInstance;

- (void) audioUrl:(NSString*)url;


@end

@protocol DataHelperDelegate <NSObject>

@optional

- (void)pollingFetehData:(NSMutableDictionary*)data;
-(void)displayFechedContent:(NSArray*)feachedArray;
                             
@end