//
//  APIManager.h
//  TaipeiPark
//
//  Created by linyuta on 06/07/2017.
//  Copyright © 2017 TaipeiData. All rights reserved.
//

#import <Foundation/Foundation.h>

#define serverDomainName @"http://data.taipei/opendata/datalist/apiAccess"

@interface APIManager : NSObject

+ (id)shared;
- (void)postWithParameters:(NSDictionary *)parameters completion:(void (^)(BOOL finished, id data))completion failure:(void (^)(NSError *error))failure;

@end
