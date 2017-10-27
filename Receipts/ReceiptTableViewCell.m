//
//  ReceiptTableViewCell.m
//  Receipts
//
//  Created by Olga on 10/27/17.
//  Copyright © 2017 Olga Nesterova. All rights reserved.
//

#import "ReceiptTableViewCell.h"

@implementation ReceiptTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)setReceipt:(Receipt *)receipt {
    if (_receipt != receipt) {
        _receipt = receipt;
    }
    [self configureCell];
}

- (void)configureCell {
   
    if (self.receipt) {
        self.textLabel.text = self.receipt.note;
        self.detailTextLabel.text = [NSString stringWithFormat:@"Amount: %.02f", self.receipt.amount];
    }
}

@end
