//
//  ParkTableViewCell.h
//  TaipeiPark
//
//  Created by linyuta on 07/07/2017.
//  Copyright © 2017 TaipeiData. All rights reserved.
//

#import <UIKit/UIKit.h>

@class ParkDataModel;

@interface ParkTableViewCell : UITableViewCell

@property (strong, nonatomic) ParkDataModel *parkData;

@end
