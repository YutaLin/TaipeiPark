//
//  ParkDataModel.h
//  TaipeiPark
//
//  Created by linyuta on 06/07/2017.
//  Copyright © 2017 TaipeiData. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ParkDataModel : NSObject

@property (strong, nonatomic) NSString *_id;
@property (strong, nonatomic) NSString *parkName;
@property (strong, nonatomic) NSString *name;
@property (strong, nonatomic) NSString *yearBuilt;
@property (strong, nonatomic) NSString *openTime;
@property (strong, nonatomic) NSString *imageURLString;
@property (strong, nonatomic) NSString *introduction;

+ (void)getParkListWithPage:(NSUInteger)page completion:(void(^)(NSArray<ParkDataModel *> *))completion failure:(void(^)(NSError *))failure;

@end
