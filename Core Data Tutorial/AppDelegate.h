//
//  AppDelegate.h
//  Core Data Tutorial
//
//  Created by Raj Dhakate on 01/02/17.
//  Copyright © 2017 Raj Dhakate. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreData/CoreData.h>

@interface AppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;

@property (readonly, strong) NSPersistentContainer *persistentContainer;

- (void)saveContext;


@end

