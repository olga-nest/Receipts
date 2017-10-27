//
//  ReceiptTableViewCell.h
//  Receipts
//
//  Created by Olga on 10/27/17.
//  Copyright © 2017 Olga Nesterova. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Receipt+CoreDataClass.h"

@interface ReceiptTableViewCell : UITableViewCell

@property (nonatomic, strong) Receipt *receipt;

@end
