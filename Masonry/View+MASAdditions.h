//
//  UIView+MASAdditions.h
//  Masonry
//
//  Created by Jonas Budelmann on 20/07/13.
//  Copyright (c) 2013 cloudling. All rights reserved.
//

#import "MASUtilities.h"// 平台兼容和工具方法
#import "MASConstraintMaker.h"// 约束构建者
#import "MASViewAttribute.h"// mas封装layout 属性的类，其继承自NSObject
/* lzy170926注:
 这个类似是 view的分类。动态得给view类添加方法。
 */
/** 提供 约束构建者 block，还有用于创建 MASViewAttribute的简便方法，方法是 view + NSLayoutAttribute 对
 *	Provides constraint maker block
 *  and convience methods for creating MASViewAttribute which are view + NSLayoutAttribute pairs
 */
@interface MAS_VIEW (MASAdditions)

/**
 *	following properties return a new MASViewAttribute with current view and appropriate NSLayoutAttribute
 */
@property (nonatomic, strong, readonly) MASViewAttribute *mas_left;
@property (nonatomic, strong, readonly) MASViewAttribute *mas_top;
@property (nonatomic, strong, readonly) MASViewAttribute *mas_right;
@property (nonatomic, strong, readonly) MASViewAttribute *mas_bottom;
@property (nonatomic, strong, readonly) MASViewAttribute *mas_leading;
@property (nonatomic, strong, readonly) MASViewAttribute *mas_trailing;
@property (nonatomic, strong, readonly) MASViewAttribute *mas_width;
@property (nonatomic, strong, readonly) MASViewAttribute *mas_height;
@property (nonatomic, strong, readonly) MASViewAttribute *mas_centerX;
@property (nonatomic, strong, readonly) MASViewAttribute *mas_centerY;
@property (nonatomic, strong, readonly) MASViewAttribute *mas_baseline;
@property (nonatomic, strong, readonly) MASViewAttribute *(^mas_attribute)(NSLayoutAttribute attr);

// lzy170925注：下面两个属性只有在 iOS8.0及以上，tvOS9.0及以上，MAC OS 10.11及以上，才有
#if (__IPHONE_OS_VERSION_MIN_REQUIRED >= 80000) || (__TV_OS_VERSION_MIN_REQUIRED >= 9000) || (__MAC_OS_X_VERSION_MIN_REQUIRED >= 101100)

@property (nonatomic, strong, readonly) MASViewAttribute *mas_firstBaseline;
@property (nonatomic, strong, readonly) MASViewAttribute *mas_lastBaseline;

#endif
// lzy170925注：下面两个属性只有在 iOS8.0及以上，tvOS9.0及以上，
#if (__IPHONE_OS_VERSION_MIN_REQUIRED >= 80000) || (__TV_OS_VERSION_MIN_REQUIRED >= 9000)

@property (nonatomic, strong, readonly) MASViewAttribute *mas_leftMargin;
@property (nonatomic, strong, readonly) MASViewAttribute *mas_rightMargin;
@property (nonatomic, strong, readonly) MASViewAttribute *mas_topMargin;
@property (nonatomic, strong, readonly) MASViewAttribute *mas_bottomMargin;
@property (nonatomic, strong, readonly) MASViewAttribute *mas_leadingMargin;
@property (nonatomic, strong, readonly) MASViewAttribute *mas_trailingMargin;
@property (nonatomic, strong, readonly) MASViewAttribute *mas_centerXWithinMargins;
@property (nonatomic, strong, readonly) MASViewAttribute *mas_centerYWithinMargins;

#endif
// lzy170925注：下面两个属性只有在 iOS11.0及以上，tvOS11.0及以上。安全区域的适配
#if (__IPHONE_OS_VERSION_MIN_REQUIRED >= 110000) || (__TV_OS_VERSION_MIN_REQUIRED >= 110000)

@property (nonatomic, strong, readonly) MASViewAttribute *mas_safeAreaLayoutGuide;
@property (nonatomic, strong, readonly) MASViewAttribute *mas_safeAreaLayoutGuideTop;
@property (nonatomic, strong, readonly) MASViewAttribute *mas_safeAreaLayoutGuideBottom;
@property (nonatomic, strong, readonly) MASViewAttribute *mas_safeAreaLayoutGuideLeft;
@property (nonatomic, strong, readonly) MASViewAttribute *mas_safeAreaLayoutGuideRight;

#endif

/**关联这个view的key
 *	a key to associate with this view
 */
@property (nonatomic, strong) id mas_key;

/** 寻找 当前视图 和 指定视图，两个视图的 最近的 共同父视图
 *	Finds the closest common superview between this view and another view
 *
 *	@param	view	other view
 *
 *	@return	returns nil if common superview could not be found
 */
- (instancetype)mas_closestCommonSuperview:(MAS_VIEW *)view;

/** 为调用这个方法的视图，创建一个 『约束构建者』。里头定义的约束都将加到view上或者合适的父视图上。
 *  Creates a MASConstraintMaker with the callee view.
 *  Any constraints defined are added to the view or the appropriate superview once the block has finished executing
 *
 *  @param block scope within which you can build up the constraints which you wish to apply to the view.
 *
 *  @return Array of created MASConstraints
 */
- (NSArray *)mas_makeConstraints:(void(NS_NOESCAPE ^)(MASConstraintMaker *make))block;

/**里头定义的约束都将加到view上或者合适的父视图上。 没有的约束添加，有的约束按block中的进行更新
 *  Creates a MASConstraintMaker with the callee view.
 *  Any constraints defined are added to the view or the appropriate superview once the block has finished executing.
 *  If an existing constraint exists then it will be updated instead.
 *
 *  @param block scope within which you can build up the constraints which you wish to apply to the view.
 *
 *  @return Array of created/updated MASConstraints
 */
- (NSArray *)mas_updateConstraints:(void(NS_NOESCAPE ^)(MASConstraintMaker *make))block;

/** 清理掉之前添加在这个视图上的所有约束。里头定义的约束都将加到view上或者合适的父视图上。
 *  Creates a MASConstraintMaker with the callee view.
 *  Any constraints defined are added to the view or the appropriate superview once the block has finished executing.
 *  All constraints previously installed for the view will be removed.
 *
 *  @param block scope within which you can build up the constraints which you wish to apply to the view.
 *
 *  @return Array of created/updated MASConstraints
 */
- (NSArray *)mas_remakeConstraints:(void(NS_NOESCAPE ^)(MASConstraintMaker *make))block;

@end
