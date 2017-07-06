//
//  ParkDataModel.m
//  TaipeiPark
//
//  Created by linyuta on 06/07/2017.
//  Copyright © 2017 TaipeiData. All rights reserved.
//

#import "ParkDataModel.h"
#import "APIManager.h"

static const int ONE_TIME_GET_MAX_PARK_COUNT = 30;
static const int LIMIT_COUNT                 = 295;

@implementation ParkDataModel

- (instancetype)initWithData:(NSDictionary *)data {
    self = [super init];
    if (self) {
        self._id = data[@"_id"] ?: @"";
        self.parkName = data[@"parkName"] ?: @"";
        self.name = data[@"Name"] ?: @"";
        self.openTime = data[@"OpenTiem"] ?: @"";
        self.yearBuilt = data[@"YearBuilt"] ?: @"";
        self.imageURLString = data[@"Image"] ?: @"";
        self.introduction = data[@"Introduction"] ?: @"";
    }
    return self;
}

+ (void)getParkListWithPage:(NSUInteger)page completion:(void(^)(NSArray<ParkDataModel *> *))completion failure:(void(^)(NSError *))failure {
    NSUInteger limit;
    NSUInteger offset = ONE_TIME_GET_MAX_PARK_COUNT * page;
    if (offset > LIMIT_COUNT) {
        limit = LIMIT_COUNT - (ONE_TIME_GET_MAX_PARK_COUNT * (page - 1));
    } else {
        limit = ONE_TIME_GET_MAX_PARK_COUNT;
    }
    NSDictionary *parameters = @{@"scope": @"resourceAquire",
                                 @"rid": @"bf073841-c734-49bf-a97f-3757a6013812",
                                 @"limit": [NSString stringWithFormat:@"%i", ONE_TIME_GET_MAX_PARK_COUNT],
                                 @"offset": [NSString stringWithFormat:@"%li", offset]};
    
    [[APIManager shared] postWithParameters:parameters completion:^(BOOL finished, id data) {
        NSMutableArray <ParkDataModel *> *newParklist = [NSMutableArray array];
        
        for (NSDictionary *tempData in data[@"result"][@"results"]) {
            ParkDataModel *parkData = [[ParkDataModel alloc] initWithData:tempData];
            [newParklist addObject:parkData];
        }
        
        completion(newParklist);
    } failure:^(NSError *error) {
        failure(error);
    }];
}

@end
