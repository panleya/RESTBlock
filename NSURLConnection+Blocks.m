//
//  NSObject+AssociatedObjects.m
//  photon
//
//  Created by Jason Blood on 2/14/13.
//  Copyright (c) 2013 Photon Medical Communications. All rights reserved.
//

#import "NSURLConnection+Blocks.h"

@implementation NSURLConnection (block)

#pragma mark API
+ (void)asyncRequest:(NSURLRequest *)request success:(void(^)(NSData *data, NSURLResponse *response, NSError *error))successBlock
{
    dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0ul);
    dispatch_async(queue, ^{
        NSURLResponse *response = nil;
        NSError *error = nil;
        
        NSData *data = [NSURLConnection sendSynchronousRequest:request returningResponse:&response error:&error];
        
        if (successBlock != nil)
        {
            dispatch_sync(dispatch_get_main_queue(), ^{
                if (error)
                {
                    successBlock(data, nil, error);
                }
                else
                {
                    successBlock(data, response, nil);
                }
            });//end block
        }
    });
}

@end