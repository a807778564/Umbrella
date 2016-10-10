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

@property (nonatomic, strong) NSMutableArray *secmeArray;

@property (nonatomic, strong) NSMutableArray *imagesArray;

@end

@implementation UmbrellaImageCheck

- (void)awakeFromNib{
    [super awakeFromNib];
    
    [self.imageCollectiom registerClass:[CheckImageCollectionCell class] forCellWithReuseIdentifier:@"HDCheckImageCell"];
}

- (void)setCageteId:(NSString *)cageteId{
    self.secmeArray = [[NSMutableArray alloc] init];
    [[HttpManager sharedHttpManager] getWithUrl:@"/shop/common/getImageType?" Parames:@{@"mobile":[[NSUserDefaults standardUserDefaults] valueForKey:@"mobile"],@"typeId":cageteId} success:^(id successData) {
        NSArray *cateArray = successData[@"object"];
        [self.secmeArray addObjectsFromArray:cateArray];
        for (int i = 0; i<self.secmeArray.count; i++) {
            NSLog(@"%@",self.secmeArray[i]);
            [self.cageCheck insertSegmentWithTitle:self.secmeArray[i][@"typeName"] atIndex:i animated:YES];
        }
        [self.cageCheck removeSegmentAtIndex:cateArray.count+1 animated:YES];
        [self.cageCheck removeSegmentAtIndex:cateArray.count animated:YES];
        [self.cageCheck setSelectedSegmentIndex:0];
        [self checkCate:self.cageCheck];
    } errorBlock:^(NSError *error) {
        
    }];
}

- (IBAction)checkCate:(UISegmentedControl *)sender {
    [[HttpManager sharedHttpManager] getWithUrl:@"/shop/common/getImageList" Parames:@{@"mobile":[[NSUserDefaults standardUserDefaults] valueForKey:@"mobile"],@"typeCategoryId":self.secmeArray[sender.selectedSegmentIndex][@"typeCategoryId"]} success:^(id successData) {
        self.imagesArray = successData[@"object"];
        [self.imageCollectiom reloadData];
    } errorBlock:^(NSError *error) {
        
    }];
}

#pragma mark UICollectionViewDelegate
- (NSInteger)collectionView:( UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return self.imagesArray.count;
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
    [cell.showImage sd_setImageWithURL:[NSURL URLWithString:self.imagesArray[indexPath.row][@"imagePath"]] placeholderImage:nil options:SDWebImageRetryFailed];//imageId  imagePath
    return cell;
}


- (BOOL)collectionView:(UICollectionView *)collectionView shouldSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    return YES ;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    CheckImageCollectionCell *cell = (CheckImageCollectionCell *)[collectionView cellForItemAtIndexPath:indexPath];
    UIImage *choImage = cell.showImage.image;
    [self.cageCheck removeAllSegments];
    self.chose(choImage);
}

- (void)didChoseImage:(ChoseImage)choseImage{
    self.chose = choseImage;
}


@end
