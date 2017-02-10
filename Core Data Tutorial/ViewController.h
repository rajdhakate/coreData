//
//  ViewController.h
//  Core Data Tutorial
//
//  Created by Raj Dhakate on 01/02/17.
//  Copyright © 2017 Raj Dhakate. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreData/CoreData.h>
#import "AppDelegate.h"
#import "Item+CoreDataClass.h"

@interface ViewController : UIViewController <UITableViewDelegate, UITableViewDataSource>

- (IBAction)addItem:(UIBarButtonItem *)sender;

@property (weak, nonatomic) IBOutlet UITableView *tableView;

@end
