//
//  BZWCustomView.h
//  BZWaveTransaction
//
//  Created by Bruce on 14-7-30.
//  Copyright (c) 2014年 com.Bruce.Wave. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BZWWaveTransaction.h"

@interface BZWCustomView : UIView<UITableViewDelegate, UITableViewDataSource, UITableViewDelegate, UINavigationControllerDelegate>

@property (strong, nonatomic) UITableView *tableView;
@property (strong, nonatomic) NSArray *data;

@end
