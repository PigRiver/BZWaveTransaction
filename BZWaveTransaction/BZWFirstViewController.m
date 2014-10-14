//
//  BZWFirstViewController.m
//  BZWaveTransaction
//
//  Created by Bruce on 14-7-30.
//  Copyright (c) 2014年 com.Bruce.Wave. All rights reserved.
//

#import "BZWFirstViewController.h"
#import "BZWSecondViewController.h"
#import "BZWCustomView.h"

@interface BZWFirstViewController () <BZWTransactionDelegate>

@end

@implementation BZWFirstViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [self.navigationController.view setBackgroundColor:[UIColor colorWithRed:0.2 green:0.5 blue:0.5 alpha:0.7]];
    
    self.tableView.dataSource = self;
    self.tableView.delegate = self;
    
    [self setTitle:@"First Page"];
    self.data = [NSArray arrayWithObjects:@"Bruce", @"Rogers", @"Micheal", @"Corbin", @"Celine", nil];
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
    [cell setBackgroundColor:[UIColor clearColor]];
	[cell setSelectionStyle:UITableViewCellSelectionStyleNone];
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    BZWSecondViewController *second = [[BZWSecondViewController alloc] init];
    [self pushToVC:second];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 60;
}

@end
