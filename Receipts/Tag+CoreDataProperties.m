//
//  Tag+CoreDataProperties.m
//  Receipts
//
//  Created by Olga on 10/26/17.
//  Copyright © 2017 Olga Nesterova. All rights reserved.
//
//

#import "Tag+CoreDataProperties.h"

@implementation Tag (CoreDataProperties)

+ (NSFetchRequest<Tag *> *)fetchRequest {
	return [[NSFetchRequest alloc] initWithEntityName:@"Tag"];
}

@dynamic tagName;
@dynamic receipt;

@end
