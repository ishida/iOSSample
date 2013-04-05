//
//  ViewController.h
//  KITableViewSample
//
//  Created by Katsunobu Ishida on 2013/04/05.
//  Copyright (c) 2013 Katsunobu Ishida. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ViewController : UIViewController <UITableViewDataSource, UITableViewDelegate>

@property (strong, nonatomic) IBOutlet UITableView *tableView;
@property (strong, nonatomic) IBOutlet UIBarButtonItem *editingButtonItem;
@property (strong, nonatomic) IBOutlet UIBarButtonItem *doneButtonItem;
@property (strong, nonatomic) IBOutlet UINavigationBar *navigationBar;

@end
