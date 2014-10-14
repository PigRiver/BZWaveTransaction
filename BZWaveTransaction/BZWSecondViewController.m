//
//  BZWSecondViewController.m
//  BZWaveTransaction
//
//  Created by Bruce on 14-7-30.
//  Copyright (c) 2014年 com.Bruce.Wave. All rights reserved.
//

#import "BZWSecondViewController.h"
#import "BZWWaveTransaction.h"

@interface BZWSecondViewController () <BZWTransactionDelegate>

@end

@implementation BZWSecondViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.tableView.dataSource = self;
    self.tableView.delegate = self;
    
    [self setTitle:@"Second Page"];
    self.data = [NSArray arrayWithObjects:@"Very Very Handsome", @"Very Very Smart", @"Very Very Beautiful", @"Very Very Wonderful", @"Very Very And So On", @"Very Very And So On", @"Very Very And So On", @"Very Very And So On", nil];
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
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
    
    cell.textLabel.text = self.data[indexPath.row];
	[cell setSelectionStyle:UITableViewCellSelectionStyleNone];
    
    return cell;
}

@end
