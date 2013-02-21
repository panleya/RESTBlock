//
//  RESTService.m
//  mySharp
//
//  Created by Jason Blood on 2/23/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "RESTService.h"
#import "NSURLConnection+Blocks.h"

@implementation RESTService

#pragma mark - Methods
- (void)getUrl:(NSString *)urlString onCompletion:(void (^)(id obj, NSError *error))completion
{
    NSMutableURLRequest *theRequest = [[NSMutableURLRequest alloc] init];
    [theRequest setURL:[NSURL URLWithString:urlString]];
    [theRequest setCachePolicy:NSURLRequestUseProtocolCachePolicy];
    [theRequest setTimeoutInterval:60.0];
	
    //these are needed for .NET service calls to return JSON
    [theRequest setValue:@"application/json" forHTTPHeaderField:@"Accept"];
    [theRequest setValue:@"application/x-www-form-urlencoded" forHTTPHeaderField:@"Content-Type"];
    
    [NSURLConnection asyncRequest:theRequest success:^(NSData *data, NSURLResponse *response, NSError *error) {
        if (completion != nil)
        {
            if (data == nil)
            {
                completion(nil, error);
            }
            else
            {
                if ([data length] == 0)
                {
                    completion(nil, error);
                }
                else
                {
                    id dta = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:&error];
                    completion(dta, error);
                }
            }
        }
    }];
}
- (void)putUrl:(NSString *)urlString withObject:(id)data onCompletion:(void (^)(id obj, NSError *error))completion
{
    NSData *requestData = [NSJSONSerialization dataWithJSONObject:data options:0 error:nil];
    
    NSMutableURLRequest *theRequest = [[NSMutableURLRequest alloc] init];
    [theRequest setURL:[NSURL URLWithString:urlString]];
    [theRequest setCachePolicy:NSURLRequestUseProtocolCachePolicy];
    [theRequest setTimeoutInterval:60.0];
	[theRequest setHTTPMethod:@"PUT"];
    
    //these are needed for .NET service calls to return JSON
    [theRequest setValue:@"application/json" forHTTPHeaderField:@"Accept"];
    [theRequest addValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
    [theRequest setValue:[NSString stringWithFormat:@"%d", [requestData length]] forHTTPHeaderField:@"Content-Length"];
    [theRequest setHTTPBody:requestData];
    
    [NSURLConnection asyncRequest:theRequest success:^(NSData *data, NSURLResponse *response, NSError *error) {
        if (completion != nil)
        {
            if (data == nil)
            {
                completion(nil, error);
            }
            else
            {
                if ([data length] == 0)
                {
                    completion(nil, error);
                }
                else
                {
                    id dta = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:&error];
                    completion(dta, error);
                }
            }
        }
    }];
}
- (void)deleteUrl:(NSString *)urlString onCompletion:(void (^)(id obj, NSError *error))completion
{
    NSMutableURLRequest *theRequest = [[NSMutableURLRequest alloc] init];
    [theRequest setURL:[NSURL URLWithString:urlString]];
    [theRequest setCachePolicy:NSURLRequestUseProtocolCachePolicy];
    [theRequest setTimeoutInterval:60.0];
	[theRequest setHTTPMethod:@"DELETE"];
    
    //these are needed for .NET service calls to return JSON
    [theRequest setValue:@"application/json" forHTTPHeaderField:@"Accept"];
    [theRequest setValue:@"application/x-www-form-urlencoded" forHTTPHeaderField:@"Content-Type"];
    
    [NSURLConnection asyncRequest:theRequest success:^(NSData *data, NSURLResponse *response, NSError *error) {
        if (completion != nil)
        {
            if (data == nil)
            {
                completion(nil, error);
            }
            else
            {
                if ([data length] == 0)
                {
                    completion(nil, error);
                }
                else
                {
                    id dta = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:&error];
                    completion(dta, error);
                }
            }
        }
    }];
}
- (void)postUrl:(NSString *)urlString withObject:(id)data onCompletion:(void (^)(id obj, NSError *error))completion
{
    NSData *requestData = [NSJSONSerialization dataWithJSONObject:data options:0 error:nil];
    
    NSMutableURLRequest *theRequest = [[NSMutableURLRequest alloc] init];
    [theRequest setURL:[NSURL URLWithString:urlString]];
    [theRequest setCachePolicy:NSURLRequestUseProtocolCachePolicy];
    [theRequest setTimeoutInterval:60.0];
    [theRequest setValue:@"application/json" forHTTPHeaderField:@"Accept"];
    [theRequest addValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
    [theRequest setValue:[NSString stringWithFormat:@"%d", [requestData length]] forHTTPHeaderField:@"Content-Length"];
    [theRequest setHTTPMethod:@"POST"];
    [theRequest setHTTPBody:requestData];
    
    [NSURLConnection asyncRequest:theRequest success:^(NSData *data, NSURLResponse *response, NSError *error) {
        if (completion != nil)
        {
            if (data == nil)
            {
                completion(nil, error);
            }
            else
            {
                if ([data length] == 0)
                {
                    completion(nil, error);
                }
                else
                {
                    id dta = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:&error];
                    completion(dta, error);
                }
            }
        }
    }];
}
@end