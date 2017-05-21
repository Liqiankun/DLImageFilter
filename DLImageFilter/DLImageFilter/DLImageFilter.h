//
//  DLImageFilter.h
//  DLImageFilter
//
//  Created by FT_David on 2017/5/21.
//  Copyright © 2017年 FT_David. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import <CoreImage/CoreImage.h>
#import <CoreGraphics/CoreGraphics.h>
@interface DLImageFilter : NSObject

+(unsigned char*)covertImageToData:(UIImage *)image;

+(unsigned char *)imageGrayWithData:(unsigned char *)imageData size:(CGSize)size;

+(unsigned char *)imageRecolorWithData:(unsigned char *)imageData size:(CGSize)size;

+(unsigned char *)imageHightlightWithData:(unsigned char *)imageData size:(CGSize)size;

+(UIImage *)covertDataToImage:(unsigned char*)imageData image:(UIImage *)image;




@end
