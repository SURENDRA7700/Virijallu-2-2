//
//  FMCellTableViewCell.h
//  virijallu
//
//  Created by Vishal on 20/02/15.
//  Copyright (c) 2015 Vishal. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface FMCellTableViewCell : UITableViewCell
@property (nonatomic , weak) IBOutlet UIImageView *imgView;

@property (nonatomic , weak) IBOutlet UILabel *firstText;

@property (nonatomic , weak) IBOutlet UILabel *secondText;
@property (weak, nonatomic) IBOutlet UILabel *subtitleLbl;

@end
