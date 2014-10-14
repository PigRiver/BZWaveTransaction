//
//  BZWSecondViewController.h
//  BZWaveTransaction
//
//  Created by Bruce on 14-7-30.
//  Copyright (c) 2014年 com.Bruce.Wave. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BZWWaveTransaction.h"
#import "BZWFirstViewController.h"

@interface BZWSecondViewController : BZWWaveViewController<BZWTransactionDelegate, UITableViewDelegate, UITableViewDataSource, UITableViewDelegate, UINavigationControllerDelegate>

@end
