//
//  AddReceiptViewController.m
//  Receipts
//
//  Created by Olga on 10/26/17.
//  Copyright © 2017 Olga Nesterova. All rights reserved.
//

#import "AddReceiptViewController.h"
#import "AppDelegate.h"

@interface AddReceiptViewController ()

@property (weak, nonatomic) IBOutlet UILabel *addNewReceiptControllerTitle;
@property (weak, nonatomic) IBOutlet UILabel *categoryLabel;
@property (weak, nonatomic) IBOutlet UITextField *amountField;
@property (weak, nonatomic) IBOutlet UITextField *noteField;
@property (weak, nonatomic) IBOutlet UIDatePicker *datePicker;

@property (nonatomic) NSMutableSet *tags;

@end

@implementation AddReceiptViewController

- (IBAction)addTag:(UIButton *)sender {
//    NSMutableSet *tempSet = [NSMutableSet new];
    
    AppDelegate *appDelegate = (AppDelegate *)[UIApplication sharedApplication].delegate;
    NSPersistentContainer *persistentContainer = appDelegate.persistentContainer;
    
    Tag *tag = [[Tag alloc]initWithContext:persistentContainer.viewContext];
    tag.tagName = sender.titleLabel.text;
    NSLog(@"Adding %@ tag to tag set", tag.tagName);
    
    [self.tags addObject:tag];
//    self.tags = tempSet;
}

- (IBAction)cancel:(id)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (IBAction)saveReceipt:(id)sender {
    AppDelegate *appDelegate = (AppDelegate *)[UIApplication sharedApplication].delegate;
    NSPersistentContainer *persistentContainer = appDelegate.persistentContainer;
    
    Receipt *receipt = [[Receipt alloc] initWithContext:persistentContainer.viewContext];
    
    receipt.amount = [self.amountField.text floatValue];
    NSLog(@"Saving %f amount", receipt.amount);
    
    receipt.timeStamp = [self.datePicker date];
    NSLog(@"Saving %@ date", receipt.timeStamp);
    
    receipt.note = self.noteField.text;
    NSLog(@"Saving %@ description", receipt.note);
    NSLog(@"receipt %@", receipt.description);
    
    [receipt addTag:self.tags];
    NSLog(@"Number of tags for this receipt %lu", (unsigned long)self.tags.count);
    
    [self.tags removeAllObjects];
    
    [appDelegate saveContext];
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    if (!self.tags) {
    self.tags = [NSMutableSet new];
    }
}



/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
