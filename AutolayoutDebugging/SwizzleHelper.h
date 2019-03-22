//
//  SwizzleHelper.h
//  AutolayoutDebugging
//
//  Created by von Webel, Max Florian on 21.03.19.
//  Copyright © 2019 von Webel, Max Florian. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface SwizzleHelper : NSObject

+ (void)swizzle:(Class)swizzleClass;

@end

NS_ASSUME_NONNULL_END
