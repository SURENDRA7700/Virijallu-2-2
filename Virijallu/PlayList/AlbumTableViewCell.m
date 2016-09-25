//
//  AlbumTableViewCell.m
//  virijallu
//
//  Created by Srinivas on 09/09/16.
//  Copyright © 2016 Vishal. All rights reserved.
//

#import "AlbumTableViewCell.h"

@implementation AlbumTableViewCell
@synthesize imageView;
- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    

    
//    [self.songTitle setBackgroundColor:[UIColor whiteColor]];
//    [self.artistName setBackgroundColor:[UIColor whiteColor]];
//    [self.song setBackgroundColor:[UIColor whiteColor]];
//    
    
    
    self.songTitle.font = [UIFont fontWithName:@"HelveticaNeue-CondensedBold" size:19];
//    self.artistName.font= [UIFont fontWithName:@"HelveticaNeue-CondensedBold" size:19];
//    self.song.font = [UIFont fontWithName:@"HelveticaNeue-CondensedBold" size:19];

    
    
    self.cellStatusDic = [[NSMutableDictionary alloc]init];
    [self.cellStatusDic setObject:@"YES" forKey:@"ISPLAYING"];

}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
