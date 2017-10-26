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

@end

@implementation AddReceiptViewController

- (IBAction)addTag:(id)sender {
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
    
    receipt.note = self.noteField.text;
    NSLog(@"Saving %@ description", receipt.note);
    NSLog(@"receipt %@", receipt.description);

    [appDelegate saveContext];
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
