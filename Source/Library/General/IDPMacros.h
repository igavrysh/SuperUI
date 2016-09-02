//
//  IDPMacro.h
//  iOSProject
//
//  Created by Ievgen on 8/2/16.
//  Copyright © 2016 1mlndollarsasset. All rights reserved.
//

#import "IDPCompilerMacros.h"

#define IDPEmpty

#define IDPDefineBaseViewProperty(propertyName, viewClass) \
    @property (nonatomic, readonly) viewClass     *propertyName;

#define IDPBaseViewGetterSynthesize(selector, viewClass) \
    - (viewClass *)selector { \
        if ([self isViewLoaded] && [self.view isKindOfClass:[viewClass class]]) { \
            return (viewClass *)self.view; \
        } \
        \
        return nil; \
    }

#define IDPViewControllerBaseViewProperty(viewControllerClass, propertyName, baseViewClass) \
    @interface viewControllerClass (__IDPPrivateBaseView) \
    IDPDefineBaseViewProperty(propertyName, baseViewClass); \
    \
    @end \
    \
    @implementation viewControllerClass (__IDPPrivateBaseView) \
    \
    @dynamic propertyName; \
    \
    IDPBaseViewGetterSynthesize(propertyName, baseViewClass); \
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
