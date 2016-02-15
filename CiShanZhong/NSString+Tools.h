//
//  NSString+Tools.h
//  KillAllFree
//
//  Created by JackWong on 15/9/24.
//  Copyright (c) 2015年 JackWong. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
@interface NSString (Tools)
NSString * URLEncodedString(NSString *str);
NSString * MD5Hash(const char *aStrin);
NSString * MD5(NSString *aString);
/**
 *  计算字符串 CGSize
 *
 *  @param font    字符串的 font
 *  @param maxSize  字符串的最大显示的 CGSize
 *
 *  @return  字符串实际的CGSize
 */
- (CGSize)sizeWithFont:(UIFont *)font maxSize:(CGSize)maxSize;
@end
