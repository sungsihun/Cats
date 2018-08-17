//
//  Photo.m
//  Cats
//
//  Created by NICE on 2018-08-16.
//  Copyright © 2018 NICE. All rights reserved.
//

#import "Photo.h"

@implementation Photo

- (instancetype)initWithInfo:(NSDictionary*)info {
    if (self = [super init]) {
        NSData *data = [NSData dataWithContentsOfURL:[NSURL URLWithString:info[@"images"][0][@"link"]]];
        _image = [UIImage imageWithData:data];
    }
    return self;
}



@end
