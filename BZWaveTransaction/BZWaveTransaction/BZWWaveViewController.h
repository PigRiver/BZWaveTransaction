//
//  BZWWaveViewController.h
//  BZWaveTransaction
//
//  Created by Bruce on 14-7-31.
//  Copyright (c) 2014年 com.Bruce.Wave. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BZWWaveTransaction.h"

@interface BZWWaveViewController : UIViewController <BZWTransactionDelegate>

@property (strong, nonatomic) UITableView *tableView;
@property (strong, nonatomic) NSArray *data;
@property (weak, nonatomic) BZWWaveViewController *preViewController;
@property (strong, nonatomic) UIBarButtonItem *leftNavigationBar;

- (BOOL)pushToVC:(BZWWaveViewController *)viewController;
- (BOOL)popUpFromNavigation;

@end
