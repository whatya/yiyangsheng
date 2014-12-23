//
//  CustomTextView.m
//  TVAnimationsGestures
//
//  Created by Bob Zhang on 14-3-9.
//  Copyright (c) 2014年 Apple Inc. All rights reserved.
//

#import "CustomTextView.h"

@implementation CustomTextView

- (void)setHighlighted:(BOOL)highlight
{
    
    // Adjust the text color based on highlighted state.
    if (highlight != _highlighted) {
        self.textColor = highlight ? [UIColor whiteColor] : [UIColor blackColor];
        _highlighted = highlight;
    }
}

@end
