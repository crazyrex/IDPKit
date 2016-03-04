//
//  IDPLocking.h
//  iOS
//
//  Created by Oleksa 'trimm' Korin on 3/4/16.
//  Copyright © 2016 IDAP Group. All rights reserved.
//

#import "IDPLocking.h"

#import "IDPReturnMacros.h"

static
void IDPPerformBlockWithLock(id<NSLocking> lock, IDPLockedBlock block) {
    IDPReturnIfNil(block);
    
    [lock lock];
    block();
    [lock unlock];
}

#define IDPSynthesizeLockingImplementation(class) \
    @implementation class (__IDPLockingExtensions__##class) \
    \
    - (void)performBlock:(IDPLockedBlock)block { \
        IDPPerformBlockWithLock(self, block); \
    } \
    \
    @end

IDPSynthesizeLockingImplementation(NSLock)
IDPSynthesizeLockingImplementation(NSRecursiveLock)
IDPSynthesizeLockingImplementation(NSCondition)
IDPSynthesizeLockingImplementation(NSConditionLock)

#undef IDPSynthesizeLockingImplementation
