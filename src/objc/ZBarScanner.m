/*
 * ZBarScanner.m
 * libzbar-ios
 *
 * Created by Árpád Goretity on 10/09/2012.
 * Licensed under the 3-clause BSD License
 */

#include <zbar/ZBarScanner.h>
#define BITS_PER_COMPONENT 8

@interface ZBarScanner()
- (void *)createY800BufferFromCGImage:(CGImageRef)img;
@end

@implementation ZBarScanner

@synthesize CGImage;

+ (id)zbarScannerWithCGImage:(CGImageRef)img
{
	return [[[self alloc] initWithCGImage:img] autorelease];
}

- (id)initWithCGImage:(CGImageRef)img
{
	if ((self = [super init])) {
		CGImage = CGImageRetain(img);
		buf = [self createY800BufferFromCGImage:CGImage];
		size_t width = CGImageGetWidth(CGImage);
		size_t height = CGImageGetHeight(CGImage);

		/* create and enable the scanner */
		scanner = zbar_image_scanner_create();
		zbar_image_scanner_set_config(scanner, 0, ZBAR_CFG_ENABLE, 1);

		/* create the ZBar image */
		image = zbar_image_create();
		zbar_image_set_format(image, *(uint32_t *)"Y800");
		zbar_image_set_size(image, width, height);
		zbar_image_set_data(image, buf, width * height, NULL);
	}
	return self;
}

- (void)dealloc
{
	zbar_image_scanner_destroy(scanner);
	zbar_image_destroy(image);
	CGImageRelease(CGImage);
	free(buf);
	[super dealloc];
}

- (void)setConfig:(zbar_config_t)conf forSymbology:(zbar_symbol_type_t)sym value:(int)val
{
	zbar_image_scanner_set_config(scanner, sym, conf, val);
}

- (NSArray *)scan
{
	NSMutableArray *arr = [NSMutableArray array];
	zbar_scan_image(scanner, image);

	/* extract results */
	const zbar_symbol_t *symbol;
	for (
		symbol = zbar_image_first_symbol(image);
		symbol != NULL;
		symbol = zbar_symbol_next(symbol)
	) {
		zbar_symbol_type_t type = zbar_symbol_get_type(symbol);
		const char *data = zbar_symbol_get_data(symbol);
		NSNumber *typeNum = [NSNumber numberWithInt:(int)type];
		NSString *text = [NSString stringWithUTF8String:data];
		NSDictionary *dict = [NSDictionary dictionaryWithObjectsAndKeys:
			typeNum,
			kZBarResultTypeKey,
			text,
			kZBarResultTextKey,
		nil];
		[arr addObject:dict];
	}
	return arr;
}

// Private methods

- (void *)createY800BufferFromCGImage:(CGImageRef)img
{
	size_t width = CGImageGetWidth(img);
	size_t height = CGImageGetHeight(img);

	CGRect rect = CGRectMake(0, 0, width, height);
	CGColorSpaceRef colorSpace = CGColorSpaceCreateDeviceGray();

	void *data = malloc(width * height);

	CGContextRef ctx = CGBitmapContextCreate(
		data,
		width,
		height,
		BITS_PER_COMPONENT,
		width * BITS_PER_COMPONENT / 8,
		colorSpace,
		kCGImageAlphaNone
	);
	CGContextDrawImage(ctx, rect, img);

	CGColorSpaceRelease(colorSpace);
	CGContextRelease(ctx);

	return data;
}

@end
