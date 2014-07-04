//
//  ViewController.m
//  PullToRefresh
//
//  Created by Paul Jackson on 04/07/2014.
//  Copyright (c) 2014 PaulJ.ME. All rights reserved.
//

#import "ViewController.h"
#import "DataSource.h"

@interface ViewController ()

- (IBAction)refresh:(UIRefreshControl *)sender;

@end

@implementation ViewController
{
    DataSource *_dataSource;
}

- (void)viewDidLoad
{
    [super viewDidLoad];

    _dataSource = [[DataSource alloc] initWithCellIdentifier:@"CellIdentifier"];
    self.tableView.dataSource = _dataSource;
    
    [_dataSource requestData:^{
        [self.tableView reloadData];
    }];
}

- (IBAction)refresh:(UIRefreshControl *)sender
{
    // Reload the data. This example datasource uses a block to
    // signal when the data has finished being refreshed
    [_dataSource requestData:^{
        
        // Reload the table data with the new data
        [self.tableView reloadData];
        
        // Restore the view to normal
        [sender endRefreshing];
    }];
}

@end
