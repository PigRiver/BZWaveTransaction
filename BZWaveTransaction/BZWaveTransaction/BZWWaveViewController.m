//
//  BZWWaveViewController.m
//  BZWaveTransaction
//
//  Created by Bruce on 14-7-31.
//  Copyright (c) 2014年 com.Bruce.Wave. All rights reserved.
//

#import "BZWWaveViewController.h"

@interface BZWWaveViewController ()

@end

@implementation BZWWaveViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self initTableView];
    [self initLeftNavigationItem];
    [self setExtraCellLineHidden];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)initTableView {
    self.tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height)];
    [self.tableView setBackgroundColor:[UIColor clearColor]];
    [self.view addSubview:self.tableView];
}

- (void)initLeftNavigationItem {
    if (self.preViewController) {
        UIButton *back = [UIButton buttonWithType:UIButtonTypeCustom];
        back.titleLabel.font = [UIFont boldSystemFontOfSize:13];
        [back setTitle:@"Back" forState:UIControlStateNormal];
        [back setFrame:CGRectMake(5, 2, 52, 30)];
        [back setBackgroundColor:[UIColor grayColor]];
        [back addTarget:self action:@selector(popUpFromNavigation) forControlEvents:UIControlEventTouchUpInside];
        _leftNavigationBar = [[UIBarButtonItem alloc] initWithCustomView:back];
        self.navigationItem.leftBarButtonItem = _leftNavigationBar;
    }
}

- (void)setExtraCellLineHidden
{
    UIView *view =[ [UIView alloc]init];
    view.backgroundColor = [UIColor clearColor];
    [self.tableView setTableFooterView:view];
    
}

#pragma BZWWaveTransactionDelegate
- (NSArray *)transactionCells {
    return [self.tableView visibleCells];
}

#pragma mark Public Method
- (void)setData:(NSArray *)data {
    if (data != nil && [data count] != 0) {
        _data = data;
        [self.tableView reloadData];
    }
}

- (BOOL)pushToVC:(BZWWaveViewController *)viewController {
    if (![viewController isKindOfClass:[BZWWaveViewController class]]) {
        [self.navigationController pushViewController:viewController animated:YES];
        return NO;
    }
    viewController.preViewController = self;
    BZWWaveTransaction *transaction = [[BZWWaveTransaction alloc] init];
    [transaction pushWaveTransactionFromVC:self toVC:viewController];
    
    return YES;
}

- (BOOL)popUpFromNavigation {
    if (!self.preViewController) {
        [self.navigationController popViewControllerAnimated:YES];
        return NO;
    }
    
    BZWWaveTransaction *transaction = [[BZWWaveTransaction alloc] init];
    [transaction popWaveTransactionFromVC:self toVC:self.preViewController];
    
    return YES;
}

@end
