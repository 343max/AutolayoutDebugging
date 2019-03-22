//
//  UIView+Debugging.h
//  gdsfhjfjdfsagh
//
//  Created by von Webel, Max Florian on 21.03.19.
//  Copyright © 2019 von Webel, Max Florian. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIView (Debugging)

- (void)_setLayoutDebuggingIdentifier:(NSString *)identifier;
- (NSString *)_layoutDebuggingTitle;
- (NSString *)_focusDebugOverlayParentView;

- (NSString *)_autolayoutTrace;

@end


@interface UILabel (Debugging)

- (void)_setDrawsDebugBaselines:(BOOL)enabled;

@end
