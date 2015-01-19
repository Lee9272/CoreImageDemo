//
//  ViewController.m
//  CoreImageDemo
//
//  Created by Lee on 1/19/15.
//  Copyright (c) 2015 Scau. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()
@property (weak, nonatomic) IBOutlet UIImageView *imageView1;
@property (weak, nonatomic) IBOutlet UIImageView *imageView2;
@property (weak, nonatomic) IBOutlet UIImageView *imageView3;
@property (weak, nonatomic) IBOutlet UIImageView *imageView4;
@property (weak, nonatomic) IBOutlet UIImageView *imageView5;
@property (weak, nonatomic) IBOutlet UIImageView *imageView6;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    UIImage *originalImage = [UIImage imageNamed:@"clothes"];
    
    self.imageView1.image = originalImage;
    self.imageView2.image = [self blurImage:originalImage];
    self.imageView3.image = [self tintImage:originalImage withRed:100 green:100 blue:100];
    self.imageView4.image = [self invertImageColor:originalImage];
    self.imageView5.image = [self imageEffectMono:originalImage];
    self.imageView6.image = [self distortImage:originalImage];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (UIImage *)blurImage:(UIImage *)inputImage
{
    CIContext *context = [CIContext contextWithOptions:nil];
    
    CIImage *image = [CIImage imageWithCGImage:inputImage.CGImage];
    CIFilter *filter = [CIFilter filterWithName:@"CIGaussianBlur"];
    [filter setValue:image forKey:kCIInputImageKey];
    [filter setValue:@(2) forKey:kCIInputRadiusKey];
    
    CIImage *result = [filter outputImage];
    CGRect rect = [result extent];
    CGImageRef cgImage = [context createCGImage:result fromRect:rect];
    
    return [UIImage imageWithCGImage:cgImage];
}

- (UIImage *)tintImage:(UIImage *)inputImage withRed:(CGFloat)r green:(CGFloat)g blue:(CGFloat)b
{
    CIContext *context = [CIContext contextWithOptions:nil];
    
    CIImage *image = [CIImage imageWithCGImage:inputImage.CGImage];
    CIFilter *filter = [CIFilter filterWithName:@"CIColorMatrix"];
    [filter setValue:image forKey:kCIInputImageKey];
    
    CIVector *rVector = [CIVector vectorWithX:r/255 Y:0 Z:0 W:0];
    CIVector *gVector = [CIVector vectorWithX:0 Y:g/255 Z:0 W:0];
    CIVector *bVector = [CIVector vectorWithX:0 Y:0 Z:b/255 W:0];
    [filter setValue:rVector forKey:@"inputRVector"];
    [filter setValue:gVector forKey:@"inputGVector"];
    [filter setValue:bVector forKey:@"inputBVector"];
    CIImage *result = [filter outputImage];
    CGRect rect = [result extent];
    
    CGImageRef cgImage = [context createCGImage:result fromRect:rect];
    
    return [UIImage imageWithCGImage:cgImage];
}

- (UIImage *)invertImageColor:(UIImage *)inputImage
{
    CIContext *context = [CIContext contextWithOptions:nil];
    
    CIImage *image = [CIImage imageWithCGImage:inputImage.CGImage];
    CIFilter *filter = [CIFilter filterWithName:@"CIColorInvert"];
    [filter setValue:image forKey:kCIInputImageKey];
    
    CIImage *result = [filter outputImage];
    CGRect rect = [result extent];
    CGImageRef cgImage = [context createCGImage:result fromRect:rect];
    
    return [UIImage imageWithCGImage:cgImage];
}

- (UIImage *)imageEffectMono:(UIImage *)inputImage
{
    CIContext *context = [CIContext contextWithOptions:nil];
    
    CIImage *image = [CIImage imageWithCGImage:inputImage.CGImage];
    CIFilter *filter = [CIFilter filterWithName:@"CIPhotoEffectMono"];
    [filter setValue:image forKey:kCIInputImageKey];
    
    CIImage *result = [filter outputImage];
    CGRect rect = [result extent];
    CGImageRef cgImage = [context createCGImage:result fromRect:rect];
    
    return [UIImage imageWithCGImage:cgImage];
}

- (UIImage *)distortImage:(UIImage *)inputImage
{
    CIContext *context = [CIContext contextWithOptions:nil];
    
    CIImage *image = [CIImage imageWithCGImage:inputImage.CGImage];
    CIFilter *filter = [CIFilter filterWithName:@"CIBumpDistortion"];
    [filter setValue:image forKey:kCIInputImageKey];
    
    CIImage *result = [filter outputImage];
    CGRect rect = [result extent];
    CGImageRef cgImage = [context createCGImage:result fromRect:rect];
    
    return [UIImage imageWithCGImage:cgImage];
}

@end
