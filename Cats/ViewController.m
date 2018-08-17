//
//  ViewController.m
//  Cats
//
//  Created by NICE on 2018-08-16.
//  Copyright © 2018 NICE. All rights reserved.
//

#import "ViewController.h"
#import "CollectionViewCell.h"
#import "NetworkManager.h"
#import "Photo.h"

@interface ViewController () <UICollectionViewDataSource>
@property (weak, nonatomic) IBOutlet UICollectionView *collectionView;
@property (nonatomic, strong) NSArray<Photo*> *objects;
@property (nonatomic, strong) NSMutableArray *imageLinkArray;
@property (nonatomic, strong) NSMutableArray<UIImage*> *imageArray;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [NetworkManager getImages:^(NSArray *images) {
        self.objects = images;
        [[NSOperationQueue mainQueue] addOperationWithBlock:^{
            [self.collectionView reloadData];
        }];
    }];
    NSLog(@"Method finished");
}



#pragma mark - DataSource

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return 1;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return self.objects.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    CollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"Cell" forIndexPath:indexPath];
    [cell setPhoto:self.objects[indexPath.row]];
    return cell;
}


@end
