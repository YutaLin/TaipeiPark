//
//  ViewController.m
//  TaipeiPark
//
//  Created by linyuta on 06/07/2017.
//  Copyright © 2017 TaipeiData. All rights reserved.
//

#import "ViewController.h"
#import "ParkDataModel.h"
#import "ParkTableViewCell.h"

@interface ViewController () <
UITableViewDelegate,
UITableViewDataSource
> {
    NSUInteger currentPage;
    BOOL couldLoadMore;
}

@property (weak, nonatomic) IBOutlet UITableView *parkListTableView;
@property (strong, nonatomic) NSMutableArray <ParkDataModel *> *parkList;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    couldLoadMore = YES;
    self.parkList = [NSMutableArray array];
    
    [self setupTableView];
    [self updateParkList];
}

- (void)setupTableView {
    self.parkListTableView.delegate = self;
    self.parkListTableView.dataSource = self;
    self.parkListTableView.rowHeight = UITableViewAutomaticDimension;
    self.parkListTableView.estimatedRowHeight = 100;
        [self.parkListTableView registerNib:[UINib nibWithNibName:@"ParkTableViewCell" bundle: nil] forCellReuseIdentifier:@"ParkTableViewCell"];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

#pragma mark - Private

- (void)updateParkList {
    
    if (!couldLoadMore) {
        return;
    }
    
    [ParkDataModel getParkListWithPage:currentPage completion:^(NSArray<ParkDataModel *> *data) {
        currentPage += 1;
        [self.parkList addObjectsFromArray:(NSMutableArray *)data];
        dispatch_async(dispatch_get_main_queue(), ^{
            [self.parkListTableView reloadData];
        });
    } failure:^(NSError *error) {
        
    }];
}

#pragma mark - UITableViewDataSource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.parkList.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    ParkTableViewCell *parkTableViewCell = [tableView dequeueReusableCellWithIdentifier:@"ParkTableViewCell"forIndexPath:indexPath];
    parkTableViewCell.parkData = self.parkList[indexPath.row];
    return parkTableViewCell;
}

#pragma mark - UITableViewDelegate

- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath {
    
    NSArray *visibleRows = [tableView indexPathsForVisibleRows];
    NSIndexPath *lastVisibleCellIndexPath = [visibleRows lastObject];
    
    if (lastVisibleCellIndexPath.row + 10 >= self.parkList.count ) {
        [self updateParkList];
        couldLoadMore = NO;
    } else {
        couldLoadMore = YES;
    }
}

@end
