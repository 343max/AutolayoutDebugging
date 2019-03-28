//
//  ViewController.m
//  AutolayoutDebugging
//
//  Created by von Webel, Max Florian on 21.03.19.
//  Copyright © 2019 von Webel, Max Florian. All rights reserved.
//

#import "ViewController.h"

#import "UIView+Debugging.h"
#import "SwizzleHelper.h"

@interface ViewController ()

@property (weak, nonatomic) UILabel *label;
@property (weak, nonatomic) IBOutlet UISwitch *aSwitch;

@end

@interface MyView : UILabel

@property (strong) NSMutableArray *bts;

@end

@implementation MyView

//- (NSString *)text
//{
//    if (!_bts) _bts = [[NSMutableArray alloc] init];
//
//    NSLog(@"%@", [NSThread callStackSymbols]);
//
////    [_bts addObject:[NSThread callStackSymbols]];
//
//    return @"DEBUG!!!!!!";
//}
//
//- (void)setText:(NSString *)text
//{
//    [super setText:@"xxxxxxxx!!!!"];
//}

//
//- (NSString *)_layoutDebuggingTitle
//{
//    return @"DEBUG!";
//}

//- (NSString *)description
//{
//    return @"DEBUGDESCRIPTION!!!!";
//}hopp

@end

@interface UILabel_swizzled : NSObject
@end

@implementation UILabel_swizzled

- (NSString *)swizzled_text {
  return [NSString stringWithFormat:@"!%@!", [self swizzled_text]];
}

@end

//@interface DebugHierarchyTargetHub_swizzled : NSObject
//@end
//
//@implementation DebugHierarchyTargetHub_swizzled
//
//- (void)swizzled_performRequest:(id)request error:(NSError **)error {
//    NSLog(@"request: %@", request);
//    [self swizzled_performRequest:request error:error];
//}
//
//@end

@interface DebugHierarchyTargetHub_swizzled : NSObject
@end

@implementation DebugHierarchyTargetHub_swizzled

- (id)swizzled_performRequest:(id)arg1 error:(id *)arg2
{
  NSLog(@"%@", arg1);
  id response = [self swizzled_performRequest:arg1 error:arg2];
  //    NSLog(@"%@", response);
  return response;
}

//- (id)swizzled_performRequestWithRequestInBase64:(id)base64
//{
////    NSLog(@"base64: %@", base64);
//
//    NSData *data = [[NSData alloc] initWithBase64EncodedString:base64 options:0];
//    NSString *json = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
//
//    NSLog(@"request: %@", json);
//
//    id result = [self swizzled_performRequestWithRequestInBase64:base64];
//
//    NSLog(@"response: %@", result);
//
//    return result;
//}

@end

//
//DebugHierarchyTargetHub performRequest:error:

@interface DebugHierarchyPropertyAction_swizzled : NSObject
@end

@implementation DebugHierarchyPropertyAction_swizzled

- (void)swizzled__fetchValuesForPropertiesWithNames:(id)arg1 onObject:(id)arg2 inContext:(id)arg3
{
  //    NSLog(@"%@, %@, %@", arg1, arg2, arg3);
  [self swizzled__fetchValuesForPropertiesWithNames:arg1 onObject:arg2 inContext:arg3];
}

- (void)swizzled_setPropertyNames:(NSArray *)arg1
{
  NSLog(@"propertyNames: %@", arg1);
  if ([arg1 isEqualToArray:@[ @"dbgFormattedDisplayName" ]]) {
    NSLog(@"%@", [NSThread callStackSymbols]);
  }
  [self swizzled_setPropertyNames:arg1];
}

@end

@interface DebugHierarchyRequestExecutionContext_swizzled : NSObject
@end

@implementation DebugHierarchyRequestExecutionContext_swizzled

- (void)swizzled_addProperties:(NSArray *)properties toObject:(id)arg2 {
  //    if ([arg2 isKindOfClass:[UILabel class]]) {
  //        NSLog(@"properites: %@", properties);
  //        NSLog(@"%@", [properties.firstObject class]);
  //    }
  if (properties.count == 1) {
    NSMutableDictionary *dict = [properties.firstObject mutableCopy];
    if ([dict[@"propertyName"] isEqualToString:@"dbgFormattedDisplayName"]) {
      dict[@"propertyValue"] = @"XXXXXXXXXXXXXXXXX";
      NSLog(@"%@", [NSThread callStackSymbols]);
    }
    properties = @[ dict ];
    
    NSLog(@"%@", [NSThread callStackSymbols]);
  }
  [self swizzled_addProperties:properties toObject:arg2];
}

@end

@interface CALayer_swizzled : NSObject
@end

@implementation CALayer_swizzled

- (NSString *)swizzled_debugDescription
{
  NSString *result = [self swizzled_debugDescription];
  NSLog(@"swizzled_debugDescription: %@", result);
  return result;
}

@end

@implementation ViewController

- (void)viewDidLoad {
  [super viewDidLoad];
  
  [UIView swizzleViewHierarchyDisplayName];
  
  UILabel *label = [[UILabel alloc] init];
  label.text = @"xxxxxxxx";
  
  [self.view addSubview:(id)label];
  
  MyView *view = [[MyView alloc] init];
  view.text = @"this is suppsed to be some text";
  [self.view addSubview:view];
  _label = view;
  
  self.aSwitch.viewHierarchyDisplayName = @"👋🌎";
  
  NSLog(@"%@", view.text);
  
  [NSTimer scheduledTimerWithTimeInterval:1 repeats:YES block:^(NSTimer * _Nonnull timer) {
    if ([view.bts count]) {
      NSLog(@"%@", view.bts);
      view.bts = [[NSMutableArray alloc] init];
    }
  }];
}

- (void)viewDidAppear:(BOOL)animated {
  [super viewDidAppear:animated];
}

@end
