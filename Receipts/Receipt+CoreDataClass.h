//
//  Receipt+CoreDataClass.h
//  Receipts
//
//  Created by Olga on 10/26/17.
//  Copyright © 2017 Olga Nesterova. All rights reserved.
//
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class Tag;

NS_ASSUME_NONNULL_BEGIN

@interface Receipt : NSManagedObject

@end

NS_ASSUME_NONNULL_END

#import "Receipt+CoreDataProperties.h"
