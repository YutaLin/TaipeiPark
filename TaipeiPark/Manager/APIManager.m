//
//  APIManager.m
//  TaipeiPark
//
//  Created by linyuta on 06/07/2017.
//  Copyright © 2017 TaipeiData. All rights reserved.
//

#import "APIManager.h"

@interface APIManager()

@property (strong, nonatomic) NSString *baseURL;

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

- (instancetype)init {
    self = [super init];
    if (self) {
        self.baseURL = serverDomainName;
    }
    return self;
}

- (void)postWithParameters:(NSDictionary *)parameters completion:(void (^)(BOOL finished, id data))completion failure:(void (^)(NSError *error))failure {
    NSString *requestURLString = [self convertToQueries:parameters];
    NSCharacterSet *allowedCharacters = [NSCharacterSet URLFragmentAllowedCharacterSet];
    NSURL *requestURL = [NSURL URLWithString:[requestURLString stringByAddingPercentEncodingWithAllowedCharacters:allowedCharacters]];
    NSURLRequest * urlRequest = [NSURLRequest requestWithURL:requestURL cachePolicy:NSURLRequestReturnCacheDataElseLoad timeoutInterval:30];
    
    NSURLSessionDataTask *dataTask = [[NSURLSession sharedSession] dataTaskWithRequest:urlRequest completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        if (error) {
            failure(error);
        } else {
            NSError *jsonError;
            NSDictionary *dicData = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:&jsonError];
            if (jsonError == nil) {
                completion(YES, dicData);
            } else {
                failure(jsonError);
            }
        }
    }];
    
    [dataTask resume];
}

- (NSString *)convertToQueries:(NSDictionary *)parameters {
    NSMutableString *queries = [[NSMutableString alloc] initWithString:self.baseURL];
    for (id key in parameters) {
        NSString *keyString = [key description];
        NSString *valeuString = [[parameters objectForKey:key] description];
        
        if ([queries rangeOfString:@"?"].location == NSNotFound) {
            [queries appendFormat:@"?%@=%@", keyString, valeuString];
        } else {
            [queries appendFormat:@"&%@=%@", keyString, valeuString];
        }
    }
    
    return queries;
}


@end
