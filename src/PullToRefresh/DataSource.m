//
//  DataSource.m
//  PullToRefresh
//
//  Created by Paul Jackson on 04/07/2014.
//  Copyright (c) 2014 PaulJ.ME. All rights reserved.
//

#import "DataSource.h"

@implementation DataSource
{
    NSString *_cellIdentifier;
    NSMutableArray *_data;
}

- (instancetype)initWithCellIdentifier:(NSString *)cellIdentifier
{
    self = [super init];
    if (self) {
        _cellIdentifier = [cellIdentifier copy];
        _data = [NSMutableArray array];
    }
    return self;
}

#pragma mark - DataSource

- (void)requestData:(void (^)(void))complete
{
    // Update network activity UI
    [UIApplication sharedApplication].networkActivityIndicatorVisible = YES;
    
    // Do work off the main thread
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        
        // Simulate network traffic (sleep for 2 seconds)
        [NSThread sleepForTimeInterval:2];
        
        // Create sample data
        static int index = 0; index++;

        [_data removeAllObjects];
        for (int i = 1; i <= 15; i++) {
            [_data insertObject:[NSNumber numberWithInt:i * index] atIndex:0];
        }
        
        // Call complete on the main thread
        dispatch_async(dispatch_get_main_queue(), ^{

            // Update network activity UI
            [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
            
            // Callback to the calling controller
            complete();
        });
    });
}

#pragma mark - UITableViewDataSource

- (NSInteger)tableView:(UITableView *)tableView
 numberOfRowsInSection:(NSInteger)section
{
    return _data.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView
         cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:_cellIdentifier];
    cell.textLabel.text = [NSString stringWithFormat:@"# %@", _data[indexPath.row]];
    return cell;
}

@end
