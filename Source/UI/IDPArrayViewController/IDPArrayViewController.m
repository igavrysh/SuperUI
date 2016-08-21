//
//  IDPArrayViewController.m
//  SuperUI
//
//  Created by Ievgen on 8/11/16.
//  Copyright © 2016 1mlndollarsasset. All rights reserved.
//

#import "IDPArrayViewController.h"

#import "IDPMacro.h"
#import "IDPArrayView.h"
#import "IDPUserCell.h"
#import "IDPUser.h"
#import "IDPArrayModel.h"
#import "IDPBlockObservationController.h"
#import "IDPArrayChangeModel.h"

#import "UITableView+IDPExtensions.h"

IDPViewControllerBaseViewProperty(IDPArrayViewController, arrayView, IDPArrayView)

@interface IDPArrayViewController ()
@property (nonatomic, strong)                               IDPBlockObservationController   *observer;
@property (nonatomic, assign, getter=shouldUpdateModel)     BOOL                            updateModel;

- (void)prepareObserver:(IDPBlockObservationController *)observer;

@end

@implementation IDPArrayViewController

#pragma mark -
#pragma mark Accessors

- (void)setArrayModel:(IDPArrayModel *)arrayModel {
    if (_arrayModel != arrayModel) {
        _arrayModel = arrayModel;
        
        self.observer = [_arrayModel blockObservationControllerWithObserver:self];
        
        if (self.isViewLoaded) {
            [self.arrayModel load];
        } else {
            self.updateModel = YES;
        }
    }
}

- (void)setObserver:(IDPBlockObservationController *)observer {
    if (observer != _observer) {
        _observer = observer;
        
        [self prepareObserver:observer];
    }
}

#pragma mark -
#pragma mark View Lifecycle

- (void)viewDidLoad {
    [super viewDidLoad];
    
    if ([self shouldUpdateModel]) {
        [self.arrayModel load];
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}


#pragma mark -
#pragma mark Private Methods

- (void)prepareObserver:(IDPBlockObservationController *)observer {
    IDPWeakify(self);
    
    id handler = ^(IDPBlockObservationController *controller, IDPArrayChangeModel *changeModel) {
        
        IDPStrongifyAndReturnIfNil(self);
        
        NSLog(@"Model Updated");
        
        [self.arrayView reload];
        //[self.arrayView applyChangeModel:changeModel];
        /*
         void(^block)(void) = ^ {
         IDPStrongifyAndReturnIfNil(self);
         
         IDPArrayModel *model = controller.observableObject;
         self.contentImageView.image = model.image;
         };
         
         if ([NSThread isMainThread]) {
         block();
         } else {
         dispatch_sync(dispatch_get_main_queue(), block);
         }
         */
    };
    
    [observer setHandler:handler forState:IDPArrayModelUpdated];
    
    handler = ^(IDPBlockObservationController *controller, id userInfo) {
        IDPStrongifyAndReturnIfNil(self);
        
        NSLog(@"Model Loaded");
        
        [self.arrayView reload];
    };
    
    [observer setHandler:handler forState:IDPArrayModelLoaded];
}

#pragma mark -
#pragma mark UITableViewDataSource

- (NSInteger)   tableView:(UITableView *)tableView
    numberOfRowsInSection:(NSInteger)section
{
    return self.arrayModel.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView
         cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    IDPUserCell *cell = [tableView cellWithClass:[IDPUserCell class]];
    
    cell.user = self.arrayModel[indexPath.row];
    
    return cell;
}

#pragma mark -
#pragma mark UITableViewDelegate

- (void)    tableView:(UITableView *)tableView
 didEndDisplayingCell:(IDPUserCell *)cell
    forRowAtIndexPath:(NSIndexPath *)indexPath
{
    
}

- (IBAction)onEditButton:(id)sender {
}

- (IBAction)onAddButton:(id)sender {
    [self.arrayModel insertObject:[IDPUser user] atIndex:0];
}
@end
