//
//  IDPCoreDataArrayModel.h
//  SuperUI
//
//  Created by Ievgen on 10/20/16.
//  Copyright © 2016 1mlndollarsasset. All rights reserved.
//

#import <CoreData/CoreData.h>

#import "IDPArrayModel.h"

@interface IDPCoreDataArrayModel : IDPArrayModel <NSFetchedResultsControllerDelegate>

- (instancetype)initWithContainerModel:(NSManagedObject *)containerModel
                          arrayKeyPath:(NSString *)arraykeyPath;

- (NSPredicate *)predicate;

- (NSArray *)sortDescriptors;

@end
