//
//  AppDelegate.h
//  CiShanZhong
//
//  Created by KatyChn on 15/12/25.
//  Copyright © 2015年 陈璐. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "RESideMenu.h"
#import "TabBarViewController.h"
#import <CoreData/CoreData.h>
@interface AppDelegate : UIResponder <UIApplicationDelegate,RESideMenuDelegate>

@property (strong, nonatomic) UIWindow *window;
@property (nonatomic, assign)NSInteger currentIndex;
@property (nonatomic, strong)TabBarViewController *tabbarController;
@property (nonatomic, strong)RESideMenu *sideMenuViewController;
@property (readonly, strong, nonatomic) NSManagedObjectContext *managedObjectContext;
@property (readonly, strong, nonatomic) NSManagedObjectModel *managedObjectModel;
@property (readonly, strong, nonatomic) NSPersistentStoreCoordinator *persistentStoreCoordinator;

- (void)setupRootViewController:(UIViewController *)viewController;

//- (void)saveContext;
//- (NSURL *)applicationDocumentsDirectory;


@end

