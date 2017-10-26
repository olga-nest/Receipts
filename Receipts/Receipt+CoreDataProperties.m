//
//  Receipt+CoreDataProperties.m
//  Receipts
//
//  Created by Olga on 10/26/17.
//  Copyright © 2017 Olga Nesterova. All rights reserved.
//
//

#import "Receipt+CoreDataProperties.h"

@implementation Receipt (CoreDataProperties)

+ (NSFetchRequest<Receipt *> *)fetchRequest {
	return [[NSFetchRequest alloc] initWithEntityName:@"Receipt"];
}

@dynamic amount;
@dynamic note;
@dynamic timeStamp;
@dynamic tag;

@end
