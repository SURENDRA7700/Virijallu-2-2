//
//  HeadView.m
//  Test04
//
//  Created by HuHongbing on 9/26/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "HeadView.h"

@implementation HeadView
@synthesize delegate = _delegate;
@synthesize section,open,backBtn;

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        open = NO;
        
        CGRect screenBound = [[UIScreen mainScreen] bounds];
        CGSize screenSize = screenBound.size;
        CGFloat screenWidth = screenSize.width;
       
        UIButton* btn = [UIButton buttonWithType:UIButtonTypeCustom];
        btn.frame = CGRectMake(5, 4, screenWidth - 10, 45.5);
        btn.backgroundColor = [UIColor whiteColor];
        btn.alpha = 0.8;
        [btn addTarget:self action:@selector(doSelected) forControlEvents:UIControlEventTouchUpInside];
        btn.titleEdgeInsets = UIEdgeInsetsMake(0, 20, 0, 0);
        [btn.titleLabel setFont:[UIFont fontWithName:@"HelveticaNeue-CondensedBold" size:19]];
        btn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
        [self addSubview:btn];
        self.backBtn = btn;
    }
    return self;
}

-(void)doSelected{
    //    [self setImage];
    if (_delegate && [_delegate respondsToSelector:@selector(selectedWith:)]){
     	[_delegate selectedWith:self];
    }
}
@end
