//
//  DataSource.h
//  PullToRefresh
//
//  Created by Paul Jackson on 04/07/2014.
//  Copyright (c) 2014 PaulJ.ME. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface DataSource : NSObject <UITableViewDataSource>

- (instancetype)initWithCellIdentifier:(NSString *)cellIdentifier;
- (void)requestData:(void(^)(void))complete;

@end
