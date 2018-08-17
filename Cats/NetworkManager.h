//
//  NetworkManager.h
//  Cats
//
//  Created by NICE on 2018-08-16.
//  Copyright © 2018 NICE. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NetworkManager : NSObject
+ (void)getImages:(void (^)(NSArray* images))completion;
@end
