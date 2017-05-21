//
//  DLImageFilter.m
//  DLImageFilter
//
//  Created by FT_David on 2017/5/21.
//  Copyright © 2017年 FT_David. All rights reserved.
//

#import "DLImageFilter.h"

@implementation DLImageFilter

+(unsigned char *)imageGrayWithData:(unsigned char *)imageData size:(CGSize)size{
    unsigned char *resultData = malloc(size.width * size.height * sizeof(unsigned char) * 4);
    memset(resultData, 0,size.width * size.height * sizeof(unsigned char) * 4);
    
    for (int h = 0 ; h < size.height; h++) {
        for (int w = 0;  w < size.width; w++) {
            unsigned int imageIndex = h * size.width + w;
            unsigned char bitmapRed = *(imageData + imageIndex * 4);
            unsigned char bitmapGreen = *(imageData + imageIndex * 4 + 1);
            unsigned char bitmapBlue = *(imageData + imageIndex * 4 + 2);
            
            int bitmap = bitmapRed * 77 / 255 +  bitmapGreen * 151 / 255 + bitmapBlue * 88 / 255;
            unsigned char newBitmap = bitmap > 255 ? 255 : bitmap;
            memset(resultData + imageIndex * 4, newBitmap,1);
            memset(resultData + imageIndex * 4 + 1, newBitmap,1);
            memset(resultData + imageIndex * 4 + 2, newBitmap,1);
        }
    }
    return resultData;
}

+(unsigned char *)imageRecolorWithData:(unsigned char *)imageData size:(CGSize)size
{
    unsigned char *resultData = malloc(size.width * size.height * sizeof(unsigned char) * 4);
    memset(resultData, 0,size.width * size.height * sizeof(unsigned char) * 4);
    
    for (int h = 0 ; h < size.height; h++) {
        for (int w = 0;  w < size.width; w++) {
            unsigned int imageIndex = h * size.width + w;
            unsigned char bitmapRed = *(imageData + imageIndex * 4);
            unsigned char bitmapGreen = *(imageData + imageIndex * 4 + 1);
            unsigned char bitmapBlue = *(imageData + imageIndex * 4 + 2);
            
            
             memset(resultData + imageIndex * 4, (255 - bitmapRed),1);
            memset(resultData + imageIndex * 4 + 1, (255 -  bitmapGreen),1);
            memset(resultData + imageIndex * 4 + 2, (255 -  bitmapBlue),1);
        }
    }
    return resultData;
}

+(unsigned char *)imageHightlightWithData:(unsigned char *)imageData size:(CGSize)size
{
    unsigned char *resultData = malloc(size.width * size.height * sizeof(unsigned char) * 4);
    memset(resultData, 0,size.width * size.height * sizeof(unsigned char) * 4);
    NSArray *colorArrayBase =  @[@"55",@"110",@"155",@"185",@"220",@"240",@"250",@"255"];
    NSMutableArray *colorArray = [NSMutableArray array];
    int beforeNum = 0;
    for (int i = 0;  i < 8; i++) {
        NSString *numStr = colorArrayBase[i];
        int num = numStr.intValue;
        float step = 0;
        if (i == 0) {
            step = num / 32.0;
            beforeNum = num;
        }else{
            step = (num - beforeNum) / 32.0;
            
        }
        for (int j = 0; j < 32; j++) {
            int newNum = 0;
            if (i == 0) {
                newNum = (int)(j * step);
            }else{
                newNum = (int)(beforeNum + j * step);
            }
            NSString *newNumStr = [NSString stringWithFormat:@"%d",newNum];
            [colorArray addObject:newNumStr];
        }
        beforeNum = num;
    }
    for (int h = 0 ; h < size.height; h++) {
        for (int w = 0;  w < size.width; w++) {
            unsigned int imageIndex = h * size.width + w;
            unsigned char bitmapRed = *(imageData + imageIndex * 4);
            unsigned char bitmapGreen = *(imageData + imageIndex * 4 + 1);
            unsigned char bitmapBlue = *(imageData + imageIndex * 4 + 2);
            
            NSString *redStr = [colorArray objectAtIndex:bitmapRed];
            NSString *greenStr = [colorArray objectAtIndex:bitmapGreen];
            NSString *blueStr = [colorArray objectAtIndex:bitmapBlue];
            
            memset(resultData + imageIndex * 4, redStr.intValue,1);
            memset(resultData + imageIndex * 4 + 1, greenStr.intValue,1);
            memset(resultData + imageIndex * 4 + 2, blueStr.intValue,1);
        }
    }
    return resultData;
}

+(unsigned char*)covertImageToData:(UIImage *)image
{
    CGSize imageSize = image.size;
    CGColorSpaceRef colorSpace = CGColorSpaceCreateDeviceRGB();
    CGImageRef imageRef = [image CGImage];
    void *data = malloc(imageSize.width * imageSize.height * 4);
    CGContextRef contextRef = CGBitmapContextCreate(data, imageSize.width, imageSize.height, 8, 4 * imageSize.width, colorSpace, kCGImageAlphaPremultipliedLast | kCGImageByteOrder32Big);
    CGContextDrawImage(contextRef, CGRectMake(0, 0, imageSize.width, imageSize.height), imageRef);
    CGColorSpaceRelease(colorSpace);
    CGContextRelease(contextRef);
    return (unsigned char*)data;
}

+(UIImage *)covertDataToImage:(unsigned char*)imageData image:(UIImage *)image{
    CGFloat width = image.size.width;
    CGFloat height = image.size.height;
    NSInteger dataLength = 4 * width * height;
    CGDataProviderRef providerRef = CGDataProviderCreateWithData(NULL, imageData, dataLength, NULL);
    
    int bitsPreCompent = 8;
    int bitsPrePixel = 32;
    int bytesPreRwo = 4 * width;
    CGColorSpaceRef colorSpace = CGColorSpaceCreateDeviceRGB();
    CGBitmapInfo bitmapInfo  = kCGBitmapByteOrderDefault;
    CGColorRenderingIntent renderIntent = kCGRenderingIntentDefault;
    
    CGImageRef imageRef = CGImageCreate(width, height, bitsPreCompent, bitsPrePixel, bytesPreRwo, colorSpace, bitmapInfo, providerRef, NULL, NO, renderIntent);
    
    UIImage *imageNew = [UIImage imageWithCGImage:imageRef];
    
    CFRelease(imageRef);
    CGColorSpaceRelease(colorSpace);
    CGDataProviderRelease(providerRef);
    
    return imageNew ;
}


@end
