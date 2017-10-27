//
//  ViewController.m
//  Receipts
//
//  Created by Olga on 10/26/17.
//  Copyright © 2017 Olga Nesterova. All rights reserved.
//

#import "ViewController.h"
#import "AppDelegate.h"

@interface ViewController ()
@property (weak, nonatomic) IBOutlet UITableView *tableView;

@property (nonatomic, strong) NSArray<Receipt *> *receipts;
@property (nonatomic, strong) NSArray<Tag *> *tags;
@property (nonatomic, strong) NSArray *uniqueTags;
@end

@implementation ViewController

- (void)viewDidLoad {
    
    
    [super viewDidLoad];
    [self getAllReceipts];
    [self getAllTags];
    [self getUniqueTags];
    
    

    
    
}

-(void)viewWillAppear:(BOOL)animated {
//    [self getAllReceipts];

    [self.tableView reloadData];
}

- (void)insertNewObject:(id)sender {
    AppDelegate *appDelegate = (AppDelegate *)[UIApplication sharedApplication].delegate;
    NSPersistentContainer *persistentContainer = appDelegate.persistentContainer;
    
    NSManagedObjectContext *context = [self.fetchedResultsController managedObjectContext];
//    Receipt *newReceipt = [[Receipt alloc] initWithContext:context];
    
    NSError *error = nil;
    NSFetchRequest<Receipt *> *fetchReceiptsRequest = [Receipt fetchRequest];
    self.receipts = [persistentContainer.viewContext executeFetchRequest:fetchReceiptsRequest error:&error];
    error = nil;
//    NSFetchRequest<Tag *> *fetchTagsRequest = [Tag fetchRequest];
//    self.tags = [persistentContainer.viewContext executeFetchRequest:fetchTagsRequest error:&error];
//
    
    
    
    // If appropriate, configure the new managed object.
//    newReceipt.timestamp = [NSDate date];
    
    // Save the context.
   // NSError *error = nil;
    if (![context save:&error]) {
        // Replace this implementation with code to handle the error appropriately.
        // abort() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
        NSLog(@"Unresolved error %@, %@", error, error.userInfo);
        abort();
    }
}

#pragma mark - Segues

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([[segue identifier] isEqualToString:@"addNewSegue"]) {
//        NSIndexPath *indexPath = [self.tableView indexPathForSelectedRow];
//        Event *object = [self.fetchedResultsController objectAtIndexPath:indexPath];
//        DetailViewController *controller = (DetailViewController *)[[segue destinationViewController] topViewController];
//        [controller setDetailItem:object];
//        controller.navigationItem.leftBarButtonItem = self.splitViewController.displayModeButtonItem;
//        controller.navigationItem.leftItemsSupplementBackButton = YES;
    }
}


#pragma mark - Table View
// TODO!!! from fetched results
//- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
//  return self.tagsSet.count;
//}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.receipts.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cellId" forIndexPath:indexPath];
    Receipt *receipt = [self.receipts objectAtIndex:indexPath.row];
//    NSArray *tags = receipt.tag.allObjects;
    cell.textLabel.text = receipt.note;
    cell.detailTextLabel.text = [NSString stringWithFormat:@"%f", receipt.amount];

    return cell;
}


- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the specified item to be editable.
    return YES;
}


- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        NSManagedObjectContext *context = [self.fetchedResultsController managedObjectContext];
        [context deleteObject:[self.fetchedResultsController objectAtIndexPath:indexPath]];
        
        NSError *error = nil;
        if (![context save:&error]) {
            // Replace this implementation with code to handle the error appropriately.
            // abort() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
            NSLog(@"Unresolved error %@, %@", error, error.userInfo);
            abort();
        }
    }
}


- (void)configureCell:(UITableViewCell *)cell withEvent:(Receipt *)receipt {
    cell.textLabel.text = receipt.description;
    cell.detailTextLabel.text = [NSString stringWithFormat:@"%f", receipt.amount];
}


#pragma mark - Fetched results

-(void)getAllReceipts {
    AppDelegate *appDelegate = (AppDelegate *)[UIApplication sharedApplication].delegate;
    NSPersistentContainer *persistentContainer = appDelegate.persistentContainer;
    
    NSManagedObjectContext *context = persistentContainer.viewContext;
    NSFetchRequest *request = [Receipt fetchRequest];
    self.receipts = [context executeFetchRequest:request error:nil];
}

-(void)getAllTags {
    AppDelegate *appDelegate = (AppDelegate *)[UIApplication sharedApplication].delegate;
    NSPersistentContainer *persistentContainer = appDelegate.persistentContainer;
    
    NSManagedObjectContext *context = persistentContainer.viewContext;
    NSFetchRequest *request = [Tag fetchRequest];
    self.tags = [context executeFetchRequest:request error:nil];
    NSLog(@"There are %lu objects in tags array", self.tags.count);

}

-(void)getUniqueTags {
    if (!self.uniqueTags) {
        self.uniqueTags = [NSArray new];
    }
    
    NSArray *tagName = [self.tags valueForKey:@"tagName"];
    NSLog(@"%@", tagName);
    
    NSArray *uniqueTags = [tagName valueForKeyPath:@"@distinctUnionOfObjects.self"];
    NSLog(@"uniqueTags: %@", uniqueTags);
    }

@end
