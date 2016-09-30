//
//  UmbrellaImageCheck.m
//  Umbrella
//
//  Created by huangrensheng on 16/9/29.
//  Copyright © 2016年 umbrella. All rights reserved.
//

#import "UmbrellaImageCheck.h"
#import "CheckImageCollectionCell.h"

@interface UmbrellaImageCheck()<UICollectionViewDelegate,UICollectionViewDataSource>

@property (weak, nonatomic) IBOutlet UISegmentedControl *cageCheck;

@property (weak, nonatomic) IBOutlet UICollectionView *imageCollectiom;

@end

@implementation UmbrellaImageCheck

- (void)awakeFromNib{
    [super awakeFromNib];
    
    [self.imageCollectiom registerClass:[CheckImageCollectionCell class] forCellWithReuseIdentifier:@"HDCheckImageCell"];
}

#pragma mark UICollectionViewDelegate
- (NSInteger)collectionView:( UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return 30;
}

-(NSInteger )numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return 1 ;
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath{
    
    return CGSizeMake((self.frame.size.width-60-16)/3, (self.frame.size.width-60-16)/3);
}

- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section
{
    return 8;
}

- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section
{
    return 1;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    CheckImageCollectionCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"HDCheckImageCell" forIndexPath:indexPath];
    [cell.showImage setImage:[UIImage imageNamed:@"test"]];
    return cell;
}


- (BOOL)collectionView:(UICollectionView *)collectionView shouldSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    return YES ;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{

}



@end
