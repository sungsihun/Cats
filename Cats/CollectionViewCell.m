//
//  CollectionViewCell.m
//  Cats
//
//  Created by NICE on 2018-08-16.
//  Copyright © 2018 NICE. All rights reserved.
//

#import "CollectionViewCell.h"
#import "Photo.h"

@interface CollectionViewCell ()
@property (weak, nonatomic) IBOutlet UIImageView *imageView;
@end

@implementation CollectionViewCell
- (void)setPhoto:(Photo *)photo {
    self.imageView.image = photo.image;
    _photo = photo;
}
@end
