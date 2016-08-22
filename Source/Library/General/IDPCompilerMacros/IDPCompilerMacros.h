//
//  IDPCompilerMacro.h
//  iOSProject
//
//  Created by Ievgen on 8/9/16.
//  Copyright © 2016 1mlndollarsasset. All rights reserved.
//

#define IDPClnagDiagnosticPush _Pragma("clang diagnostic push")
#define IDPClangDiagnosticPop _Pragma("clang diagnostic pop")

#define IDPClangDiagnosticPushExpression(key) \
    IDPClnagDiagnosticPush; \
    _Pragma(key)

#define IDPClangDiagnosticPopExpression IDPClangDiagnosticPop


