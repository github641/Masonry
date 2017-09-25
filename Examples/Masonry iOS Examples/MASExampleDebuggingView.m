//
//  MASExampleDebuggingView.m
//  Masonry iOS Examples
//
//  Created by Jonas Budelmann on 3/08/13.
//  Copyright (c) 2013 Jonas Budelmann. All rights reserved.
//

#import "MASExampleDebuggingView.h"

@implementation MASExampleDebuggingView

- (id)init {
    self = [super init];
    if (!self) return nil;

    UIView *greenView = UIView.new;
    greenView.backgroundColor = UIColor.greenColor;
    greenView.layer.borderColor = UIColor.blackColor.CGColor;
    greenView.layer.borderWidth = 2;
    [self addSubview:greenView];

    UIView *redView = UIView.new;
    redView.backgroundColor = UIColor.redColor;
    redView.layer.borderColor = UIColor.blackColor.CGColor;
    redView.layer.borderWidth = 2;
    [self addSubview:redView];

    UILabel *blueView = UILabel.new;
    blueView.backgroundColor = UIColor.blueColor;
    blueView.numberOfLines = 3;
    blueView.textAlignment = NSTextAlignmentCenter;
    blueView.font = [UIFont systemFontOfSize:24];
    blueView.textColor = UIColor.whiteColor;
    blueView.text = @"this should look broken! check your console!";
    blueView.layer.borderColor = UIColor.blackColor.CGColor;
    blueView.layer.borderWidth = 2;
    [self addSubview:blueView];

    UIView *superview = self;
    int padding = 10;

    //you can attach debug keys to views like so:
//    greenView.mas_key = @"greenView";
//    redView.mas_key = @"redView";
//    blueView.mas_key = @"blueView";
//    superview.mas_key = @"superview";

    //OR you can attach keys automagically like so:
    MASAttachKeys(greenView, redView, blueView, superview);

    [blueView mas_makeConstraints:^(MASConstraintMaker *make) {
        //you can also attach debug keys to constaints
        make.edges.equalTo(@1).key(@"ConflictingConstraint"); //composite constraint keys will be indexed
        make.height.greaterThanOrEqualTo(@5000).key(@"ConstantConstraint");

        make.top.equalTo(greenView.mas_bottom).offset(padding);
        make.left.equalTo(superview.mas_left).offset(padding);
        make.bottom.equalTo(superview.mas_bottom).offset(-padding).key(@"BottomConstraint");
        make.right.equalTo(superview.mas_right).offset(-padding);
        make.height.equalTo(greenView.mas_height);
        make.height.equalTo(redView.mas_height).key(@340954); //anything can be a key
    }];
    
    [greenView makeConstraints:^(MASConstraintMaker *make) {
        make.top.greaterThanOrEqualTo(superview.top).offset(padding);
        make.left.equalTo(superview.left).offset(padding);
        make.bottom.equalTo(blueView.top).offset(-padding);
        make.right.equalTo(redView.left).offset(-padding);
        make.width.equalTo(redView.width);

        make.height.equalTo(redView.height);
        make.height.equalTo(blueView.height);
    }];

    //with is semantic and option
    [redView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(superview.mas_top).with.offset(padding);
        make.left.equalTo(greenView.mas_right).offset(padding);
        make.bottom.equalTo(blueView.mas_top).offset(-padding);
        make.right.equalTo(superview.mas_right).offset(-padding);
        make.width.equalTo(greenView.mas_width);

        make.height.equalTo(@[greenView, blueView]);
    }];
    
    /* lzy170921注:
     2017-09-21 09:32:46.615 Masonry iOS Examples[2094:44649] Simulator user has requested new graphics quality: 10
     2017-09-21 09:32:55.153081+0800 Masonry iOS Examples[2094:44649] [LayoutConstraints] Unable to simultaneously satisfy constraints.
     Probably at least one of the constraints in the following list is one you don't want.
     Try this:
     (1) look at each constraint and try to figure out which you don't expect;
     (2) find the code that added the unwanted constraint or constraints and fix it.
     (
     "<MASLayoutConstraint:ConflictingConstraint[0] UILabel:blueView.left == MASExampleDebuggingView:superview.left + 1>",
     "<MASLayoutConstraint:0x6000000a4bc0 UILabel:blueView.left == MASExampleDebuggingView:superview.left + 10>"
     )
     
     Will attempt to recover by breaking constraint
     <MASLayoutConstraint:0x6000000a4bc0 UILabel:blueView.left == MASExampleDebuggingView:superview.left + 10>
     
     Make a symbolic breakpoint at UIViewAlertForUnsatisfiableConstraints to catch this in the debugger.
     The methods in the UIConstraintBasedLayoutDebugging category on UIView listed in <UIKit/UIView.h> may also be helpful.
     2017-09-21 09:32:55.153835+0800 Masonry iOS Examples[2094:44649] [LayoutConstraints] Unable to simultaneously satisfy constraints.
     Probably at least one of the constraints in the following list is one you don't want.
     Try this:
     (1) look at each constraint and try to figure out which you don't expect;
     (2) find the code that added the unwanted constraint or constraints and fix it.
     (
     "<MASLayoutConstraint:ConflictingConstraint[3] UILabel:blueView.bottom == MASExampleDebuggingView:superview.bottom + 1>",
     "<MASLayoutConstraint:BottomConstraint UILabel:blueView.bottom == MASExampleDebuggingView:superview.bottom - 10>"
     )
     
     Will attempt to recover by breaking constraint
     <MASLayoutConstraint:ConflictingConstraint[3] UILabel:blueView.bottom == MASExampleDebuggingView:superview.bottom + 1>
     
     Make a symbolic breakpoint at UIViewAlertForUnsatisfiableConstraints to catch this in the debugger.
     The methods in the UIConstraintBasedLayoutDebugging category on UIView listed in <UIKit/UIView.h> may also be helpful.
     2017-09-21 09:32:55.154599+0800 Masonry iOS Examples[2094:44649] [LayoutConstraints] Unable to simultaneously satisfy constraints.
     Probably at least one of the constraints in the following list is one you don't want.
     Try this:
     (1) look at each constraint and try to figure out which you don't expect;
     (2) find the code that added the unwanted constraint or constraints and fix it.
     (
     "<MASLayoutConstraint:ConflictingConstraint[1] UILabel:blueView.right == MASExampleDebuggingView:superview.right + 1>",
     "<MASLayoutConstraint:0x6000000a4b00 UILabel:blueView.right == MASExampleDebuggingView:superview.right - 10>"
     )
     
     Will attempt to recover by breaking constraint
     <MASLayoutConstraint:ConflictingConstraint[1] UILabel:blueView.right == MASExampleDebuggingView:superview.right + 1>
     
     Make a symbolic breakpoint at UIViewAlertForUnsatisfiableConstraints to catch this in the debugger.
     The methods in the UIConstraintBasedLayoutDebugging category on UIView listed in <UIKit/UIView.h> may also be helpful.
     2017-09-21 09:32:55.155357+0800 Masonry iOS Examples[2094:44649] [LayoutConstraints] Unable to simultaneously satisfy constraints.
     Probably at least one of the constraints in the following list is one you don't want.
     Try this:
     (1) look at each constraint and try to figure out which you don't expect;
     (2) find the code that added the unwanted constraint or constraints and fix it.
     (
     "<MASLayoutConstraint:ConstantConstraint UILabel:blueView.height >= 5000>",
     "<MASLayoutConstraint:ConflictingConstraint[2] UILabel:blueView.top == MASExampleDebuggingView:superview.top + 1>",
     "<MASLayoutConstraint:0x6000000a49e0 UILabel:blueView.top == UIView:greenView.bottom + 10>",
     "<MASLayoutConstraint:0x6000000a4c80 UILabel:blueView.height == UIView:greenView.height>",
     "<MASLayoutConstraint:0x6000000a5280 UIView:greenView.top >= MASExampleDebuggingView:superview.top + 10>"
     )
     
     Will attempt to recover by breaking constraint
     <MASLayoutConstraint:ConstantConstraint UILabel:blueView.height >= 5000>
     
     Make a symbolic breakpoint at UIViewAlertForUnsatisfiableConstraints to catch this in the debugger.
     The methods in the UIConstraintBasedLayoutDebugging category on UIView listed in <UIKit/UIView.h> may also be helpful.
     2017-09-21 09:32:55.157122+0800 Masonry iOS Examples[2094:44649] [LayoutConstraints] Unable to simultaneously satisfy constraints.
     Probably at least one of the constraints in the following list is one you don't want.
     Try this:
     (1) look at each constraint and try to figure out which you don't expect;
     (2) find the code that added the unwanted constraint or constraints and fix it.
     (
     "<MASLayoutConstraint:ConflictingConstraint[2] UILabel:blueView.top == MASExampleDebuggingView:superview.top + 1>",
     "<MASLayoutConstraint:0x6000000a49e0 UILabel:blueView.top == UIView:greenView.bottom + 10>",
     "<MASLayoutConstraint:0x6000000a4c80 UILabel:blueView.height == UIView:greenView.height>",
     "<MASLayoutConstraint:0x6000000a5280 UIView:greenView.top >= MASExampleDebuggingView:superview.top + 10>"
     )
     
     Will attempt to recover by breaking constraint
     <MASLayoutConstraint:0x6000000a49e0 UILabel:blueView.top == UIView:greenView.bottom + 10>
     
     Make a symbolic breakpoint at UIViewAlertForUnsatisfiableConstraints to catch this in the debugger.
     The methods in the UIConstraintBasedLayoutDebugging category on UIView listed in <UIKit/UIView.h> may also be helpful.
     2017-09-21 09:32:55.158319+0800 Masonry iOS Examples[2094:44649] [LayoutConstraints] Unable to simultaneously satisfy constraints.
     Probably at least one of the constraints in the following list is one you don't want.
     Try this:
     (1) look at each constraint and try to figure out which you don't expect;
     (2) find the code that added the unwanted constraint or constraints and fix it.
     (
     "<MASLayoutConstraint:ConflictingConstraint[2] UILabel:blueView.top == MASExampleDebuggingView:superview.top + 1>",
     "<MASLayoutConstraint:0x6000000a4c80 UILabel:blueView.height == UIView:greenView.height>",
     "<MASLayoutConstraint:0x6000000a5280 UIView:greenView.top >= MASExampleDebuggingView:superview.top + 10>",
     "<MASLayoutConstraint:0x6000000a5340 UIView:greenView.bottom == UILabel:blueView.top - 10>"
     )
     
     Will attempt to recover by breaking constraint
     <MASLayoutConstraint:0x6000000a5340 UIView:greenView.bottom == UILabel:blueView.top - 10>
     
     Make a symbolic breakpoint at UIViewAlertForUnsatisfiableConstraints to catch this in the debugger.
     The methods in the UIConstraintBasedLayoutDebugging category on UIView listed in <UIKit/UIView.h> may also be helpful.
     2017-09-21 09:32:55.159212+0800 Masonry iOS Examples[2094:44649] [LayoutConstraints] Unable to simultaneously satisfy constraints.
     Probably at least one of the constraints in the following list is one you don't want.
     Try this:
     (1) look at each constraint and try to figure out which you don't expect;
     (2) find the code that added the unwanted constraint or constraints and fix it.
     (
     "<MASLayoutConstraint:ConflictingConstraint[2] UILabel:blueView.top == MASExampleDebuggingView:superview.top + 1>",
     "<MASLayoutConstraint:340954 UILabel:blueView.height == UIView:redView.height>",
     "<MASLayoutConstraint:0x6000000a5820 UIView:redView.top == MASExampleDebuggingView:superview.top + 10>",
     "<MASLayoutConstraint:0x6000000a58e0 UIView:redView.bottom == UILabel:blueView.top - 10>"
     )
     
     Will attempt to recover by breaking constraint 
     <MASLayoutConstraint:0x6000000a58e0 UIView:redView.bottom == UILabel:blueView.top - 10>
     
     Make a symbolic breakpoint at UIViewAlertForUnsatisfiableConstraints to catch this in the debugger.
     The methods in the UIConstraintBasedLayoutDebugging category on UIView listed in <UIKit/UIView.h> may also be helpful.
     */
    
    
    return self;
}

@end
