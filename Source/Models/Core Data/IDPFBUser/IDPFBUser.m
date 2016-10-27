//
//  DBUser.m
//  SuperUI
//
//  Created by Ievgen on 10/12/16.
//  Copyright © 2016 1mlndollarsasset. All rights reserved.
//

#import "IDPFBUser.h"

#import "IDPObservableObject.h"
#import "IDPImageModel.h"
#import "IDPFBFriendsArrayModel.h"

#import "IDPMacros.h"

@interface IDPFBUser ()
@property (nonatomic, strong)   IDPObservableObject     *targetObservableObject;


@end

@implementation IDPFBUser

@synthesize targetObservableObject = _targetObservableObject;
@synthesize friendsArray = _friendsArray;

@dynamic firstName;
@dynamic hometown;
@dynamic lastName;
@dynamic location;
@dynamic name;
@dynamic friends;
@dynamic images;
@dynamic profileImage;
@dynamic fullName;

#pragma mark - 
#pragma mark Initializations and Deallocation

- (NSManagedObject *)initWithEntity:(NSEntityDescription *)entity
     insertIntoManagedObjectContext:(NSManagedObjectContext *)context
{
    self = [super initWithEntity:entity insertIntoManagedObjectContext:context];
    self.targetObservableObject = [[IDPObservableObject alloc] initWithTarget:self];
    
    self.friendsArray = [[IDPFBFriendsArrayModel alloc] initWithContainerModel:self
                                                                  arrayKeyPath:kIDPFriendsArrayKey];
    
    return self;
}

#pragma mark -
#pragma mark Accessors

- (NSString *)fullName {
    return [NSString stringWithFormat:@"%@ %@", self.firstName, self.lastName];
}

- (IDPFBFriendsArrayModel *)friendsArray {
    return _friendsArray;
}

- (void)setFriendsArray:(IDPFBFriendsArrayModel *)friendsArray {
    if (_friendsArray != friendsArray) {
        _friendsArray = nil;
        
        _friendsArray = friendsArray;
    }
}

#pragma mark - 
#pragma mark NSObject

- (id)forwardingTargetForSelector:(SEL)selector {
    IDPObservableObject *target = self.targetObservableObject;
    
    return [target respondsToSelector:selector] ? target : nil;
}

- (BOOL)respondsToSelector:(SEL)selector {
    return [super respondsToSelector:selector] || [self.targetObservableObject respondsToSelector:selector];
}

#pragma mark -
#pragma mark IDPObservableObject

- (SEL)selectorForState:(NSUInteger)state {
    switch (state) {
        case IDPFBUserDidUnload:
            return @selector(userDidUnload:);
            
        case IDPFBUserDidFailLoading:
            return @selector(userDidFailLoading:);
            
        case IDPFBUserWillLoad:
            return @selector(userWillLoad:);
            
        case IDPFBUserDidLoadId:
            return @selector(userDidLoadId:);
            
        case IDPFBUserDidLoadFriends:
            return @selector(userDidLoadFriends:);
            
        case IDPFBUserDidLoadDetails:
            return @selector(userDidLoadDetails:);
            
        default:
            return [self.targetObservableObject selectorForState:state];
    }
}

@end
