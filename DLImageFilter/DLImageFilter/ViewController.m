//
//  ViewController.m
//  DLImageFilter
//
//  Created by FT_David on 2017/5/21.
//  Copyright © 2017年 FT_David. All rights reserved.
//

#import "ViewController.h"
#import "DLImageFilter.h"
@interface ViewController ()
@property (weak, nonatomic) IBOutlet UIImageView *imageView;
@property (weak, nonatomic) IBOutlet UIImageView *imageView_two;
@property (weak, nonatomic) IBOutlet UIImageView *imageView_three;
@property (weak, nonatomic) IBOutlet UIImageView *imageView_four;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self testImageFunc];
}

-(void)testImageFunc
{
    UIImage *image = self.imageView.image;
    unsigned char *imageData = [DLImageFilter covertImageToData:image];
    unsigned char *grayImage = [DLImageFilter imageGrayWithData:imageData size:image.size];
    UIImage *imageGray = [DLImageFilter covertDataToImage:grayImage image:image];
    self.imageView_two.image = imageGray;
    
    unsigned char *recolorData = [DLImageFilter imageRecolorWithData:imageData size:image.size];
    UIImage *recolorImage = [DLImageFilter covertDataToImage:recolorData image:image];
    self.imageView_three.image = recolorImage;
    
    unsigned char *hightlightData = [DLImageFilter imageHightlightWithData:imageData size:image.size];
    UIImage *highlightImage = [DLImageFilter covertDataToImage:hightlightData image:image];
    self.imageView_four.image = highlightImage;
    
    
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
