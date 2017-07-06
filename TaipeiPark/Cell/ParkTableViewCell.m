//
//  ParkTableViewCell.m
//  TaipeiPark
//
//  Created by linyuta on 07/07/2017.
//  Copyright © 2017 TaipeiData. All rights reserved.
//

#import "ParkTableViewCell.h"
#import "ParkDataModel.h"

@interface ParkTableViewCell()

@property (weak, nonatomic) IBOutlet UILabel *parkNameLabel;
@property (weak, nonatomic) IBOutlet UILabel *parkImageNameLabel;
@property (weak, nonatomic) IBOutlet UILabel *parkIntroductionLabel;


@end

@implementation ParkTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)setParkData:(ParkDataModel *)parkData {
    self.parkNameLabel.text = parkData.name;
    self.parkImageNameLabel.text = parkData.imageURLString;
    self.parkIntroductionLabel.text = parkData.introduction;
}

@end
