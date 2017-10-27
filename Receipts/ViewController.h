//
//  ViewController.h
//  Receipts
//
//  Created by Olga on 10/26/17.
//  Copyright © 2017 Olga Nesterova. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreData/CoreData.h>
#import "Receipt+CoreDataClass.h"
#import "Tag+CoreDataClass.h"

@interface ViewController : UIViewController <NSFetchedResultsControllerDelegate, UITableViewDelegate, UITableViewDataSource>

@property (strong, nonatomic) NSFetchedResultsController<Receipt *> *fetchedResultsController;
@property (strong, nonatomic) NSManagedObjectContext *managedObjectContext;


@end

