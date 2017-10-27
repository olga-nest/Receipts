//
//  ViewController.m
//  Receipts
//
//  Created by Olga on 10/26/17.
//  Copyright © 2017 Olga Nesterova. All rights reserved.
//

#import "ViewController.h"
#import "AppDelegate.h"
#import "ReceiptTableViewCell.h"

@interface ViewController ()
@property (weak, nonatomic) IBOutlet UITableView *tableView;

@property (nonatomic, strong) NSArray <Receipt *> *receipts;
@property (nonatomic, strong) NSArray <Tag *> *tags;
@property (nonatomic, strong) NSArray *uniqueTags;
@property (nonatomic, strong) NSArray *arrayWithTagsAndReciepts;

@end

@implementation ViewController

- (void)viewDidLoad {
    
    [super viewDidLoad];
    [self getAllReceipts];
    [self getAllTags];
    [self getUniqueTags];
    [self createArraysForUI];
    
}

-(void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self.tableView reloadData];
}

- (void)insertNewObject:(id)sender {
    AppDelegate *appDelegate = (AppDelegate *)[UIApplication sharedApplication].delegate;
    NSPersistentContainer *persistentContainer = appDelegate.persistentContainer;
    
    NSManagedObjectContext *context = [self.fetchedResultsController managedObjectContext];
    
    NSError *error = nil;
    NSFetchRequest<Receipt *> *fetchReceiptsRequest = [Receipt fetchRequest];
    self.receipts = [persistentContainer.viewContext executeFetchRequest:fetchReceiptsRequest error:&error];
    error = nil;
    // Save the context.
        if (![context save:&error]) {
        // Replace this implementation with code to handle the error appropriately.
        // abort() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
        NSLog(@"Unresolved error %@, %@", error, error.userInfo);
        abort();
    }
}


#pragma mark - Table View
// TODO!!! from fetched results
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    NSLog(@"Will create %lu sections", self.arrayWithTagsAndReciepts.count);
    return self.arrayWithTagsAndReciepts.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [[self.arrayWithTagsAndReciepts objectAtIndex:section]count];
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    ReceiptTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cellId" forIndexPath:indexPath];

    cell.receipt = [self.arrayWithTagsAndReciepts[indexPath.section] objectAtIndex:indexPath.row];

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


//-(NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
    
   return self.arrayWithTagsAndReciepts[section].tag.tagName;
    
//}

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
    
    self.uniqueTags = [tagName valueForKeyPath:@"@distinctUnionOfObjects.self"];
    NSLog(@"uniqueTags: %@", self.uniqueTags);
    }
//TODO: Rename me!
-(void)createArraysForUI {
    NSMutableArray *receiptsWithFamilyTag = [NSMutableArray new];
    NSMutableArray *receiptsWithPersonalTag = [NSMutableArray new];
    NSMutableArray *receiptsWithBusinessTag = [NSMutableArray new];
    
    for (Receipt *receipt in self.receipts) {
        NSArray *tagsForThisReceipt = receipt.tag.allObjects;
        for (int i = 0; i < tagsForThisReceipt.count; i++) {
            Tag *tag = [tagsForThisReceipt objectAtIndex:i];
            if ([tag.tagName isEqualToString:@"Family"]) {
                [receiptsWithFamilyTag addObject:receipt];
            } else if ([tag.tagName isEqualToString:@"Personal"]) {
                [receiptsWithPersonalTag addObject:receipt];
            } else if ([tag.tagName isEqualToString:@"Business"]) {
                [receiptsWithBusinessTag addObject:receipt];
            }
        }
    }
    
    
    
    NSLog(@"receiptsWithFamilyTag count: %lu", receiptsWithFamilyTag.count);
    NSLog(@"receiptsWithPersonalTag count: %lo", receiptsWithPersonalTag.count);
    NSLog(@"receiptsWithBusinessTag count: %lu", receiptsWithBusinessTag.count);
    
    self.arrayWithTagsAndReciepts = @[receiptsWithFamilyTag, receiptsWithPersonalTag, receiptsWithBusinessTag];
    
}

@end
