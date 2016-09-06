//
//  IDPMacro.h
//  iOSProject
//
//  Created by Ievgen on 8/2/16.
//  Copyright © 2016 1mlndollarsasset. All rights reserved.
//

#import "IDPCompilerMacros.h"

#define kIDPModelObjectsKey(key)    static NSString * const key = @#key

#define IDPEmpty

#define IDPDefineBaseViewProperty(viewClass, propertyName) \
    @property (nonatomic, readonly) viewClass     *propertyName;

#define IDPBaseViewGetterSynthesize(viewClass, propertyName) \
    @dynamic propertyName; \
    \
    - (viewClass *)propertyName { \
        if ([self isViewLoaded] && [self.view isKindOfClass:[viewClass class]]) { \
            return (viewClass *)self.view; \
        } \
        \
        return nil; \
    }

#define IDPViewControllerBaseViewProperty(viewControllerClass, baseViewClass, propertyName) \
    @interface viewControllerClass (__IDPPrivateBaseView) \
    IDPDefineBaseViewProperty(baseViewClass, propertyName); \
    \
    @end \
    \
    @implementation viewControllerClass (__IDPPrivateBaseView) \
    \
    IDPBaseViewGetterSynthesize(baseViewClass, propertyName); \
    \
    @end \

#define IDPWeakify(variable) \
    __weak __typeof(variable) __IDPWeakified_##variable = variable;

#define IDPPerformBlock(block, ...) \
    if (block) { \
        block(__VA_ARGS__); \
    } \

#define IDPPrintMethod NSLog(@"%@ -> %@", NSStringFromClass([self class]), NSStringFromSelector(_cmd))

// you should only call this method after you called weakify for the same variable
#define IDPStrongify(variable) \
    IDPClangDiagnosticPushExpression("clang diagnostic ignored \"-Wshadow\""); \
    __strong __typeof(variable) variable = __IDPWeakified_##variable; \
    IDPClangDiagnosticPopExpression;

#define IDPStrongifyAndReturnIfNil(variable) \
    IDPStrongifyAndReturnResultIfNil(variable, IDPEmpty) \

#define IDPStrongifyAndReturnNilIfNil(variable) \
    IDPStrongifyAndReturnResultIfNil(variable, nil)

#define IDPStrongifyAndReturnResultIfNil(variable, result) \
    IDPStrongify(variable); \
    if (!variable) { \
        return result; \
    } \
