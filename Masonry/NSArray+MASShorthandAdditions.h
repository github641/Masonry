//
//  NSArray+MASShorthandAdditions.h
//  Masonry
//
//  Created by Jonas Budelmann on 22/07/13.
//  Copyright (c) 2013 Jonas Budelmann. All rights reserved.
//

#import "NSArray+MASAdditions.h"
// lzy170927注：仅仅当这个宏被用户定义时，这个文件才有实质内容。
#ifdef MAS_SHORTHAND

/* lzy170927注:用法。
 
 一般在pch文件中，或者在导入头文件 Masonry.h之前，定义这个宏
 //define this constant if you want to use Masonry without the 'mas_' prefix
 #define MAS_SHORTHAND
 #import "Masonry.h"
 
 */
/** view写约束的 快捷方式：可以不必写 「mas_」这个前缀。
 *    Shorthand view additions without the 'mas_' prefixes,
 *  only enabled if MAS_SHORTHAND is defined
 */
@interface NSArray (MASShorthandAdditions)

- (NSArray *)makeConstraints:(void(^)(MASConstraintMaker *make))block;
- (NSArray *)updateConstraints:(void(^)(MASConstraintMaker *make))block;
- (NSArray *)remakeConstraints:(void(^)(MASConstraintMaker *make))block;

@end

@implementation NSArray (MASShorthandAdditions)
// 定义了快捷写法，那么用户调用的方法是-makeConstraints:，它内部还是调用-mas_makeConstraints: 另外两个方法类似。
- (NSArray *)makeConstraints:(void(^)(MASConstraintMaker *))block {
    return [self mas_makeConstraints:block];
}

- (NSArray *)updateConstraints:(void(^)(MASConstraintMaker *))block {
    return [self mas_updateConstraints:block];
}

- (NSArray *)remakeConstraints:(void(^)(MASConstraintMaker *))block {
    return [self mas_remakeConstraints:block];
}

@end

#endif
