// Copyright Max von Webel. All Rights Reserved.

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UIView (Debugging)

+ (void)swizzleViewHierarchyDisplayName;

@property (strong, nonatomic) NSString *viewHierarchyDisplayName;

@end

NS_ASSUME_NONNULL_END
