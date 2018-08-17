//
//  Photo.h
//  Cats
//
//  Created by NICE on 2018-08-16.
//  Copyright © 2018 NICE. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface Photo : NSObject
@property (nonatomic) UIImage *image;
@property (nonatomic, strong) NSArray *imagesInfo;
@property (nonatomic, strong) NSString *imagesString;

- (instancetype)initWithInfo:(NSDictionary*)info;

@end
