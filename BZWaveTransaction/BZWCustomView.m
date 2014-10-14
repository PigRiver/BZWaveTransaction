//
//  BZWCustomView.m
//  BZWaveTransaction
//
//  Created by Bruce on 14-7-30.
//  Copyright (c) 2014年 com.Bruce.Wave. All rights reserved.
//

#import "BZWCustomView.h"

@implementation BZWCustomView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        self.tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, self.frame.size.width, self.frame.size.height)];
        [self.tableView setBackgroundColor:[UIColor clearColor]];
        self.tableView.dataSource = self;
        self.tableView.delegate = self;
        
        [self addSubview:self.tableView];
        self.data =
        @[
          @{@"text": @"Stylized organs", @"icon": @"heart"},
          @{@"text": @"Food pictures", @"icon": @"camera"},
          @{@"text": @"Straight line maker", @"icon": @"pencil"},
          @{@"text": @"Let's cook!", @"icon": @"beaker"},
          @{@"text": @"That's the puzzle!", @"icon": @"puzzle"},
          @{@"text": @"Cheers", @"icon": @"glass"}
          ];
        [self.tableView reloadData];
    }
    return self;
}

- (id)init {
    self = [super init];
    return self;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [self.data count];
}

- (UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell* cell = [tableView dequeueReusableCellWithIdentifier:@"Cell"];
    
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"Cell"];
    }
    
    NSDictionary* dict = self.data[indexPath.row];
    
    cell.textLabel.text = dict[@"text"];
    [cell setBackgroundColor:[UIColor clearColor]];
	[cell setSelectionStyle:UITableViewCellSelectionStyleNone];
    
    return cell;
}

@end
