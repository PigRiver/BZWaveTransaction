//
//  BZWWaveTransaction.h
//  BZWaveTransaction
//
//  Created by Bruce on 14-7-30.
//  Copyright (c) 2014年 com.Bruce.Wave. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol BZWTransactionDelegate <NSObject>

- (NSArray *)transactionCells;

@end

@interface BZWWaveTransaction : NSObject

@property (assign, nonatomic) UINavigationControllerOperation operation;

- (BOOL)pushWaveTransactionFromVC:(UIViewController<BZWTransactionDelegate> *)fromVC
                             toVC:(UIViewController<BZWTransactionDelegate> *)toVC;
- (BOOL)popWaveTransactionFromVC:(UIViewController<BZWTransactionDelegate> *)fromVC
                            toVC:(UIViewController<BZWTransactionDelegate> *)toVC;

@end
