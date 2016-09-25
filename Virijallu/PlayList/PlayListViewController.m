//
//  PlayListViewController.m
//  virijallu
//
//  Created by Srinivas on 09/09/16.
//  Copyright © 2016 Vishal. All rights reserved.
//

#import "PlayListViewController.h"

@interface PlayListViewController ()

@end

@implementation PlayListViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    
    UICollectionViewFlowLayout *layout=[[UICollectionViewFlowLayout alloc] init];
    self.objCollection.collectionViewLayout = layout;
    [self.objCollection setDataSource:self];
    [self.objCollection setDelegate:self];
    
    UINib *cellNib = [UINib nibWithNibName:@"PlayListCell" bundle:nil];
    [self.objCollection registerNib:cellNib forCellWithReuseIdentifier:@"PlayListCell"];
    
//    [self.objCollection registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:@"cellIdentifier"];
    
    [self showActivityIndicator];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(void)viewWillAppear:(BOOL)animated
{
//    [self.navigationController.navigationBar setHidden:YES];
    
}
-(void)viewDidAppear:(BOOL)animated
{
    DataHelper *dataHelper = [DataHelper sharedInstance];
    [dataHelper dataFromUrl:@"http://198.24.154.201/~viri/mobile/webcopy/getwbs_playlists.php"];
    dataHelper.dataDelegate = self;
}
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return self.gridData.count;
}

// The cell that is returned must be retrieved from a call to -dequeueReusableCellWithReuseIdentifier:forIndexPath:
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    PlayListCell *cell= (PlayListCell*)[collectionView dequeueReusableCellWithReuseIdentifier:@"PlayListCell" forIndexPath:indexPath];
    NSDictionary *dic = [self.gridData objectAtIndex:indexPath.row];
    NSURL *imageUrl = [NSURL URLWithString:[dic objectForKey:@"image"]];
    NSData *imageData = [NSData dataWithContentsOfURL:imageUrl];
    cell.objImageView.image = [UIImage imageWithData:imageData];

    cell.objLabel.text = [NSString stringWithFormat:@"%@",[dic objectForKey:@"playlist_name"]];
//    cell.backgroundView.backgroundColor = [UIColor greenColor];
//id
    return cell;
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    return CGSizeMake(self.objCollection.frame.size.width/2-5, self.objCollection.frame.size.width/2-5);
}
-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    NSDictionary *dic = [self.gridData objectAtIndex:indexPath.row];
    NSString *playlistName = [dic objectForKey:@"playlist_name"];

    NSURL *imageUrl = [NSURL URLWithString:[dic objectForKey:@"image"]];
    NSData *imageData = [NSData dataWithContentsOfURL:imageUrl];
    UIImage *image = [UIImage imageWithData:imageData];
    
    AlbumViewController *objAlbum = [self.storyboard instantiateViewControllerWithIdentifier:@"AlbumViewController"];
    objAlbum.songID =[dic objectForKey:@"id"];
    objAlbum.playListNme = playlistName;
    objAlbum.playlistImage = image;
    [self.navigationController pushViewController:objAlbum animated:YES];
}
- (void)pollingFetehData:(NSMutableDictionary*)data
{
    NSLog(@"A");
}
-(void)displayFechedContent:(NSArray*)feachedArray
{
    NSLog(@"A");
    if (feachedArray.count>0)
    {
        self.gridData = [[NSMutableArray alloc]initWithArray:feachedArray];
        [self.objCollection reloadData];
        [self removeActivityIndicator];
    }
}


- (void)showActivityIndicator{
    if (progressHUD == nil) {
        progressHUD = [[MBProgressHUD alloc]initWithView:[[[UIApplication sharedApplication] delegate] window]];
    }
    [progressHUD removeFromSuperViewOnHide];
    progressHUD.labelText = @"Loading...";
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
