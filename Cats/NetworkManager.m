//
//  NetworkManager.m
//  Cats
//
//  Created by NICE on 2018-08-16.
//  Copyright © 2018 NICE. All rights reserved.
//

#import "NetworkManager.h"
#import "Photo.h"


@implementation NetworkManager

+ (void)getImages:(void (^)(NSArray* images))completion {
    
    NSURL *url = [NSURL URLWithString:@"https://api.imgur.com/3/gallery/search/?q=cats"];
    
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] initWithURL:url];
    [request setHTTPMethod:@"GET"];
    [request setValue:@"Client-ID cd34ea2f727f78a" forHTTPHeaderField:@"Authorization"];
    
    
    NSURLSessionTask *task = [[NSURLSession sharedSession] dataTaskWithRequest:request completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        NSLog(@"Completed request: %@", response);
        
        // this is checking if there was an error making the request on the iOS networking level
        if (error != nil) {
            NSLog(@"Error making request: %@", error.localizedDescription);
            abort(); // indicate error somehow
        }
        
        // ..but we still need to check if the request was properly understood by the server -- there could be no NSError set, but the response from the server was like "400 - that was some garbage"
        NSInteger statusCode = [(NSHTTPURLResponse*)response statusCode];
        if (statusCode < 200 || statusCode >= 300) {
            // ^ we need to cast the response to an HTTPURLResponse, because  this method is general enough that it can work with non-HTTP urls, hence we have a more general response object (because URLs can be used for protocols other than HTTP & statusCode is an HTTP-specific thing
            // what this is here is "casting" which is *not* "converting" the object -- it's telling XCode "you think it's this type, but I know it's actually this other type"
            NSLog(@"Non-OK error code: %@", response);
            abort(); // indicate failure somehow
        }
        
        // now, we have the NSData with our information
        /* Just for demo purposes, look at our data
         NSString *string = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
         NSLog(@"Got data: %@", string);
         */
        
        NSError *jsonError = nil;
        NSDictionary* info = [NSJSONSerialization
                              JSONObjectWithData:data
                              options:0
                              error:&jsonError];
        if (jsonError != nil) {
            NSLog(@"Error parsing JSON: %@", jsonError.localizedDescription);
            abort();
        }
        
        NSMutableArray *images = [@[] mutableCopy];
        for (NSDictionary *image in info[@"data"]) {
            [images addObject:[[Photo alloc] initWithInfo:image]];
        }
        completion(images);
    }];
    
    NSLog(@"Created task");
    [task resume];
    NSLog(@"Resumed task");
}

@end
