//
//  IDPFBContext.m
//  SuperUI
//
//  Created by Ievgen on 9/27/16.
//  Copyright © 2016 1mlndollarsasset. All rights reserved.
//

#import <FBSDKCoreKit/FBSDKCoreKit.h>
#import <FBSDKLoginKit/FBSDKLoginKit.h>

#import "IDPFBContext.h"

#include "IDPModel.h"

#import "IDPJSONAdapter.h"

#import "IDPMacros.h"

@interface IDPFBContext ()
@property (nonatomic, strong) FBSDKGraphRequestConnection   *connection;

@end

@implementation IDPFBContext

@dynamic graphPath;
@dynamic requestParameters;

#pragma mark -
#pragma mark Initializations and Deallocations

- (void)dealloc {
    self.connection = nil;
}

#pragma mark - 
#pragma mark Accessors

- (NSString *)graphPath {
    return nil;
}

- (NSDictionary *)requestParameters {
    return nil;
}

- (void)setConnection:(FBSDKGraphRequestConnection *)connection {
    if (_connection != connection) {
        [_connection cancel];
        
        _connection = connection;
    }
}

#pragma mark -
#pragma mark Public

- (void)load {    
    IDPWeakify(self);
    id handler = ^(FBSDKGraphRequestConnection *connection,
                   id<IDPJSONAdapter> result,
                   NSError *error)
    {
        IDPStrongify(self);
        
        if (!error) {
            [self fillWithResult:[result JSONRepresentation]];
        } else {
            [self didFailLoadingFromInternet:error];
        }
    };
    
    FBSDKGraphRequest *request = [[FBSDKGraphRequest alloc] initWithGraphPath:self.graphPath
                                                                   parameters:self.requestParameters
                                                                   HTTPMethod:self.httpMethod];
    
    self.connection = [request startWithCompletionHandler:handler];
}

- (void)fillWithResult:(id)result {
}

- (void)didFailLoadingFromInternet:(NSError *)error {
    IDPModel *model = self.model;
    
    model.state = IDPModelDidFailLoading;
}

- (NSString *)httpMethod {
    return nil;
}

- (void)cancel {
    @synchronized(self) {
        self.connection = nil;
    }
}

@end

