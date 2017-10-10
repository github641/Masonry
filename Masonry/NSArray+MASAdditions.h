//
//  NSArray+MASAdditions.h
//
//
//  Created by Daniel Hammond on 11/26/13.
//
//
/* lzy171010注:
 数组元素，统一处理约束的分类。
 */

#import "MASUtilities.h"
#import "MASConstraintMaker.h"
#import "MASViewAttribute.h"

// lzy170927注：定义了水平和垂直分发的宏
typedef NS_ENUM(NSUInteger, MASAxisType) {
    MASAxisTypeHorizontal,
    MASAxisTypeVertical
};

@interface NSArray (MASAdditions)

/**为调用这个方法的对象，创建一个 『约束构建者』。block里头定义的约束都将加到view上或者合适的父视图上。
 *  Creates a MASConstraintMaker with each view in the callee.
 *  Any constraints defined are added to the view or the appropriate superview once the block has finished executing on each view
 *
 *  @param block scope within which you can build up the constraints which you wish to apply to each view.
 *
 *  @return Array of created MASConstraints
 */
- (NSArray *)mas_makeConstraints:(void (NS_NOESCAPE ^)(MASConstraintMaker *make))block;

/**为调用这个方法的对象，创建一个 『约束构建者』。block里头定义的约束都『更新』到view上或者合适的父视图上。
 *  Creates a MASConstraintMaker with each view in the callee.
 *  Any constraints defined are added to each view or the appropriate superview once the block has finished executing on each view.
 *  If an existing constraint exists then it will be updated instead.
 *
 *  @param block scope within which you can build up the constraints which you wish to apply to each view.
 *
 *  @return Array of created/updated MASConstraints
 */
- (NSArray *)mas_updateConstraints:(void (NS_NOESCAPE ^)(MASConstraintMaker *make))block;

/** 为调用这个方法的对象，创建一个 『约束构建者』。block里头定义的约束都将『重做』到view上或者合适的父视图上。
 *  Creates a MASConstraintMaker with each view in the callee.
 *  Any constraints defined are added to each view or the appropriate superview once the block has finished executing on each view.
 *  All constraints previously installed for the views will be removed.
 *
 *  @param block scope within which you can build up the constraints which you wish to apply to each view.
 *
 *  @return Array of created/updated MASConstraints
 */
- (NSArray *)mas_remakeConstraints:(void (NS_NOESCAPE ^)(MASConstraintMaker *make))block;

/**
 *  distribute with fixed spacing
 *
 *  @param axisType     which axis to distribute items along 方向
 *  @param fixedSpacing the spacing between each item 元素之间间距
 *  @param leadSpacing  the spacing before the first item and the container 首元素与容器间距
 *  @param tailSpacing  the spacing after the last item and the container 尾元素与容器间距
 
 水平：约束视图与容器的top/bottom，并约束height
 view，宽度是会被自动计算的，且各view等宽；
 
 垂直：约束视图与容器的left/right,并约束width
 view，高度是会被自动计算的，且各view等高
 
 */
- (void)mas_distributeViewsAlongAxis:(MASAxisType)axisType withFixedSpacing:(CGFloat)fixedSpacing leadSpacing:(CGFloat)leadSpacing tailSpacing:(CGFloat)tailSpacing;

/**
 *  distribute with fixed item size
 *
 *  @param axisType        which axis to distribute items along 方向
 *  @param fixedItemLength the fixed length of each item 每个元素的长度（水平：w;垂直：h）
 *  @param leadSpacing     the spacing before the first item and the container 首元素与容器间距
 *  @param tailSpacing     the spacing after the last item and the container 尾元素与容器间距
 
 水平：约束视图与容器的top/bottom，并约束height
 视图间距是自动计算的。
 
 垂直：约束视图与容器的left/right,并约束width
 item之间间距是自动计算的。
 
 */
- (void)mas_distributeViewsAlongAxis:(MASAxisType)axisType withFixedItemLength:(CGFloat)fixedItemLength leadSpacing:(CGFloat)leadSpacing tailSpacing:(CGFloat)tailSpacing;

@end
