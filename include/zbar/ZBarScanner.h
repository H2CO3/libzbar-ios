/*
 * ZBarScanner.h
 * libzbar-ios
 *
 * Created by Árpád Goretity on 10/09/2012.
 * Licensed under the 3-clause BSD License
 */

#ifndef __ZBARSCANNER_H__
#define __ZBARSCANNER_H__

#include <zbar.h>
#include <CoreGraphics/CoreGraphics.h>
#include <Foundation/Foundation.h>

#define kZBarResultTypeKey @"kZBarResultTypeKey"
#define kZBarResultTextKey @"kZBarResultTextKey"

@interface ZBarScanner: NSObject {
	CGImageRef CGImage;
	zbar_image_t *image;
	zbar_image_scanner_t *scanner;
	void *buf;
}

@property (nonatomic, readonly) CGImageRef CGImage;

+ (id)zbarScannerWithCGImage:(CGImageRef)img;

- (id)initWithCGImage:(CGImageRef)img;
- (void)setConfig:(zbar_config_t)conf forSymbology:(zbar_symbol_type_t)sym value:(int)val;
- (NSArray *)scan;

@end

#endif /* __ZBARSCANNER_H__ */
