// Copyright Max von Webel. All Rights Reserved.

#import "UIView+Debugging.h"

#import <objc/runtime.h>

#import "SwizzleHelper.h"

@interface UIView_swizzled : NSObject
@end

@implementation UIView (Debugging)

+ (void)swizzleViewHierarchyDisplayName
{
  static dispatch_once_t onceToken;
  dispatch_once(&onceToken, ^{
    [SwizzleHelper swizzle:[UIView_swizzled class]];
  });
}

- (void)setViewHierarchyDisplayName:(NSString *)viewHierarchyDisplayName
{
  objc_setAssociatedObject(self, @selector(viewHierarchyDisplayName), viewHierarchyDisplayName, OBJC_ASSOCIATION_COPY_NONATOMIC);
}

- (NSString *)viewHierarchyDisplayName
{
  return objc_getAssociatedObject(self, @selector(viewHierarchyDisplayName));
}

@end

@implementation UIView_swizzled

- (NSString *)swizzled___dbg_formattedDisplayName
{
  return ((UIView *)self).viewHierarchyDisplayName ?: [self swizzled___dbg_formattedDisplayName];
}

@end
