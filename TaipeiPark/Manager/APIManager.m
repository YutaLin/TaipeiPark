//
//  APIManager.m
//  TaipeiPark
//
//  Created by linyuta on 06/07/2017.
//  Copyright © 2017 TaipeiData. All rights reserved.
//

#import "APIManager.h"

static NSString *const PARK = @"?scope=resourceAquire&rid=bf073841-c734-49bf-a97f-3757a6013812";

@interface APIManager()

@property (strong, nonatomic) NSURL *baseURL;

@end


@implementation APIManager

+ (id)shared {
    static dispatch_once_t p = 0;
    __strong static id _sharedObject = nil;
    dispatch_once(&p, ^{
        _sharedObject = [[self alloc] init];
        
    });
    return _sharedObject;
}

- (instancetype)initWithBaseURL:(NSURL *)url {
    self = [super init];
    if (self) {
        self.baseURL = url;
    }
    return self;
}

- (void)postWithURL:(NSString *)url completion:(void (^)(BOOL finished, id data))completion failure:(void (^)(NSError *error))failure  {
    NSURL *requestURL = [NSURL URLWithString:url relativeToURL:self.baseURL];
    NSURLRequest * urlRequest = [NSURLRequest requestWithURL:requestURL cachePolicy:NSURLRequestReturnCacheDataElseLoad timeoutInterval:30];
    
    NSURLSessionDataTask *dataTask = [[NSURLSession sharedSession] dataTaskWithRequest:urlRequest completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        if (error) {
            failure(error);
        } else {
            completion(YES, data);
        }
    }];
    
    [dataTask resume];
}


@end
