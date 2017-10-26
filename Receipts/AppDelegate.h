//
//  AppDelegate.h
//  Receipts
//
//  Created by Olga on 10/26/17.
//  Copyright © 2017 Olga Nesterova. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreData/CoreData.h>

@interface AppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;

@property (readonly, strong) NSPersistentContainer *persistentContainer;

- (void)saveContext;


@end

