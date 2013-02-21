//
//  RESTService.h
//  mySharp
//
//  Created by Jason Blood on 2/23/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "NSString+URLEncoding.h"

@interface RESTService : NSObject <NSURLConnectionDelegate>
{
}

- (void)getUrl:(NSString *)urlString onCompletion:(void (^)(id obj, NSError *error))completion;
- (void)putUrl:(NSString *)urlString withObject:(id)data onCompletion:(void (^)(id obj, NSError *error))completion;
- (void)deleteUrl:(NSString *)urlString onCompletion:(void (^)(id obj, NSError *error))completion;
- (void)postUrl:(NSString *)urlString withObject:(id)data onCompletion:(void (^)(id obj, NSError *error))completion;

@end
